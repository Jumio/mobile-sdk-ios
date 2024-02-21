//
//  SelectionViewController.swift
//
//  Copyright © 2024 Jumio Corporation. All rights reserved.
//

import UIKit
import Jumio

class DigitalIdentityViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var digitalIdentityView: Jumio.DigitalIdentity.View!
    @IBOutlet weak var processingLabel: UILabel!
    @IBOutlet weak var containerImageTakenView: UIView!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // In this integration, this view controller only gets pushed
        // if a Jumio.Scan.Part.Delegate called Jumio.Scan.Step.digitalIdentityView
        // means a Jumio.DigitalIdentity.View to be attached.
        customUI?.attach(digitalIdentityView: digitalIdentityView)
    }
    
    // MARK: - Functions
    func showProcessing() {
        containerImageTakenView.isHidden = false
        processingLabel.isHidden = false
    }
}
