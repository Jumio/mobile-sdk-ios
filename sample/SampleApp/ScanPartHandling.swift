//
//  ScanPartHandling.swift
//
//  Copyright © 2024 Jumio Corporation. All rights reserved.
//

import Jumio
import UIKit

protocol ScanPartHandlingDelegate: AnyObject {
    func scanPartShowLoadingView()
    func scanPartShowHelpView()
    func scanPartShowScanView()
    func scanPartShowDigitalIdentityView()
    func scanPartThirdPartyVerification()
    func scanPartAttachFile()
    func scanPartShowProcessing()
    func scanPartNextPart()
    func scanPartNextPartEnd()
    func scanPartShowConfirmationView()
    func scanPartShowRejectView()
    func scanPartShowRetryView(with reason: Jumio.Retry.Reason)
    func scanPartDidFallback()
    func scanPartShowExtractionState(with extractionState: Jumio.Scan.Update.ExtractionState, and data: Any?)
    func scanPartFinished()
}

class ScanPartHandling {
    typealias Delegate = ScanPartHandlingDelegate
    
    weak var delegate: Delegate?
    weak var scanView: Jumio.Scan.View?
    var hasFallback: Bool? { scanPart?.hasFallback }
    var scanMode: Jumio.Scan.Mode? { scanPart?.scanMode }
    
    private(set) var credentialPart: Jumio.Credential.Part?
    private var scanPart: Jumio.Scan.Part?
    
    func start(credentialPart: Jumio.Credential.Part, of credential: Jumio.Credential?) {
        self.credentialPart = credentialPart
        // to initialize a scan part, you will need the credential, a credential part and Jumio.Scan.Part.Delegate
        scanPart = credential?.initScanPart(credentialPart, scanPartDelegate: self)
        scanPart?.start()
    }
    
    func start(addon: Jumio.Scan.Part) {
        scanPart = addon
        scanPart?.start()
        
        if scanPart?.scanMode == .nfc {
            // For the addon nfc there is no scan step .scanView. Therefore, a view should be shown immediately.
            delegate?.scanPartShowHelpView()
        }
    }
    
    func fallback() {
        scanPart?.fallback()
    }
    
    func cancel() {
        scanPart?.cancel()
    }
    
    func attach(scanView: Jumio.Scan.View) {
        guard let scanPart = scanPart else { return }
        self.scanView = scanView
        scanView.attach(scanPart: scanPart)
    }
    
    func attach(digitalIdentityView: Jumio.DigitalIdentity.View) {
        guard let scanPart = scanPart else { return }
        digitalIdentityView.attach(scanPart: scanPart)
    }
    
    func attach(fileAttacher: Jumio.FileAttacher) {
        guard let scanPart = scanPart else { return }
        fileAttacher.attach(scanPart: scanPart)
    }
    
    func attach(confirmationHandler: Jumio.Confirmation.Handler) {
        guard let scanPart = scanPart else { return }
        confirmationHandler.attach(scanPart: scanPart)
    }
    
    func attach(rejectHandler: Jumio.Reject.Handler) {
        guard let scanPart = scanPart else { return }
        rejectHandler.attach(scanPart: scanPart)
    }
    
    func retry(reason: Jumio.Retry.Reason) {
        scanPart?.retry(reason: reason)
    }
    
    func helpView() -> UIView? {
        // This returns a help view for the current scan part. This is available for NFC and iProov.
        return scanPart?.getHelpAnimation()
    }
    
    func clean() {
        scanPart = nil
        credentialPart = nil
    }
}

