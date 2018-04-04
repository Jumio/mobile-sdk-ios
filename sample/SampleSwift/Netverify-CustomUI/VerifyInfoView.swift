//
//  VerifyInfoView.swift
//
//  Copyright © 2018 Jumio Corporation. All rights reserved.
//

import UIKit

class VerifyInfoView: UIView {

    
    @IBOutlet weak var retakeButton: UIButton!
    @IBOutlet weak var confirmButton: UIButton!
    @IBOutlet weak var imagePlaceholderView: UIView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var stepsLabel: UILabel!
    
    private var _confirmationAction: (() -> Void)?
    private var _retakeActions = [() -> Void]()
    
    override func layoutSubviews() {
        self.confirmButton.layer.borderColor = UIColor.white.cgColor
        self.retakeButton.layer.borderColor = UIColor.white.cgColor
    }
    
    func setSteps(current: UInt, total: UInt) {
        stepsLabel.text = "Step \(current) of \(total)"
    }
    
    func addConfirmationHandler(action: (() -> Void)?) {
        guard let _ = action else { return }
        
        _confirmationAction = action
        confirmButton.addTarget(self, action: #selector(self.confirmationHandling), for: UIControlEvents.touchUpInside)
    }
    
    func addRetakeHandler(actions: [() -> Void]? ) {
        guard let _ = actions else { return }
        
        _retakeActions = actions!
        retakeButton.addTarget(self, action: #selector(self.retakeHandling), for: UIControlEvents.touchUpInside)
    }
    
    func confirmationHandling() {
        guard let _ = _confirmationAction else { return }
        
        _confirmationAction!()
    }
    
    func retakeHandling() {
        for action in _retakeActions {
            action()
        }
    }
}
