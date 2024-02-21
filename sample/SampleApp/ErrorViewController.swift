//
//  ErrorViewController.swift
//
//  Copyright © 2024 Jumio Corporation. All rights reserved.
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
