//
//  HelpAnimationView.swift
//
//  Copyright © 2019 Jumio Corporation. All rights reserved.
//

import UIKit

class HelpAnimationView: UIView {
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var animationView: UIView!
    
    var continueHandler: (() -> Void)?
    
    override func layoutSubviews() {
        self.continueButton.layer.borderColor = UIColor.white.cgColor
    }
    
    func addContinueHandler(action: (() -> Void)? ) {
        guard let maybeeAction = action else { return }
        
        self.continueHandler = maybeeAction
        continueButton.addTarget(self, action: #selector(self.continueHandling), for: UIControlEvents.touchUpInside)
    }
    
    
    @objc func continueHandling() {
        guard let maybeeContinueHandler = continueHandler else { return }
        
        maybeeContinueHandler()
    }
    
}
