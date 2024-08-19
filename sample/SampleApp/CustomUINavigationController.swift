//
//  CustomUINavigationController.swift
//
//  Copyright © 2024 Jumio Corporation. All rights reserved.
//

import UIKit
import AudioToolbox

import Jumio

protocol CustomUIDelegate: AnyObject {
    func customUIDidFinish(with result: Jumio.Result)
}

class CustomUINavigationController: UINavigationController {
    typealias Delegate = CustomUIDelegate
    
    // MARK: - Properties    
    weak var customUIDelegate: Delegate?
    
    var isConfigured: Bool { credentialHandling?.isConfigured ?? false }
    
    private var controllerHandling: ControllerHandling?
    private var credentialHandling: CredentialHandling?
    private var scanPartHandling: ScanPartHandling?
    private var jumioSDK: Jumio.SDK?
    
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
        // check if addon for this scan part is available
        if credentialHandling?.checkAndStartAddon() ?? false {
            // Addon is available. Don't finish the credential.
            return
        }
        
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
    
    private func instantiate(viewController: ViewController) -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: viewController.rawValue)
        viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "backButton"), style: .plain, target: self, action: #selector(backPressed))
        return viewController
    }
    
    private func pushLoadingViewController(with style: LoadingViewController.Style) {
        guard let loadingViewController = instantiate(viewController: .loading) as? LoadingViewController else { return }
        loadingViewController.style = style
        pushViewController(loadingViewController, animated: true)
    }
    
    private func clean() {
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
        case digitalIdentityView
        case file
        case loading
        case selection
        case acquireMode
        case help
        case retry
    }
}

// MARK: - Controller forwarding
extension CustomUINavigationController {
    func startWorkflow() {
        controllerHandling?.startNextCredential()
    }
    
