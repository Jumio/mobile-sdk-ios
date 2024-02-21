//
//  ResultViewController.swift
//
//  Copyright © 2024 Jumio Corporation. All rights reserved.
//

import UIKit
import Jumio

class ResultViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet weak var resultTableView: UITableView!
    @IBOutlet weak var doneButton: CustomButton!
    
    // MARK: - Properties
    var result: Jumio.Result?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        resultTableView.delegate = self
        resultTableView.dataSource = self
        resultTableView.reloadData()
        
        doneButton.design = .positive
    }
    
    // MARK: - IBActions
    @IBAction func done(_ sender: Any) {
        dismiss(animated: true)
    }
}

// MARK: - UITableViewDelegate & DataSource
extension ResultViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        if result?.isSuccess ?? false {
            return result?.credentialInfos.count ?? 0
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard result?.isSuccess ?? false else { return "Error" }
        guard let category = result?.credentialInfos[section].category else { return nil }
        switch category {
        case .id:
            return "ID"
        case .face:
            return "Face"
        case .document:
            return "Document"
        @unknown default:
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard result?.isSuccess ?? false else { return 2 }
        guard let category = result?.credentialInfos[section].category else { return 0 }
        switch category {
        case .id:
            return 2
        case .face:
            return 1
        case .document:
            return 0
        @unknown default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        if result?.isSuccess ?? false,
           let info = result?.credentialInfos[indexPath.section] {
            if info.category == .id,
               let idResult = result?.getIDResult(of: info) {
                switch indexPath.row {
                case 0:
                    cell.textLabel?.text = "Name: \(idResult.firstName ?? "") \(idResult.lastName ?? "")"
                case 1:
                    cell.textLabel?.text = "Country: \(idResult.country ?? "")"
                default:
                    break
                }
            } else if info.category == .face,
                      let faceResult = result?.getFaceResult(of: info) {
                cell.textLabel?.text = "Passed: \(faceResult.passed ?? false ? "yes" : "no")"
            }
        } else if let error = result?.error {
            switch indexPath.row {
            case 0:
                cell.textLabel?.text = "Code: \(error.code)"
            case 1:
                cell.textLabel?.text = "Message: \(error.message)"
            default:
                break
            }
        }
        
        return cell
    }
}
