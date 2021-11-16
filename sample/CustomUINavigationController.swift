//
//  CustomUINavigationController.swift
//  SampleApp-UIKit
//
//  Created by Christian Henzl on 08.08.21.
//

import UIKit
import Jumio

protocol CustomUIDelegate: AnyObject {
    func customUIDidFinish(with result: Jumio.Result)
}

class CustomUINavigationController: UINavigationController {
    typealias Delegate = CustomUIDelegate
    
    // MARK: - Properties    
    weak var customUIDelegate: Delegate?
    
    var isConfigured: Bool { credentialHandling?.isConfigured ?? false }
    
    fileprivate var controllerHandling: ControllerHandling?
    fileprivate var credentialHandling: CredentialHandling?
    fileprivate var scanPartHandling: ScanPartHandling?
    fileprivate var jumioSDK: Jumio.SDK?
    
    // MARK: -
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: - Functions
    func start(with token: String, dataCenter: Jumio.DataCenter) {
        controllerHandling = ControllerHandling()
        controllerHandling?.delegate = self
        // creating a new Jumio SDK instance
        jumioSDK = Jumio.SDK()
        // setting created one time token
        jumioSDK?.token = token
        // setting corresponding data center
        jumioSDK?.dataCenter = dataCenter
        // let controller handling do the actual start call
        // as a controller instance will be returned
        controllerHandling?.start(sdk: jumioSDK)
    }
    
    func nextCredentialOrFinishController() {
        // check if controller can be finished (means all credentials got finished)
        if controllerHandling?.isComplete ?? false {
            // yes: finish controller => workflow is finished
            controllerHandling?.finish()
            pushLoadingViewController(with: .uploading)
        } else {
            // no: start next credential
            startNextCredential()
        }
    }
    
    func nextScanPartOrFinishCredential() {
        // check if credential can be finished (means all scan parts got finished)
        if credentialHandling?.isComplete ?? false {
            // yes: finish credential
            credentialHandling?.finish()
            // start next credential or check if controller can be finished
            nextCredentialOrFinishController()
        } else {
            // no: start next scan part
            startNextScanPart()
        }
    }
    
    fileprivate func instantiate(viewController: ViewController) -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: viewController.rawValue)
        viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "backButton"), style: .plain, target: self, action: #selector(backPressed))
        return viewController
    }
    
    fileprivate func pushLoadingViewController(with style: LoadingViewController.Style) {
        guard let loadingViewController = instantiate(viewController: .loading) as? LoadingViewController else { return }
        loadingViewController.style = style
        pushViewController(loadingViewController, animated: true)
    }
    
    fileprivate func clean() {
        // clean all leftovers, all jumio instances should be set to nil to avoid any memory leaks
        // by still holding a strong reference to our instances
        controllerHandling?.clean()
        controllerHandling = nil
        
        credentialHandling?.clean()
        credentialHandling = nil
        
        scanPartHandling?.clean()
        scanPartHandling = nil
        
        jumioSDK = nil
    }
    
    @objc
    func backPressed() {
        // This is only a example implementation on how a user can cancel a started workflow
        controllerHandling?.cancel()
        dismiss(animated: true)
    }
}

// MARK: - ViewController
extension CustomUINavigationController {
    enum ViewController: String {
        case error
        case confirmation
        case scan
        case loading
        case selection
    }
}

// MARK: - Controller forwarding
extension CustomUINavigationController {
    func startWorkflow() {
        controllerHandling?.startNextCredential()
    }
    
    func userConsented() {
        // controllers initialize delegate function delivered a policy url.
        // Means controllers .userConsented() needs to be called. In order to be able to
        // start any credential
        controllerHandling?.userConsented()
    }
    
    func cancel() {
        controllerHandling?.cancel()
        dismiss(animated: true)
    }
}

// MARK: - Credential forwarding
extension CustomUINavigationController {
    // for ID credentials we are exposing a suggested country
    // This information can be used to already show documents of suggested country
    // and skip a country selection if needed
    var suggestedCountry: String? { credentialHandling?.suggestedCountry }
    
    func select(country: String, document: Jumio.Document) {
        credentialHandling?.select(country: country, document: document)
    }
    
    func startNextCredential() {
        var previousInfo: Jumio.Credential.Info?
        if credentialHandling != nil {
            previousInfo = credentialHandling?.info
            credentialHandling?.clean()
            credentialHandling = nil
        }
        controllerHandling?.startNextCredential(previousInfo: previousInfo)
    }
    
    func retry(error: Jumio.Error) {
        controllerHandling?.retry(error: error)
    }
}

