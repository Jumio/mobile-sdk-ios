//
//  HelpViewController.swift
//
//  Copyright © 2024 Jumio Corporation. All rights reserved.
//

import UIKit

class HelpViewController: UIViewController {
    
    var helpView: UIView? {
        didSet {
            oldValue?.removeFromSuperview()
            // Add help view to controller
            guard let helpView = helpView else { return }
            helpView.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(helpView)
            view.addConstraints(helpViewConstraints)
        }
    }
    
    // The help view has a fixed width and height.
    // We put it in the top half as there will be a system dialog (for nfc) at the bottom.
    private var helpViewConstraints: [NSLayoutConstraint] {
        guard let helpView = helpView else { return [] }
        return [helpView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                helpView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -50)]
    }
    
}
