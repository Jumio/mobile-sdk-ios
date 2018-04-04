//
//  VerificationFinishedView.swift
//
//  Copyright © 2018 Jumio Corporation. All rights reserved.
//

import UIKit
import Netverify

class VerificationFinishedView: UIView {

    var doneHandler: (() -> Void)?
    
    @IBOutlet weak var activityIndicatorLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    
    func setup(documentData: NetverifyDocumentData, doneHandler: (() -> Void)? ) {
        
        if let lastname = documentData.lastName,
            let firstname = documentData.firstName {
            nameLabel.text = "\(firstname) \(lastname)"
        }
        
        self.doneHandler = doneHandler
        activityIndicator.stopAnimating()
        activityIndicatorLabel.isHidden = true
        contentView.isHidden = false
    }
    
    @IBAction func done_onTouchUp() {
        guard let _ = doneHandler else { return }
        
        doneHandler!()
    }
}