// MARK: - ScanPart forwarding
extension CustomUINavigationController {
    var hasFallback: Bool { scanPartHandling?.hasFallback ?? false }
    var scanSide: String {
        guard let scanSide = scanPartHandling?.scanSide else { return "" }
        switch scanSide {
        case .front: return "Front"
        case .back: return "Back"
        case .face: return "Face"
        default: return "unknown"
        }
    }
    var scanMode: String {
        guard let scanMode = scanPartHandling?.scanMode else { return "" }
        switch scanMode {
        case .manual: return "Manual"
        case .lineFinder: return "LineFinder"
        case .barcode: return "Barcode"
        case .mrz: return "MRZ"
        case .faceManual: return "Face manual"
        case .faceIProov: return "Face iProov"
        default: return "unknown"
        }
    }
    
    func attach(scanView: Jumio.Scan.View) {
        scanPartHandling?.attach(scanView: scanView)
    }
    
    func attach(confirmationView: Jumio.Confirmation.View) {
        scanPartHandling?.attach(confirmationView: confirmationView)
    }
    
    func attach(rejectView: Jumio.Reject.View) {
        scanPartHandling?.attach(rejectView: rejectView)
    }
    
    func startNextScanPart() {
        var previousScanSide: Jumio.Scan.Side?
        if scanPartHandling != nil {
            previousScanSide = scanPartHandling?.scanSide
            scanPartHandling?.clean()
            scanPartHandling = nil
        }
        credentialHandling?.startNextScanPart(previousScanSide: previousScanSide)
    }
    
    func fallback() {
        scanPartHandling?.fallback()
    }
}

// MARK: - ControllerHandling.Delegate
extension CustomUINavigationController: ControllerHandling.Delegate {
    func controller(policyUrl: String) {
        guard let start = topViewController as? StartViewController else { return }
        start.handle(policyUrl: policyUrl)
    }
    
    func controller(overview: [String]) {
        guard let start = topViewController as? StartViewController else { return }
        start.display(overviewItems: overview)
    }
    
    func controller(finished result: Jumio.Result) {
        dismiss(animated: true) { [weak self] in
            self?.customUIDelegate?.customUIDidFinish(with: result)
            self?.clean()
        }
    }
    
    func controller(displayError: Jumio.Error) {
        guard let errorViewController = instantiate(viewController: .error) as? ErrorViewController else { return }
        errorViewController.error = displayError
        pushViewController(errorViewController, animated: true)
    }
    
    func controller(initialized credentialHandling: CredentialHandling) {
        self.credentialHandling = credentialHandling
        credentialHandling.delegate = self
    }
}

// MARK: - CredentialHandling.Delegate
extension CustomUINavigationController: CredentialHandling.Delegate {
    func credentialNeedsConfiguration(for countries: [String: [Jumio.Document]]) {
        guard let selectionViewController = instantiate(viewController: .selection) as? SelectionViewController else { return }
        selectionViewController.countryMap = countries
        pushViewController(selectionViewController, animated: true)
    }
    
    func credential(initialized scanPartHandling: ScanPartHandling) {
        self.scanPartHandling = scanPartHandling
        scanPartHandling.delegate = self
    }
}

// MARK: - ScanPartHandling.Delegate
extension CustomUINavigationController: ScanPartHandling.Delegate {
    func scanPartShowLoadingView() {
        pushLoadingViewController(with: .loading)
    }
    
    func scanPartShowScanView() {
        guard let scanViewController = instantiate(viewController: .scan) as? ScanViewController else { return }
        pushViewController(scanViewController, animated: true)
    }
    
    func scanPartShowImageTaken() {
        guard let scanViewController = topViewController as? ScanViewController else { return }
        scanViewController.showImageTaken()
    }
    
    func scanPartShowProcessing() {
        guard let scanViewController = topViewController as? ScanViewController else { return }
        scanViewController.showProcessing()
    }
    
    func scanPartShowConfirmationView() {
        showConfirmationViewController(with: .confirm)
    }
    
    func scanPartShowRejectView() {
        showConfirmationViewController(with: .reject)
    }
    
    func scanPartDidFallback() {
        guard let scanViewController = topViewController as? ScanViewController else { return }
        scanViewController.updateView()
    }
    
    func scanPartShowLegalHint(with message: String) {
        guard let scanViewController = topViewController as? ScanViewController else { return }
        scanViewController.presentLegalHint(with: message)
    }
    
    func scanPartFinished() {
        nextScanPartOrFinishCredential()
    }
    
    fileprivate func showConfirmationViewController(with style: ConfirmationViewController.Style) {
        guard let viewController = instantiate(viewController: .confirmation) as? ConfirmationViewController else { return }
        viewController.style = style
        pushViewController(viewController, animated: true)
    }
}

// MARK: - UINavigationController & UIViewController convenience
extension UINavigationController {
    func asCustomUI() -> CustomUINavigationController? {
        return self as? CustomUINavigationController
    }
}

extension UIViewController {
    var customUI: CustomUINavigationController? { navigationController?.asCustomUI() }
}
