//
//  StartViewController.swift
//  SampleApp-UIKit
//
//  Created by Christian Henzl on 08.08.21.
//

import UIKit
import Jumio

class StartViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet var startButton: CustomButton!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var policyLabel: UILabel!
    
    // MARK: - Properties
    fileprivate var needsToConsent: Bool = false
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startButton.design = .positive
        startButton.setTitle("loading...", for: .disabled)
        startButton.isEnabled = false
    }
    
    // MARK: - IBActions
    @IBAction func start(_ sender: Any) {
        if needsToConsent {
            customUI?.userConsented()
        }
        customUI?.startWorkflow()
        startButton.isEnabled = false
    }
    
    @IBAction func cancel(_ sender: Any) {
        customUI?.cancel()
    }
    
    // MARK: - Functions
    func display(overviewItems: [String]) {
        var overview = ""
        overviewItems.forEach { overview = "\(overview)\($0)\n" }
        overviewLabel.text = overview
        startButton.isEnabled = true
    }
    
    func handle(policyUrl: String) {
        policyLabel.isHidden = false
        needsToConsent = true
    }
}
