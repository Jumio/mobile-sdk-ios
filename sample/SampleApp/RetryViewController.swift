//
//  RetryViewController.swift
//
//  Copyright © 2024 Jumio Corporation. All rights reserved.
//

import UIKit
import Jumio

class RetryViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var retryButton: CustomButton!
    @IBOutlet weak var cancelButton: CustomButton!
    @IBOutlet weak var codeLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    
    // MARK: - Properties
    var reason: Jumio.Retry.Reason?

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        retryButton.design = .positive
        cancelButton.design = .negative
        codeLabel.text = String(reason?.code ?? 0)
        messageLabel.text = reason?.message
        
        let reasonValue = reason?.code ?? 0
        if reasonValue == Jumio.Retry.Reason.NFC.bacError.rawValue ||
            reasonValue == Jumio.Retry.Reason.NFC.tagLost.rawValue {
            // When NFC scan fails with a retry reason, scan part can also be cancelled
            // whithout breaking the whole user journey
            cancelButton.isHidden = false
        }
    }
    
    // MARK: - IBActions
    @IBAction func retry() {
        guard let reason = reason else { return }
        customUI?.retry(reason: reason)
        customUI?.popViewController(animated: true)
    }
    
    @IBAction func cancel() {
        customUI?.cancelScanPart()
        customUI?.popViewController(animated: true)
    }
}
