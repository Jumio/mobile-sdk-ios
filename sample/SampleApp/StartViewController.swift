//
//  StartViewController.swift
//
//  Copyright © 2024 Jumio Corporation. All rights reserved.
//

import UIKit
import Jumio

class StartViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet var startButton: CustomButton!
    @IBOutlet weak var consentTableView: UITableView!
    @IBOutlet weak var overviewLabel: UILabel!
    
    // MARK: - Properties
    private var needsToConsent: Bool = false
    private var consentItems: [Jumio.ConsentItem]?
    private var activeConsents: [String: Bool]?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startButton.design = .positive
        startButton.setTitle("loading...", for: .disabled)
        startButton.isEnabled = false
    }
    
    // MARK: - IBActions
    @IBAction func start(_ sender: Any) {
        if needsToConsent, let consentItems = consentItems {
            customUI?.userConsented(consentItems: consentItems)
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
    
    func handle(consentItems: [Jumio.ConsentItem]) {
        consentTableView.isHidden = false
        needsToConsent = true
        self.consentItems = consentItems
        activeConsents = [:]
        updateStartButton()
        consentTableView.reloadData()
    }
    
    func updateStartButton() {
        startButton.isUserInteractionEnabled = true
        // User can not proceed without accepting all active consent types explicitly
        guard let consentItems = consentItems else { return }
        for consentItem in consentItems where consentItem.type == .active {
            if activeConsents?[consentItem.id] != true {
                startButton.isUserInteractionEnabled = false
                return
            }
        }
    }
}

extension StartViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        consentItems?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()

        guard let consentItems = consentItems else { return cell }
        let consentItem = consentItems[indexPath.row]
        cell.textLabel?.attributedText = consentItem.attributedText
        cell.textLabel?.numberOfLines = 0
        
        // if type is .active, you need to add a UI element that allows the user to consent explicitly to this consent item
        if consentItem.type == .active {
            let consentSwitch = UISwitch(frame: .zero) as UISwitch
            consentSwitch.isOn = false
            consentSwitch.addTarget(self, action: #selector(consentValueChanged), for: .valueChanged)
            consentSwitch.tag = indexPath.row
            cell.accessoryView = consentSwitch
        }
        return cell
    }
    
    // Create a URL from the value url inside Jumio.ConsentItem and open it to allow the user to check the privacy policy of this item
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let consentItems = consentItems else { return }
        let consentItem = consentItems[indexPath.row]
        guard let url = URL(string: consentItem.url), UIApplication.shared.canOpenURL(url) else { return }
        UIApplication.shared.open(url)
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    @objc func consentValueChanged(sender: UISwitch) {
        guard let consentItems = consentItems else { return }
        let consentItem = consentItems[sender.tag]
        // keep the user decsision for active consent items stored in a seperate dictionary
        activeConsents?[consentItem.id] = sender.isOn
        updateStartButton()
    }
    
}
