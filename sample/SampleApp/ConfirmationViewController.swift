//
//  ConfirmationViewController.swift
//
//  Copyright © 2024 Jumio Corporation. All rights reserved.
//

import UIKit
import Jumio

class ConfirmationViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var containerConfirmationView: UIView!
    @IBOutlet weak var firstConfirmationView: JumioConfirmationView!
    @IBOutlet weak var secondConfirmationView: JumioConfirmationView!
    @IBOutlet weak var containerRejectView: UIView!
    @IBOutlet weak var firstRejectView: JumioRejectView!
    @IBOutlet weak var secondRejectView: JumioRejectView!
    @IBOutlet weak var confirmationRetakeButton: CustomButton!
    @IBOutlet weak var confirmationConfirmButton: CustomButton!
    @IBOutlet weak var rejectRetakeButton: CustomButton!
    
    // MARK: - Properties
    var style: Style?
    
    private let confirmationHandler = Jumio.Confirmation.Handler()
    private let rejectHandler = Jumio.Reject.Handler()
    
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
            customUI?.attach(confirmationHandler: confirmationHandler)
            renderConfirmation()
            containerConfirmationView.isHidden = false
            containerRejectView.isHidden = true
        case .reject:
            customUI?.attach(rejectHandler: rejectHandler)
            renderRejected()
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
            confirmationHandler.retake()
        case .reject:
            rejectHandler.retake()
        default:
            break
        }
    }
    
    @IBAction func confirm(_ sender: Any) {
        confirmationHandler.confirm()
    }
    
    // MARK: - Rendering
    private func renderConfirmation() {
        if confirmationHandler.parts.count > 0 {
            confirmationHandler.renderPart(part: confirmationHandler.parts[0], view: firstConfirmationView)
        }
        if confirmationHandler.parts.count > 1 {
            confirmationHandler.renderPart(part: confirmationHandler.parts[1], view: secondConfirmationView)
        }
    }
    
    private func renderRejected() {
        if rejectHandler.parts.count > 0 {
            rejectHandler.renderPart(part: rejectHandler.parts[0], view: firstRejectView)
        }
        if rejectHandler.parts.count > 1 {
            rejectHandler.renderPart(part: rejectHandler.parts[1], view: secondRejectView)
        }
    }
}

// MARK: - Style
extension ConfirmationViewController {
    enum Style {
        case confirm
        case reject
    }
}
