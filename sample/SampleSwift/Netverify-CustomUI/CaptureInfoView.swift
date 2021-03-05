//
//  CaptureInfoView.swift
//
//  Copyright © 2021 Jumio Corporation. All rights reserved.
//

import UIKit
import Netverify

class CaptureInfoView: UIView {

    @IBOutlet weak var documentTypeLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var stepsLabel: UILabel!
    @IBOutlet weak var fallbackButton: UIButton!
    
    private var fallBackAction: (() -> Void)?
    
    func setup(documentType: NetverifyDocumentType?) {
        guard let documentType = documentType else { return }
        
        switch documentType {
            case .passport:
                documentTypeLabel.text = "Passport"
            case .identityCard:
                documentTypeLabel.text = "ID"
            case .visa:
                documentTypeLabel.text = "Visa"
            case .driverLicense:
                documentTypeLabel.text = "Driver Licence"
            default:
                // TODO error handling
                return
        }
    }
    
    func addFallbackHandler(action: (() -> Void)?) {
        self.fallbackButton.layer.borderColor = UIColor.white.cgColor
        fallbackButton.isHidden = false
        
        fallBackAction = action
        fallbackButton.addTarget(self, action: #selector(self.fallbackHandling), for: UIControl.Event.touchUpInside)
    }
    
    func setSteps(current: UInt, total: UInt) {
        stepsLabel.text = "Step \(current) of \(total)"
    }
    
    func getContentHeight() -> CGFloat {
        var height: CGFloat = 0
        
        documentTypeLabel.sizeToFit()
        descriptionLabel.sizeToFit()
        
        height += descriptionLabel.frame.origin.y
        height += descriptionLabel.frame.height
        if !fallbackButton.isHidden { height += fallbackButton.frame.height}
        height += 20 // margin
        
        return height
    }
    
    @objc func fallbackHandling() {
        fallBackAction!()
    }
}
