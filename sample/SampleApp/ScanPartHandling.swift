//
//  ScanPartHandling.swift
//  SampleApp-UIKit
//
//  Created by Christian Henzl on 08.08.21.
//

import Jumio

protocol ScanPartHandlingDelegate: AnyObject {
    func scanPartShowLoadingView()
    func scanPartShowScanView()
    func scanPartShowImageTaken()
    func scanPartShowProcessing()
    func scanPartShowConfirmationView()
    func scanPartShowRejectView()
    func scanPartDidFallback()
    func scanPartShowLegalHint(with message: String)
    func scanPartFinished()
}

class ScanPartHandling {
    typealias Delegate = ScanPartHandlingDelegate
    
    weak var delegate: Delegate?
    var hasFallback: Bool? { scanPart?.hasFallback }
    var scanMode: Jumio.Scan.Mode? { scanPart?.scanMode }
    
    fileprivate(set) var scanSide: Jumio.Scan.Side?
    fileprivate var scanPart: Jumio.Scan.Part?
    
    func start(scanSide: Jumio.Scan.Side, of credential: Jumio.Credential?) {
        self.scanSide = scanSide
        // to initialize a scan part, you will need the credential, a scan side and Jumio.Scan.Part.Delegate
        scanPart = credential?.initScanPart(scanSide, scanPartDelegate: self)
        scanPart?.start()
    }
    
    func fallback() {
        scanPart?.fallback()
    }
    
    func attach(scanView: Jumio.Scan.View) {
        guard let scanPart = scanPart else { return }
        scanView.attach(scanPart: scanPart)
    }
    
    func attach(confirmationView: Jumio.Confirmation.View) {
        guard let scanPart = scanPart else { return }
        confirmationView.attach(scanPart: scanPart)
    }
    
    func attach(rejectView: Jumio.Reject.View) {
        guard let scanPart = scanPart else { return }
        rejectView.attach(scanPart: scanPart)
    }
    
    func clean() {
        scanPart = nil
        scanSide = nil
    }
}

// MARK: - Jumio.Scan.Part.Delegate
extension ScanPartHandling: Jumio.Scan.Part.Delegate {
    func jumio(scanPart: Jumio.Scan.Part, step: Jumio.Scan.Step, data: Any?) {
        switch step {
        // Prepare: every time we are doing something asynchronously which might need longer time (for example network calls)
        case .prepare:
            delegate?.scanPartShowLoadingView()
        // Started: a scanner is being started
        case .started:
            print("scan started")
        // ScanView: you will need to attach a Jumio.Scan.View to this Jumio.Scan.Part
        case .scanView:
            delegate?.scanPartShowScanView()
        // ImageTaken: an image has been taken / captured
        case .imageTaken:
            delegate?.scanPartShowImageTaken()
        // Processing: captured image is being processed (timeframe differs)
        case .processing:
            delegate?.scanPartShowProcessing()
        // ConfirmationView: you will need to attach a Jumio.Confirmation.View to this Jumio.Scan.Part
        case .confirmationView:
            delegate?.scanPartShowConfirmationView()
        // RejectView: you will need to attach a Jumio.Confirmation.View to this Jumio.Scan.Part
        case .rejectView:
            delegate?.scanPartShowRejectView()
        // Retry: something went wrong and needs to be retried. Jumio.Retry.Reason contains more information
        case .retry:
            guard let reason = data as? Jumio.Retry.Reason else { return }
            print("retry reason", reason.code, reason.message)
            self.scanPart?.retry(reason: reason)
        // CanFinish: Jumio.Scan.Part is finished and waits for .finish()
        case .canFinish:
            self.scanPart?.finish()
            delegate?.scanPartFinished()
        @unknown default:
            print("got unknown scan step", step)
        }
    }
    
    func jumio(scanPart: Jumio.Scan.Part, updates update: Jumio.Scan.Update, data: Any?) {
        switch update {
        // Fallback: is being called after Jumio.Scan.Part.fallback() has been executed
        case .fallback:
            delegate?.scanPartDidFallback()
        // LegalHint: legal hint should be shown to the user. data contains a String with a message, which can be shown to the user
        case .legalHint:
            guard let message = data as? String else { return }
            delegate?.scanPartShowLegalHint(with: message)
        @unknown default:
            print("got unknown scan update", update)
        }
    }
}
