//
//  ErrorViewController.swift
//  SampleApp
//
//  Created by Christian Henzl on 09.08.21.
//

import UIKit
import Jumio

class ErrorViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var retryButton: CustomButton!
    @IBOutlet weak var codeLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    
    // MARK: - Properties
    var error: Jumio.Error?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        retryButton.design = .positive
        codeLabel.text = error?.code
        messageLabel.text = error?.message
    }
    
    // MARK: - IBActions
    @IBAction func retry(_ sender: Any) {
        guard let error = error else { return }
        customUI?.retry(error: error)
        customUI?.popViewController(animated: true)
    }
    
}
