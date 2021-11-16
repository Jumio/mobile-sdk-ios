//
//  ConfirmationViewController.swift
//  SampleApp
//
//  Created by Christian Henzl on 09.08.21.
//

import UIKit
import Jumio

class ConfirmationViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var containerConfirmationView: UIView!
    @IBOutlet weak var confirmationView: JumioConfirmationView!
    @IBOutlet weak var containerRejectView: UIView!
    @IBOutlet weak var rejectView: JumioRejectView!
    @IBOutlet weak var confirmationRetakeButton: CustomButton!
    @IBOutlet weak var confirmationConfirmButton: CustomButton!
    @IBOutlet weak var rejectRetakeButton: CustomButton!
    
    // MARK: - Properties
    var style: Style?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // In this integration, this view controller only gets pushed
        // if a Jumio.Scan.Part.Delegate called Jumio.Scan.Step.confirmationView
        // or Jumio.Scan.Step.rejectView
        // means either a Jumio.Confirmation.View or Jumio.Reject.View
        // needs to be attached.
        // Due to similarity of those views, you could merge them together for example.
        switch style {
        case .confirm:
            customUI?.attach(confirmationView: confirmationView)
            containerConfirmationView.isHidden = false
            containerRejectView.isHidden = true
        case .reject:
            customUI?.attach(rejectView: rejectView)
            containerConfirmationView.isHidden = true
            containerRejectView.isHidden = false
        default:
            break
        }
        
        confirmationRetakeButton.design = .negative
        confirmationConfirmButton.design = .positive
        rejectRetakeButton.design = .positive
    }
    
    // MARK: - IBActions
    @IBAction func retake(_ sender: Any) {
        switch style {
        case .confirm:
            confirmationView.retake()
        case .reject:
            rejectView.retake()
        default:
            break
        }
    }
    
    @IBAction func confirm(_ sender: Any) {
        confirmationView.confirm()
    }
}

// MARK: - Style
extension ConfirmationViewController {
    enum Style {
        case confirm
        case reject
    }
}
