//
//  AcquireModeViewController.swift
//
//  Copyright © 2024 Jumio Corporation. All rights reserved.
//

import Foundation
import UIKit
import Jumio

class AcquireModeViewController: UIViewController {
    
    @IBOutlet weak var acquireModeTableView: UITableView!
    
    var modes: [Jumio.Acquire.Mode]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        acquireModeTableView.delegate = self
        acquireModeTableView.dataSource = self
        acquireModeTableView.register(Cell.basic.class, forCellReuseIdentifier: Cell.basic.identifier)
    }
    
}

extension AcquireModeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        modes?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cell.basic.identifier)
        
        cell?.textLabel?.text = modes?[indexPath.row].rawValue
        cell?.accessoryType = .disclosureIndicator
        
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let mode = modes?[indexPath.row] else { return }
        customUI?.select(acquireMode: mode)
    }
    
}

extension AcquireModeViewController {
    enum Cell {
        case basic
        
        var identifier: String {
            switch self {
            case .basic: return "com.jumio.reuse.identifier.basic"
            }
        }
        
        var `class`: AnyClass {
            switch self {
            case .basic: return UITableViewCell.self
            }
        }
    }
}
