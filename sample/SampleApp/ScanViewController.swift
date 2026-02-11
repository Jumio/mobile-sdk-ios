//
//  ScanViewController.swift
//
//  Copyright © 2026 Jumio Corporation. All rights reserved.
//

import UIKit
import Jumio

@MainActor
class ScanViewController: UIViewController {
    
    var message: String? {
        didSet {
            guard isViewLoaded else { return }
            updateExtractionStateLabel()
        }
    }
    
    // MARK: - IBOutlets
    @IBOutlet weak var scanView: JumioScanView!
    @IBOutlet weak var containerShutterView: UIView!
    @IBOutlet weak var fallbackButton: CustomButton!
    @IBOutlet weak var containerInformationView: UIView!
    @IBOutlet weak var informationLabel: UILabel!
    @IBOutlet weak var processingView: UIView!
    @IBOutlet weak var flipView: UIView!
    @IBOutlet weak var extractionStateLabel: UILabel!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // In this integration, this view controller only gets pushed
        // if a Jumio.Scan.Part.Delegate called Jumio.Scan.Step.scanView
        // means a Jumio.Scan.View needs to be attached.
        customUI?.attach(scanView: scanView)
        containerInformationView.layer.cornerRadius = 10
        processingView.layer.cornerRadius = 10
        flipView.layer.cornerRadius = 10
        updateView()
    }
    
    // MARK: - Functions
    func updateView() {
        Task { @MainActor [weak self] in
            self?.informationLabel.text = "\(self?.customUI?.credentialPart ?? "") \(self?.customUI?.scanMode ?? "")"
            self?.containerShutterView.isHidden = !(await self?.scanView.isShutterEnabled ?? false)
            self?.fallbackButton.isHidden = !(self?.customUI?.hasFallback ?? true)
            self?.updateExtractionStateLabel()
        }
    }
    
    func showProcessing() {
        processingView.isHidden = false
    }
    
    func showFlipView() {
        flipView.isHidden = false
    }
    
    func hideFlipView() {
        flipView.isHidden = true
    }
    
    private func updateExtractionStateLabel() {
        extractionStateLabel.isHidden = message?.isEmpty ?? true
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
        Task { [weak self] in
            self?.scanView.set(flash: await !(self?.scanView.flash ?? false))
        }
    }
    
}