// MARK: - Jumio.Scan.Part.Delegate
extension ScanPartHandling: Jumio.Scan.Part.Delegate {
    func jumio(scanPart: Jumio.Scan.Part, step: Jumio.Scan.Step, data: Any?) {
        switch step {
        // Prepare: every time we are doing something asynchronously which might need longer time (for example network calls).
        case .prepare:
            delegate?.scanPartShowLoadingView()
        // Started: a scanner is being started.
        case .started:
            guard let credentialPart = data as? Jumio.Credential.Part else { return }
            print("scan started ", credentialPart)
        // ScanView: you will need to attach a Jumio.Scan.View to this Jumio.Scan.Part.
        case .scanView:
            delegate?.scanPartShowScanView()
        // DigitalIdentityView: you will need to attach a Jumio.DigitalIdentity.View to this Jumio.Scan.Part.
        case .digitalIdentityView:
            delegate?.scanPartShowDigitalIdentityView()
        // ThirdPartyVerification: The started part will switch to a third party's application to continue verification. As this might take some time, showing a loading indicator is recommended.
        case .thirdPartyVerification:
            delegate?.scanPartThirdPartyVerification()
        case .attachFile:
            delegate?.scanPartAttachFile()
        // ImageTaken: an image has been taken / captured.
        case .imageTaken:
            print("Image has been taken")
        // Processing: captured image is being processed (timeframe differs).
        case .processing:
            delegate?.scanPartShowProcessing()
        // ConfirmationView: you will need to attach a Jumio.Confirmation.View to this Jumio.Scan.Part.
        case .confirmationView:
            delegate?.scanPartShowConfirmationView()
        // RejectView: you will need to attach a Jumio.Confirmation.View to this Jumio.Scan.Part.
        case .rejectView:
            delegate?.scanPartShowRejectView()
            guard let reasons = data as? [Jumio.Credential.Part: Jumio.RejectReason] else { return }
            reasons.forEach { print("reject reason", $0.value.rawValue) }
        // Retry: something went wrong and needs to be retried. Jumio.Retry.Reason contains more information.
        case .retry:
            guard let reason = data as? Jumio.Retry.Reason else { return }
            delegate?.scanPartShowRetryView(with: reason)
            print("retry reason", reason.code, reason.message)
        // CanFinish: Jumio.Scan.Part is finished and waits for .finish().
        case .canFinish:
            self.scanPart?.finish()
            delegate?.scanPartFinished()
        // AddonScanPart: Jumio.Scan.Part contains an additional Addon, which can be executed. Show necessary UI for this.
        case .addonScanPart:
            print("Addon is available")
        // NextPart: Next part in a multipart scan part is available.
        case .nextPart:
            guard let nextPart = data as? Jumio.Credential.Part else { return }
            print("next part", nextPart)
            
            // We suggest to add some kind of instruction or animation here to show the user that the next part is about to be captured.
            // For example: Front side was already captured and now it is about to scan the back side of the document.
            // While showing this, you should disable extraction to not allow the user to extract the old part again.
            scanView?.stopExtraction(hidePreview: false)
            delegate?.scanPartNextPart()
            DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) { [weak self] in
                self?.delegate?.scanPartNextPartEnd()
                self?.scanView?.startExtraction()
            }
        @unknown default:
            print("got unknown scan step", step)
        }
    }
    
    func jumio(scanPart: Jumio.Scan.Part, updates update: Jumio.Scan.Update, data: Any?) {
        switch update {
        // Fallback: is being called after Jumio.Scan.Part.fallback() has been executed
        case .fallback(let fallbackReason):
            // Fallback Reason, you can notify the user that fallback is triggered. It could be that user select fallback themselves or Jumio has to fallback due to low performance.
            print(fallbackReason)
            delegate?.scanPartDidFallback()
        // NFC Updates: You can show updates in the UI in the background, when NFC progresses
        case .nfcExtractionStarted, .nfcExtractionProgress, .nfcExtractionFinished:
            break
        // ExtractionState: extraction state updates should be shown to the user to guide him through capturing process
        case .extractionState(let extractionState):
            delegate?.scanPartShowExtractionState(with: extractionState, and: data)
        // Flash: We enabled the flash. Users are not allowed to disable the flash until a .flash(.off) update is sent.
        case .flash(let flashState):
            print(flashState)
        // Triggered, when the face position during a liveness scan should be changed
        case .nextPosition:
            print("next position")
        case .legalHint:
            print("deprecated scan update, will be removed in a future version")
        @unknown default:
            print("got unknown scan update", update)
        }
    }
}
