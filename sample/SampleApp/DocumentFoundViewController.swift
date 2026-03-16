//
//  DocumentFoundViewController.swift
//
//  Copyright © 2026 Jumio Corporation. All rights reserved.
//

import UIKit
import Jumio

class DocumentFoundViewController: UIViewController {
    
    @IBOutlet weak var documentType: UILabel!
    @IBOutlet weak var legalStatement: UILabel!
    
    var lookupResult: Jumio.LookupResult?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        documentType.text = lookupResult?.documentType.rawValue
        legalStatement.text = lookupResult?.legalStatement.text
    }
    
    @IBAction func continueWithResult(_ sender: Any) {
        guard let legalStatement = lookupResult?.legalStatement else { return }
        customUI?.userConsented(to: legalStatement, decision: true)
        customUI?.finishCredential()
    }
    
    @IBAction func scanManually(_ sender: Any) {
        guard let legalStatement = lookupResult?.legalStatement else { return }
        customUI?.userConsented(to: legalStatement, decision: false)
        customUI?.scan()
    }
    
}
