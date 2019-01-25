//
//  NetverifyCustomUIViewController.swift
//
//  Copyright © 2019 Jumio Corporation. All rights reserved.
//

import Netverify

class NetverifyCustomUIViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, NetverifyUIControllerDelegate, NetverifyCustomScanViewControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet var captureControlsView: UIView!
    @IBOutlet weak var mainTitleLabel: UILabel!
    
    // For custom scan view controller
    var isScanning: Bool = false
    var requiresVerification = true
    
    weak var netverifyUIController: NetverifyUIController?
    weak var currentScanView: NetverifyCustomScanViewController?
    weak var verifyInfoView: VerifyInfoView?
    weak var verificationFinishedView: VerificationFinishedView?
    
    var countries = [NetverifyCountry]()
    var currentDocumentType: NetverifyDocumentType?
    
    // MARK: View setup
    override func viewWillAppear(_ animated: Bool) {
        mainTitleLabel.text = requiresVerification ? "Verification" : "Data extraction"
        
        // Show loading circle
        if countries.count == 0 {
            activityIndicator.startAnimating()
        }
        
        self.navigationController?.delegate = self
    }
    
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        if viewController != self {
            self.netverifyUIController?.cancel()
            self.netverifyUIController?.destroy()
            self.netverifyUIController = nil
        }
    }
    
    func addShutterButton(_ netverifyScanViewController: NetverifyCustomScanViewController) {
        let shutterBtn = UIButton()
        shutterBtn.translatesAutoresizingMaskIntoConstraints = false
        shutterBtn.backgroundColor = UIColor.white
        shutterBtn.frame = CGRect(x: 0, y: 0, width: 70, height: 70)
        shutterBtn.layer.cornerRadius = 0.5 * shutterBtn.bounds.size.width
        shutterBtn.addTarget(self, action: #selector(self.shutter_onTouchUp), for: .touchUpInside)
        
        netverifyScanViewController.customOverlayLayer.addSubview(shutterBtn)
        
        // center shutterBtn horizontally in self.currentScanView?.customOverlayLayer
        netverifyScanViewController.customOverlayLayer.addConstraint(NSLayoutConstraint(item: shutterBtn, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: netverifyScanViewController.customOverlayLayer, attribute: NSLayoutAttribute.centerX, multiplier: 1.0, constant: 0.0))
        // align shutterBtn from the bottom
        netverifyScanViewController.customOverlayLayer.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[view]-130-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["view": shutterBtn]))
        // width constraint
        netverifyScanViewController.customOverlayLayer.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[view(==70)]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["view": shutterBtn]))
        // height constraint
        netverifyScanViewController.customOverlayLayer.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[view(==70)]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["view": shutterBtn]))
    }
    
    func addCaptureHelperViews(_ netverifyScanViewController: NetverifyCustomScanViewController, isFallback: Bool) {
        // Add capture controls view
        captureControlsView.translatesAutoresizingMaskIntoConstraints = false
        netverifyScanViewController.customOverlayLayer.addSubview(captureControlsView)
        
        // captureControlsView height constrains
        netverifyScanViewController.customOverlayLayer.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-16-[view(==144)]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["view": captureControlsView]))
        // captureControlsView width constrains
        netverifyScanViewController.customOverlayLayer.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[view]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["view": captureControlsView]))
        
        // Add capture info view
        guard let captureInfoView = Bundle.main.loadNibNamed("CaptureInfoView", owner: self, options: nil)?.first as? CaptureInfoView else { return }
        captureInfoView.setup(documentType: currentDocumentType!)
        captureInfoView.descriptionLabel.text = netverifyScanViewController.localizedShortHelpText()
        captureInfoView.setSteps(current: netverifyScanViewController.currentStep(), total: netverifyScanViewController.totalSteps())
        if isFallback { captureInfoView.addFallbackHandler(action: netverifyScanViewController.switchToFallback) }
        
        captureInfoView.translatesAutoresizingMaskIntoConstraints = false
        netverifyScanViewController.customOverlayLayer.addSubview(captureInfoView)
        
        netverifyScanViewController.customOverlayLayer.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[view(==\(captureInfoView.getContentHeight()))]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["view": captureInfoView]))
        netverifyScanViewController.customOverlayLayer.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[view]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["view": captureInfoView]))
    }
    
    // MARK: NetverifyUIControllerDelegate
    func netverifyUIController(_ netverifyUIController: NetverifyUIController, didFinishInitializingWithError error: NetverifyError?) {
    }
    
    func netverifyUIController(_ netverifyUIController: NetverifyUIController, didDetermineAvailableCountries countries: [Any], suggestedCountry country: NetverifyCountry?) {
        print("available countries determined")
        
        self.netverifyUIController = netverifyUIController
        
        // Hide loading circle
        activityIndicator.stopAnimating()
        
        // Show table after data (countries) are fetched
        self.tableView.isHidden = false
        
        // Display table with countries and documentTypes
        if let _countries = countries as? [NetverifyCountry] {
            self.countries = _countries
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    func netverifyUIController(_ netverifyUIController: NetverifyUIController, didDetermineNextScanViewController scanViewController: NetverifyCustomScanViewController, isFallback: Bool) {
        // Remove old scan view if exists
        self.currentScanView?.dismiss(animated: true, completion: {
            print("ScanView will be dismissed")
        })
        
        print("didDetermineNextScanViewController")
        
        // Sets the vertical offset of the overlay (MRZ, OCR_Card) from the center.
        // scanViewController.verticalRoiOffset = 120.0
        
        scanViewController.customScanViewControllerDelegate = self
        
        self.navigationController?.present(scanViewController, animated: true) {
            self.isScanning = true
            self.currentScanView = scanViewController
            // Add the shutter button if document detection is not enabled
            if scanViewController.isImagePicker() {
                self.addShutterButton(scanViewController)
            }
            
            // Add helper views for the camera capture
            if scanViewController.currentScanMode() == NetverifyScanMode.face {
                self.addFaceMacherHelpersViews(scanViewController)
            } else {
                self.addCaptureHelperViews(scanViewController, isFallback: scanViewController.isFallbackAvailable())
            }
            print("custom scan VC has been presented")
        }
    }
    
    func netverifyUIControllerDidCaptureAllParts(_ netverifyUIController: NetverifyUIController) {
        print("Processing captured documents")
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        // Add the verification finished view when document is captured and the process of data extraction has started
        guard let verificationFinishedView = Bundle.main.loadNibNamed("VerificationFinishedView", owner: self, options: nil)?.first as? VerificationFinishedView else { return }
        self.verificationFinishedView = verificationFinishedView
        verificationFinishedView.frame = self.view.frame
        
        self.currentScanView?.dismiss(animated: false, completion: nil)
        self.view.addSubview(verificationFinishedView)
    }
    
    func netverifyUIController(_ netverifyUIController: NetverifyUIController, didDetermineError error: NetverifyError, retryPossible: Bool) {
        print("didDetermineError: \(error.message ?? "")")
        
        // Handler when error occurs
        let alert = UIAlertController(title: error.code, message: error.message, preferredStyle: UIAlertControllerStyle.alert)
        
        if retryPossible {
            alert.addAction(UIAlertAction(title: "Retry", style: .default, handler: {(_: UIAlertAction!) in netverifyUIController.retryAfterError()}))
        }
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: {(_: UIAlertAction!) in netverifyUIController.cancel()}))
        if self.currentScanView != nil {
            self.currentScanView?.present(alert, animated: true, completion: nil)
        } else {
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func netverifyUIController(_ netverifyUIController: NetverifyUIController, didFinishWith documentData: NetverifyDocumentData, scanReference: String) {
        print("didFinishWithDocumentData")
        
        // Update verification finished view when the data from the captured document was captured
        verificationFinishedView!.setup(documentData: documentData, doneHandler: {() -> Void in
            self.navigationController?.popViewController(animated: true)
            
            netverifyUIController.destroy()
            self.netverifyUIController = nil
        })
    }
    
    func netverifyUIController(_ netverifyUIController: NetverifyUIController, didCancelWithError error: NetverifyError?, scanReference: String?) {
        print("didCancelWithError: \(error?.message ?? "")")
    }
    
    // MARK: NetverifyCustomScanViewControllerDelegate
    func netverifyCustomScanViewController(_ customScanView: NetverifyCustomScanViewController, shouldDisplayLegalAdvice message: String, completion: @escaping () -> Void) {
        
        // Show legal advice
        let alert = UIAlertController(title: "Read This:", message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "I READ THIS", style: .default, handler: {(_: UIAlertAction!) in completion()}))
        customScanView.present(alert, animated: true, completion: nil)
    }
    
    func netverifyCustomScanViewController(_ customScanView: NetverifyCustomScanViewController, shouldDisplayBlurHint message: String) {
        print("netverifyUIController shouldDisplayBlurHint: \(message)")
        let alert = UIAlertController(title: "Hint", message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        customScanView.present(alert, animated: true, completion: nil)
    }
    
    func netverifyCustomScanViewController(_ customScanView: NetverifyCustomScanViewController, shouldDisplayConfirmationWith view: NetverifyConfirmationImageView, text: String, confirmation: (() -> Void)?, retake: (() -> Void)? = nil) {
        print("show confirmation view")
        
        // Document was captured and the user needs to verify if the captured image is valid
        guard let verifyInfoView = Bundle.main.loadNibNamed("VerifyInfoView", owner: self, options: nil)?.first as? VerifyInfoView else { return }
        verifyInfoView.imagePlaceholderView.addSubview(view)
        verifyInfoView.descriptionLabel.text = text
        verifyInfoView.setSteps(current: customScanView.currentStep(), total: customScanView.totalSteps())
        verifyInfoView.addConfirmationHandler(action: confirmation)
        verifyInfoView.addRetakeHandler(actions: [retake!, self.customRetakeHandler])
        
        verifyInfoView.frame = customScanView.customOverlayLayer.frame
        customScanView.customOverlayLayer.addSubview(verifyInfoView)
        self.verifyInfoView = verifyInfoView
        
        customScanView.customOverlayLayer.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[view]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["view":view]))
        customScanView.customOverlayLayer.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[view]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["view":view]))
    }
    
    /**
     * No US Address has been found in the barcode. The scan preview will switch to frontside scanning if available. Check for the changed scan mode and help text. Will only be called on a Fastfill scan.
     **/
    func netverifyCustomScanViewController(_ customScanView: NetverifyCustomScanViewController, shouldDisplayNoUSAddressFoundHint message: String, confirmation: @escaping (() -> Void)) {
        print("netverifyUIController shouldDisplayNoUSAddressFoundHint: \(message)")
        let alert = UIAlertController(title: "Read This:", message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "I READ THIS", style: .default, handler: {(_: UIAlertAction) in
            confirmation()
        }))
        customScanView.present(alert, animated: true, completion: nil)
    }
    
    /**
     * Triggered when a face is found on the backside of an ID or Driver License. This indicates, that the user accidentally scanned the front side with the face image.
     **/
    func netverifyCustomScanViewController(_ customScanView: NetverifyCustomScanViewController, shouldDisplayFlipDocumentHint message: String, confirmation: @escaping (() -> Void)) {
        print("netverifyUIController shouldDisplayFlipDocumentHint: \(message)")
        let alert = UIAlertController(title: "Read This:", message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "I READ THIS", style: .default, handler: {(_: UIAlertAction) in
            confirmation()
        }))
        customScanView.present(alert, animated: true, completion: nil)
    }
    
    // MARK: UITableViewDelegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "nvCustomUICell", for: indexPath)
        cell.textLabel?.text = countries[indexPath.row].name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let country = countries[indexPath.row]
        let alert = UIAlertController(title: country.name, message: "Documents of \(country.name)", preferredStyle: .actionSheet)
        
        let documents = country.documents
        for document in documents {
            var actionTitle = ""
            
            // Determine docuemnt type
            switch document.type {
            case .passport:
                actionTitle = "Passport"
            case .identityCard:
                actionTitle = "Identity Card"
            case .visa:
                actionTitle = "Visa"
            case .driverLicense:
                actionTitle = "Driver License"
            default:
                actionTitle = "Not recognised"
            }
            
            // Determine document variant
            if document.supportsPaperVariant() {
                alert.addAction(UIAlertAction(title: "\(actionTitle) (Other format)", style: .default, handler: {(_: UIAlertAction!) in
                    self.currentDocumentType = document.type
                    document.selectedVariant = NetverifyDocumentVariant.paper
                    self.netverifyUIController?.setup(with: document)
                    self.hideAndCleanupTableView()
                }))
            }
            
            if document.supportsPlasticVariant() {
                alert.addAction(UIAlertAction(title: "\(actionTitle) (Plastic Card)", style: .default, handler: {(_: UIAlertAction!) in
                    self.currentDocumentType = document.type
                    document.selectedVariant = NetverifyDocumentVariant.plastic
                    self.netverifyUIController?.setup(with: document)
                    self.hideAndCleanupTableView()
                }))
            }
            
            tableView.deselectRow(at: indexPath, animated: true)
        }
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        if let presenter = alert.popoverPresentationController, let cell = self.tableView.cellForRow(at: indexPath) {
            presenter.sourceView = cell.contentView
            presenter.sourceRect = cell.contentView.bounds
        }
        
        self.present(alert, animated: true)
    }
    
    // MARK: Button events
    @IBAction func cancelScann_onTouchUp() {
        // Dismiss camera scan view
        self.dismiss(animated: false, completion: nil)
        self.isScanning = false
        
        // Close controller
        self.netverifyUIController?.cancel()
        self.hideAndCleanupTableView()
        self.navigationController?.popViewController(animated: true)
        self.netverifyUIController?.destroy()
        self.netverifyUIController = nil
    }
    
    @IBAction func toggleCamera_onTouchUp() {
        if self.currentScanView!.hasMultipleCameras() {
            self.currentScanView?.switchCamera()
        }
    }
    
    
    @IBAction func toggleFlash_onTouchUp() {
        if self.currentScanView!.hasFlash() {
            self.currentScanView?.toggleFlash()
        }
    }
    
    @IBAction func stopScanning_onTouchUp(_ sender: Any) {
        guard let button = sender as? UIButton else { return }
        
        if self.isScanning {
            self.currentScanView?.pauseScan()
            self.isScanning = false
            button.setTitle(">", for: .normal)
        } else {
            self.currentScanView?.retryScan()
            self.isScanning = true
            button.setTitle("||", for: .normal)
        }
    }
    
    func addFaceMacherHelpersViews(_ netverifyScanViewController: NetverifyCustomScanViewController) {
        let cancelBtn = UIButton()
        cancelBtn.translatesAutoresizingMaskIntoConstraints = false
        cancelBtn.setTitle("X", for: .normal)
        cancelBtn.backgroundColor = UIColor.clear
        cancelBtn.titleLabel?.font = UIFont(name: "System Thin", size: 27)
        cancelBtn.addTarget(self, action: #selector(self.cancelScann_onTouchUp), for: .touchUpInside)
        netverifyScanViewController.customOverlayLayer.addSubview(cancelBtn)
        
        // Align cancelBtn from the right
        netverifyScanViewController.customOverlayLayer.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[view]-30-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["view": cancelBtn]))
        // Align cancelBtn from the top
        netverifyScanViewController.customOverlayLayer.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-30-[view]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["view": cancelBtn]))
        // Width constraint
        netverifyScanViewController.customOverlayLayer.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[view(==44)]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["view": cancelBtn]))
        // Height constraint
        netverifyScanViewController.customOverlayLayer.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[view(==44)]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["view": cancelBtn]))
    }
    
    @objc func shutter_onTouchUp () {
        self.currentScanView?.takeImage()
    }
    
    func customRetakeHandler() {
        self.currentScanView?.retryScan()
        self.verifyInfoView!.isHidden = true
    }
    
    func hideAndCleanupTableView () {
        self.tableView.isHidden = true
        self.countries = [NetverifyCountry]()
        self.tableView.reloadData()
    }
}

