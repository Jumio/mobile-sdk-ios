//
//  FasterVerificationViewController.swift
//
//  Copyright © 2026 Jumio Corporation. All rights reserved.
//

import UIKit
import Jumio

class FasterVerificationViewController: UIViewController {
    @IBOutlet weak var legalStatement: UILabel!
    
    var fasterVerification: Jumio.FasterVerification?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        legalStatement.text = fasterVerification?.legalStatement.text
    }
    
    @IBAction func continueWithResult(_ sender: Any) {
        guard let legalStatement = fasterVerification?.legalStatement else { return }
        customUI?.userConsented(to: legalStatement, decision: true)
        customUI?.fasterVerificationConsented()
    }
    
    @IBAction func scanManually(_ sender: Any) {
        guard let legalStatement = fasterVerification?.legalStatement else { return }
        customUI?.userConsented(to: legalStatement, decision: false)
        customUI?.scan()
    }
    
}
