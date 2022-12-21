//
//  ScanViewController.swift
//
//  Copyright © 2022 Jumio Corporation. All rights reserved.
//

import UIKit
import Jumio

class ScanViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var scanView: JumioScanView!
    @IBOutlet weak var containerShutterView: UIView!
    @IBOutlet weak var fallbackButton: CustomButton!
    @IBOutlet weak var containerInformationView: UIView!
    @IBOutlet weak var informationLabel: UILabel!
    @IBOutlet weak var containerImageTakenView: UIView!
    @IBOutlet weak var processingLabel: UILabel!
    @IBOutlet weak var extractionStateLabel: UILabel!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // In this integration, this view controller only gets pushed
        // if a Jumio.Scan.Part.Delegate called Jumio.Scan.Step.scanView
        // means a Jumio.Scan.View needs to be attached.
        customUI?.attach(scanView: scanView)
        containerInformationView.layer.cornerRadius = 10
        containerImageTakenView.layer.cornerRadius = 10
        updateView()
    }
    
    // MARK: - Functions
    func updateView() {
        informationLabel.text = "\(customUI?.credentialPart ?? "") \(customUI?.scanMode ?? "")"
        containerShutterView.isHidden = !scanView.isShutterEnabled
        fallbackButton.isHidden = !(customUI?.hasFallback ?? true)
        extractionStateLabel.isHidden = true
    }
    
    func presentLegalHint(with message: String) {
        let alertView = UIAlertController(title: "Legal hint", message: message, preferredStyle: .alert)
        alertView.addAction(UIAlertAction(title: "Ok", style: .default, handler: { _  in alertView.dismiss(animated: true) }))
        present(alertView, animated: true)
    }
    
    func showImageTaken() {
        containerImageTakenView.isHidden = false
    }
    
    func showProcessing() {
        processingLabel.isHidden = false
    }
    
    func updateExtractionState(message: String) {
        extractionStateLabel.isHidden = false
        extractionStateLabel.text = message
    }
    
    // MARK: - IBActions
    @IBAction func fallback(_ sender: Any) {
        customUI?.fallback()
    }
    
    @IBAction func takePicture(_ sender: Any) {
        scanView.takePicture()
    }
    
    @IBAction func switchCamera(_ sender: Any) {
        scanView.switchCamera()
    }
    
    @IBAction func flash(_ sender: Any) {
        scanView.flash = !scanView.flash
    }
    
}