    func userConsented(consentItems: [Jumio.ConsentItem]) {
        // controllers initialize delegate function delivered a list of consent items.
        // Means controllers .userConsented(to: decision:) needs to be called for each item. In order to be able to
        // start any credential
        for consentItem in consentItems {
            controllerHandling?.userConsented(to: consentItem)
        }
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
    
    func select(acquireMode: Jumio.Acquire.Mode) {
        credentialHandling?.select(acquireMode: acquireMode)
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
    
    func retry(reason: Jumio.Retry.Reason) {
        scanPartHandling?.retry(reason: reason)
    }
    
    func cancelScanPart() {
        scanPartHandling?.cancel()
        scanPartFinished()
    }
}

// MARK: - ScanPart forwarding
extension CustomUINavigationController {
    var hasFallback: Bool { scanPartHandling?.hasFallback ?? false }
    var credentialPart: String {
        guard let credentialPart = scanPartHandling?.credentialPart else { return "" }
        switch credentialPart {
        case .front: return "Front"
        case .back: return "Back"
        case .face: return "Face"
        case .nfc: return "NFC"
        case .multipart: return "Multi Part"
        case .document: return "Document"
        case .digital: return "Digital"
        default: return "unknown"
        }
    }
    var scanMode: String {
        guard let scanMode = scanPartHandling?.scanMode else { return "" }
        switch scanMode {
        case .manual: return "Manual"
        case .barcode: return "Barcode"
        case .nfc: return "NFC"
        case .faceManual: return "Face manual"
        case .faceIProov: return "Face iProov"
        case .docFinder: return "Doc Finder"
        case .web: return "Web"
        default: return "unknown"
        }
    }
    
    func attach(scanView: Jumio.Scan.View) {
        scanPartHandling?.attach(scanView: scanView)
    }
    
    func attach(digitalIdentityView: Jumio.DigitalIdentity.View) {
        scanPartHandling?.attach(digitalIdentityView: digitalIdentityView)
    }
    
    func attach(fileAttacher: Jumio.FileAttacher) {
        scanPartHandling?.attach(fileAttacher: fileAttacher)
    }
    
    func attach(confirmationHandler: Jumio.Confirmation.Handler) {
        scanPartHandling?.attach(confirmationHandler: confirmationHandler)
    }
    
    func attach(rejectHandler: Jumio.Reject.Handler) {
        scanPartHandling?.attach(rejectHandler: rejectHandler)
    }
    
    func startNextScanPart() {
        credentialHandling?.startNextScanPart(previousCredentialPart: scanPartHandling?.credentialPart)
    }
    
    func fallback() {
        scanPartHandling?.fallback()
    }
}

// MARK: - ControllerHandling.Delegate
extension CustomUINavigationController: ControllerHandling.Delegate {
    func controller(consentItems: [Jumio.ConsentItem]) {
        guard let start = topViewController as? StartViewController else { return }
        start.handle(consentItems: consentItems)
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
    func credentialNeedsConfiguration(for countries: [String]) {
        guard let selectionViewController = instantiate(viewController: .selection) as? SelectionViewController else { return }
        selectionViewController.countryArray = countries
        selectionViewController.delegate = self
        pushViewController(selectionViewController, animated: true)
    }
    
    func credentialNeedsConfiguration(for acquireModes: [Jumio.Acquire.Mode]) {
        guard let selectionViewController = instantiate(viewController: .acquireMode) as? AcquireModeViewController else { return }
        selectionViewController.modes = acquireModes
        pushViewController(selectionViewController, animated: true)
    }
    
    func credential(initialized scanPartHandling: ScanPartHandling) {
        self.scanPartHandling?.clean()
        self.scanPartHandling = scanPartHandling
        scanPartHandling.delegate = self
    }
}

// MARK: - ScanPartHandling.Delegate
extension CustomUINavigationController: ScanPartHandling.Delegate {
    func scanPartShowLoadingView() {
        pushLoadingViewController(with: .loading)
    }
    
    func scanPartShowHelpView() {
        guard let helpViewController = instantiate(viewController: .help) as? HelpViewController else { return }
        helpViewController.helpView = scanPartHandling?.helpView()
        pushViewController(helpViewController, animated: true)
    }
    
    func scanPartShowScanView() {
        guard let scanViewController = instantiate(viewController: .scan) as? ScanViewController else { return }
        pushViewController(scanViewController, animated: true)
    }
    
    func scanPartShowDigitalIdentityView() {
        guard let scanViewController = instantiate(viewController: .digitalIdentityView) as? DigitalIdentityViewController else { return }
        pushViewController(scanViewController, animated: true)
    }
    
    func scanPartThirdPartyVerification() {
        guard let scanViewController = topViewController as? DigitalIdentityViewController else { return }
        scanViewController.showProcessing()
    }
    
    func scanPartAttachFile() {
        guard
            (topViewController as? FileViewController) == nil,
            let fileViewController = instantiate(viewController: .file) as? FileViewController
        else {
            return
        }
        pushViewController(fileViewController, animated: true)
    }
    
    func scanPartShowProcessing() {
        guard let scanViewController = topViewController as? ScanViewController else { return }
        scanViewController.showProcessing()
        
        // we suggest to add a vibration on processing as it signals the user that the image
        // has been captured successfully and we move on to the next step
        AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
    }
    
    func scanPartNextPart() {
        guard let scanViewController = topViewController as? ScanViewController else { return }
        scanViewController.updateView()
        scanViewController.showFlipView()
        
        // we suggest to add a vibration on nextPart as it signals the user that the image
        // has been captured successfully and we move on to the next part
        AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
    }
    
    func scanPartNextPartEnd() {
        guard let scanViewController = topViewController as? ScanViewController else { return }
        scanViewController.hideFlipView()
    }
    
    func scanPartShowConfirmationView() {
        showConfirmationViewController(with: .confirm)
    }
    
    func scanPartShowRejectView() {
        showConfirmationViewController(with: .reject)
    }
    
    func scanPartShowRetryView(with reason: Jumio.Retry.Reason) {
        guard let retryViewController = instantiate(viewController: .retry) as? RetryViewController else { return }
        retryViewController.reason = reason
        pushViewController(retryViewController, animated: true)
    }
    
    func scanPartDidFallback() {
        guard let scanViewController = topViewController as? ScanViewController else { return }
        scanViewController.updateView()
    }
    
    func scanPartShowExtractionState(with extractionState: Jumio.Scan.Update.ExtractionState, and data: Any?) {
        guard let scanViewController = topViewController as? ScanViewController else { return }
        var message = ""
        switch extractionState {
        case .centerId: message = "CENTER_ID"
        case .centerFace: message = "CENTER_FACE"
        case .tooClose: message = "TOO_CLOSE"
        case .faceTooClose: message = "FACE_TOO_CLOSE"
        case .moveCloser: message = "MOVE_CLOSER"
        case .moveFaceCloser: message = "MOVE_FACE_CLOSER"
        case .levelEyesAndDevice: message = "LEVEL_EYES_AND_DEVICE"
        case .holdStraight: message = "HOLD_STRAIGHT"
        case .holdStill: message = "HOLD_STILL"
        case .tilt:
            guard let tilt = data as? Jumio.Scan.Update.TiltState else { return }
            message = "TILT TO: \(tilt.target), CURRENT ANGLE: \(tilt.current)"
        @unknown default: assertionFailure("unknown extraction state")
        }
        scanViewController.updateExtractionState(message: message)
    }
    
    func scanPartFinished() {
        nextScanPartOrFinishCredential()
    }
    
    private func showConfirmationViewController(with style: ConfirmationViewController.Style) {
        guard let viewController = instantiate(viewController: .confirmation) as? ConfirmationViewController else { return }
        viewController.style = style
        pushViewController(viewController, animated: true)
    }
}

extension CustomUINavigationController: SelectionViewControllerDelegate {
    func selectionViewController(_ sender: SelectionViewController, physicalDocumentsFor country: String) -> [Jumio.Document.Physical] {
        credentialHandling?.physicalDocuments(for: country) ?? []
    }
    
    func selectionViewController(_ sender: SelectionViewController, digitalDocumentsFor country: String) -> [Jumio.Document.Digital] {
        credentialHandling?.digitalDocuments(for: country) ?? []
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
