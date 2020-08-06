//
//  NetverifyCustomUIViewController.swift
//
//  Copyright © 2020 Jumio Corporation. All rights reserved.
//

import Netverify

class NetverifyCustomUIViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, NetverifyUIControllerDelegate, NetverifyCustomScanViewControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var mainTitleLabel: UILabel!
    
    // Capture Controls
    @IBOutlet var captureControlsView: UIView!
    @IBOutlet weak var captureControlToggleCamera: UIButton!
    @IBOutlet weak var captureControlToggleFlash: UIButton!
    
    
    // For custom scan view controller
    var isScanning: Bool = false
    var requiresVerification = true
    
    weak var netverifyUIController: NetverifyUIController?
    weak var currentScanView: NetverifyCustomScanViewController?
    weak var verifyInfoView: VerifyInfoView?
    weak var verificationFinishedView: VerificationFinishedView?
    
    var countries = [NetverifyCountry]()
    var currentDocumentType: NetverifyDocumentType?
    var userConsentAlert: UIAlertController?
    
    // MARK: View setup
    override func viewWillAppear(_ animated: Bool) {
        mainTitleLabel.text = requiresVerification ? "Verification" : "Data extraction"
        
        // Show loading circle
        if countries.count == 0 {
            self.activityIndicator.startAnimating()
        }
        
        self.navigationController?.delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(applicationDidBecomeActive), name: UIApplication.didBecomeActiveNotification, object: nil)
    }
    
    @objc func applicationDidBecomeActive() {
          DispatchQueue.main.async {
             if let userConsentAlert = self.userConsentAlert ,  self.presentedViewController != userConsentAlert {
                  self.present(userConsentAlert, animated: true, completion: nil)
              }
          }
      }
    
    // Cancel if another view controller is shown on top of the netverifyCustomUIViewController
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        if viewController != self {
            self.netverifyUIController?.cancel()
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
        netverifyScanViewController.customOverlayLayer.addConstraint(NSLayoutConstraint(item: shutterBtn, attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, toItem: netverifyScanViewController.customOverlayLayer, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1.0, constant: 0.0))
        // align shutterBtn from the bottom
        netverifyScanViewController.customOverlayLayer.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[view]-130-|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: ["view": shutterBtn]))
        // width constraint
        netverifyScanViewController.customOverlayLayer.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[view(==70)]", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: ["view": shutterBtn]))
        // height constraint
        netverifyScanViewController.customOverlayLayer.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[view(==70)]", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: ["view": shutterBtn]))
    }
    
    func addVerificationFinishedView()  {
        guard let verificationFinishedView = Bundle.main.loadNibNamed("VerificationFinishedView", owner: self, options: nil)?.first as? VerificationFinishedView else { return }
        self.verificationFinishedView = verificationFinishedView
        verificationFinishedView.frame = self.view.frame
        
        self.currentScanView?.dismiss(animated: false, completion: nil)
        self.view.addSubview(verificationFinishedView)
    }
    
    func addCaptureHelperViews(_ netverifyScanViewController: NetverifyCustomScanViewController, isFallback: Bool) {
        // Add capture controls view
        self.addCaptureControl(to: netverifyScanViewController)
        
        if netverifyScanViewController.currentScanMode() == .mode3DLiveness {
            // Don't show captureInfoView when 3DLivenes is used
            return
        }
        
        // Add capture info view
        guard let captureInfoView = Bundle.main.loadNibNamed("CaptureInfoView", owner: self, options: nil)?.first as? CaptureInfoView else { return }
        captureInfoView.setup(documentType: currentDocumentType)
        captureInfoView.descriptionLabel.text = netverifyScanViewController.localizedShortHelpText()
        captureInfoView.setSteps(current: netverifyScanViewController.currentStep(), total: netverifyScanViewController.totalSteps())
        if isFallback { captureInfoView.addFallbackHandler(action: netverifyScanViewController.switchToFallback) }
        
        captureInfoView.translatesAutoresizingMaskIntoConstraints = false
        netverifyScanViewController.customOverlayLayer.addSubview(captureInfoView)
        
        netverifyScanViewController.customOverlayLayer.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[view(==\(captureInfoView.getContentHeight()))]|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: ["view": captureInfoView]))
        netverifyScanViewController.customOverlayLayer.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[view]|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: ["view": captureInfoView]))
    }
    
    // MARK: NetverifyUIControllerDelegate
    func netverifyUIController(_ netverifyUIController: NetverifyUIController, didFinishInitializingWithError error: NetverifyError?) {
        self.netverifyUIController = netverifyUIController
    }
    
    func netverifyUIController(_ netverifyUIController: NetverifyUIController, didDetermineAvailableCountries countries: [Any], suggestedCountry country: NetverifyCountry?) {
        print("available countries determined")
        
        // Hide loading circle
        self.activityIndicator.stopAnimating()
        self.activityIndicator.isHidden = true
        
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
        
        self.isScanning = true
        self.currentScanView = scanViewController
        // Add the shutter button if document detection is not enabled
        if scanViewController.isImagePicker() {
            self.addShutterButton(scanViewController)
        }
        
        // Add helper views for the camera capture
        if scanViewController.currentScanMode() == .modeFaceCapture || scanViewController.currentScanMode() == .mode3DLiveness {
            self.addFaceMacherHelpersViews(scanViewController)
        } else {
            self.addCaptureHelperViews(scanViewController, isFallback: scanViewController.isFallbackAvailable())
        }

        
        self.navigationController?.present(scanViewController, animated: true)
    }
    
    func netverifyUIControllerDidCaptureAllParts(_ netverifyUIController: NetverifyUIController) {
        print("Processing captured documents")
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        // Add the verification finished view when document is captured and the process of data extraction has started
        self.addVerificationFinishedView()
    }
    
    func netverifyUIController(_ netverifyUIController: NetverifyUIController, didDetermineError error: NetverifyError, retryPossible: Bool) {
        print("didDetermineError: \(error.message ?? "")")
        
        // Handler when error occurs
        let alert = UIAlertController(title: error.code, message: error.message, preferredStyle: UIAlertController.Style.alert)
        
        if retryPossible {
            alert.addAction(UIAlertAction(title: "Retry", style: .default, handler: {(_: UIAlertAction!) in netverifyUIController.retryAfterError()}))
        }
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: {(_: UIAlertAction!) in
            netverifyUIController.cancel()
            self.navigationController?.popToRootViewController(animated: true)
        }))
        
        if let scanVC = self.currentScanView {
            if scanVC.isBeingDismissed {
                if let verificationView = self.verificationFinishedView {
                    verificationView.removeFromSuperview()
                }
                self.present(alert, animated: true, completion: nil)
            } else {
                if let verificationView = self.verificationFinishedView {
                    verificationView.removeFromSuperview()
                }
                self.present(alert, animated: true, completion: nil)
            }
        } else {
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func netverifyUIController(_ netverifyUIController: NetverifyUIController, didFinishWith documentData: NetverifyDocumentData, scanReference: String) {
        print("NetverifyUIController finished successfully with scan reference: \(scanReference)")
        // Share the scan reference for the Authentication SDK
        UserDefaults.standard.set(scanReference, forKey: "enrollmentTransactionReference")
        
        // Update verification finished view when the data from the captured document was captured
        if self.verificationFinishedView == nil {
            self.addVerificationFinishedView()
        }
        verificationFinishedView!.setup(documentData: documentData, doneHandler: {() -> Void in
            self.navigationController?.popViewController(animated: true)
            
            netverifyUIController.destroy()
            self.netverifyUIController = nil
        })
    }
    
    func netverifyUIController(_ netverifyUIController: NetverifyUIController, didCancelWithError error: NetverifyError?, scanReference: String?) {
        
        //handle the error cases as highlighted in our documentation: https://github.com/Jumio/mobile-sdk-ios/blob/master/docs/integration_faq.md#managing-errors
        
        print("didCancelWithError: \(error?.message ?? "")")
        
        let cancelCompletion = {
            self.isScanning = false
            self.hideAndCleanupTableView()
            
            netverifyUIController.destroy()
            self.netverifyUIController = nil
            
            self.navigationController?.popViewController(animated: true)
        }
        
        if self.currentScanView == nil {
            cancelCompletion()
        } else {
            self.dismiss(animated: true, completion: cancelCompletion)
        }
    }
    
    func netverifyUIController(_ netverifyUIController: NetverifyUIController, shouldRequireUserConsentWith url: URL) {
        // This delegate is invoked when the end-user’s consent to Jumio's privacy policy is legally required. Please call “userConsent(given:)" when the end-user has accepted.
        
        let alert = UIAlertController(title: "User Consent", message: "By clicking \"Accept\" you consent to Jumio collecting and disclosing your biometric data pursuant to its Privacy Policy", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Jumio's privacy policy", style: .default, handler: {(_: UIAlertAction) in
            print("User Consent show")
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }))
        
        alert.addAction(UIAlertAction(title: "Accept", style: .default, handler: {(_: UIAlertAction) in
            print("user consent accepted")
            self.userConsentAlert = nil
            netverifyUIController.userConsent(given: true)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: {(_: UIAlertAction) in
            print("user consent declined")
            self.userConsentAlert = nil
            netverifyUIController.userConsent(given: false) //forces sdk cancel
        }))
        
        self.userConsentAlert = alert

        self.present(alert, animated: true)
    }
    
    // MARK: NetverifyCustomScanViewControllerDelegate
    func netverifyCustomScanViewController(_ customScanView: NetverifyCustomScanViewController, shouldDisplayLegalAdvice message: String, completion: @escaping () -> Void) {
        
        // Show legal advice
        let alert = UIAlertController(title: "Read This:", message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "I READ THIS", style: .default, handler: {(_: UIAlertAction!) in completion()}))
        customScanView.present(alert, animated: true, completion: nil)
    }
    
    func netverifyCustomScanViewController(_ customScanView: NetverifyCustomScanViewController, shouldDisplayBlurHint message: String) {
        print("netverifyUIController shouldDisplayBlurHint: \(message)")
        let alert = UIAlertController(title: "Hint", message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        customScanView.present(alert, animated: true, completion: nil)
    }
    
    func netverifyCustomScanViewController(_ customScanView: NetverifyCustomScanViewController, shouldDisplayConfirmationWith view: NetverifyConfirmationImageView, type: NetverifyConfirmationType, text: String, confirmation: (() -> Void)?, retake: (() -> Void)? = nil) {
        print("show confirmation view")
        self.removeVerifyInfoView()
        
        // Document was captured and the user needs to verify if the captured image is valid
        guard let verifyInfoView = Bundle.main.loadNibNamed("VerifyInfoView", owner: self, options: nil)?.first as? VerifyInfoView else { return }
        verifyInfoView.imagePlaceholderView.addSubview(view)
        verifyInfoView.descriptionLabel.text = text
        verifyInfoView.setSteps(current: customScanView.currentStep(), total: customScanView.totalSteps())
        verifyInfoView.addConfirmationHandler(action: confirmation)
        verifyInfoView.addRetakeHandler(actions: [retake!, self.customRetakeHandler])
        
        verifyInfoView.frame = customScanView.customOverlayLayer.frame
        
        switch type {
        case .analyzing:
            // Document is being analyzed, the user should not be able to confirm or retake
            verifyInfoView.confirmButton.isHidden = true
            verifyInfoView.retakeButton.isHidden  = true
        case .analyzingResponseReject:
            // Analysis rejected document, the user should be able to retry
            verifyInfoView.retakeButton.isHidden  = false
            verifyInfoView.confirmButton.isHidden = true
        default:
            // In other cases the user should be able to confirm and retry
            verifyInfoView.confirmButton.isHidden = false
            verifyInfoView.retakeButton.isHidden  = false
        }
        
        
        customScanView.customOverlayLayer.addSubview(verifyInfoView)
        self.verifyInfoView = verifyInfoView
        customScanView.customOverlayLayer.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[view]|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: ["view":view]))
        customScanView.customOverlayLayer.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[view]|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: ["view":view]))
    }
    
    /**
     * No US Address has been found in the barcode. The scan preview will switch to frontside scanning if available. Check for the changed scan mode and help text. Will only be called on a Fastfill scan.
     **/
    func netverifyCustomScanViewController(_ customScanView: NetverifyCustomScanViewController, shouldDisplayNoUSAddressFoundHint message: String, confirmation: @escaping (() -> Void)) {
        print("netverifyUIController shouldDisplayNoUSAddressFoundHint: \(message)")
        let alert = UIAlertController(title: "Read This:", message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "I READ THIS", style: .default, handler: {(_: UIAlertAction) in
            confirmation()
        }))
        customScanView.present(alert, animated: true, completion: nil)
    }
    
    
    func netverifyCustomScanViewControllerStartedBiometricAnalysis(_ customScanView: NetverifyCustomScanViewController) {
        print("netverifyCustomScanViewControllerStartedBiometricAnalysis")

        customScanView.customOverlayLayer.addSubview(self.activityIndicator);
        self.activityIndicator.isHidden = false
        self.activityIndicator.startAnimating()
        
        customScanView.customOverlayLayer.addConstraint(NSLayoutConstraint(item: self.activityIndicator!, attribute: .centerX, relatedBy: .equal, toItem: customScanView.customOverlayLayer, attribute: .centerX, multiplier: 1.0, constant: 0.0))
        customScanView.customOverlayLayer.addConstraint(NSLayoutConstraint(item: self.activityIndicator!, attribute: .centerY, relatedBy: .equal, toItem: customScanView.customOverlayLayer, attribute: .centerY, multiplier: 1.0, constant: 0.0))
    }
    
    func netverifyCustomScanViewController(_ customScanView: NetverifyCustomScanViewController, shouldDisplayHelpWithText message: String, animationView: UIView, for retryReason: JumioZoomRetryReason) {
        
        if (!self.activityIndicator.isHidden) {
            self.activityIndicator.stopAnimating()
            self.activityIndicator.isHidden = true
        }
        
        print("NetverifyCustomScanViewController shouldDisplayHelpWithText: \(message)")
        guard let helpAnimationView = Bundle.main.loadNibNamed("HelpAnimationView", owner: self, options: nil)?.first as? HelpAnimationView else { return }
        helpAnimationView.translatesAutoresizingMaskIntoConstraints = false
        helpAnimationView.descriptionLabel.text = message
        helpAnimationView.addContinueHandler(action: {
            helpAnimationView.removeFromSuperview()
            customScanView.retryScan()
        })

        helpAnimationView.animationView.addSubview(animationView)
        helpAnimationView.animationView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[animationView]|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: ["animationView":animationView]))
        helpAnimationView.animationView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[animationView]|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: ["animationView":animationView]))
        
        customScanView.customOverlayLayer.addSubview(helpAnimationView)
        customScanView.customOverlayLayer.bringSubviewToFront(helpAnimationView)
        customScanView.customOverlayLayer.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[helpView]|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: ["helpView":helpAnimationView]))
        customScanView.customOverlayLayer.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[helpView]|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: ["helpView":helpAnimationView]))
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
        // Close controller
        self.netverifyUIController?.cancel()
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
        netverifyScanViewController.customOverlayLayer.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[view]-30-|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: ["view": cancelBtn]))
        // Align cancelBtn from the top
        netverifyScanViewController.customOverlayLayer.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-30-[view]", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: ["view": cancelBtn]))
        // Width constraint
        netverifyScanViewController.customOverlayLayer.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[view(==44)]", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: ["view": cancelBtn]))
        // Height constraint
        netverifyScanViewController.customOverlayLayer.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[view(==44)]", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: ["view": cancelBtn]))
    }
    
    @objc func shutter_onTouchUp () {
        self.currentScanView?.takeImage()
    }
    
    func customRetakeHandler() {
        self.currentScanView?.retryScan()
        self.removeVerifyInfoView()
    }
    
    func removeVerifyInfoView() {
        if let verifyInfoView = self.verifyInfoView {
            verifyInfoView.removeFromSuperview()
            self.verifyInfoView = nil
        }
    }
    
    func hideAndCleanupTableView () {
        self.tableView.isHidden = true
        self.countries = [NetverifyCountry]()
        self.tableView.reloadData()
    }
    
    func addCaptureControl(to customScanView: NetverifyCustomScanViewController) {
        captureControlToggleCamera.isHidden = !customScanView.canSwitchCamera()
        captureControlToggleFlash.isHidden = !customScanView.canToggleFlash()
        
        captureControlsView.translatesAutoresizingMaskIntoConstraints = false
        customScanView.customOverlayLayer.addSubview(captureControlsView)
        customScanView.customOverlayLayer.sendSubviewToBack(captureControlsView)
        
        // captureControlsView height constrains
        customScanView.customOverlayLayer.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-16-[view(==144)]", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: ["view": captureControlsView!]))
        // captureControlsView width constrains
        customScanView.customOverlayLayer.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[view]|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: ["view": captureControlsView!]))
    }
}
