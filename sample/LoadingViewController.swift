//
//  LoadingViewController.swift
//  SampleApp
//
//  Created by Christian Henzl on 09.08.21.
//

import UIKit

class LoadingViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var label: UILabel!
    
    // MARK: - Properties
    var style: Style?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        switch style {
        case .loading:
            label.text = "Loading"
        case .uploading:
            label.text = "Uploading"
        default:
            break
        }
    }
}

// MARK: - Style
extension LoadingViewController {
    enum Style {
        case loading
        case uploading
    }
}
