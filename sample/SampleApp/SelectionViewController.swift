//
//  SelectionViewController.swift
//
//  Copyright © 2022 Jumio Corporation. All rights reserved.
//

import UIKit
import Jumio

class SelectionViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var countryTableView: UITableView!
    @IBOutlet weak var documentTableView: UITableView!
    
    // MARK: - Properties
    var countryMap: [String: [Jumio.Document]] = [:]
    var countries: [Country] = []
    
    fileprivate var selectedCountry: String?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        countries = countryMap.keys.map {
            let isoAlpha2 = Jumio.ISOCountryConverter.toAlpha2($0)
            return Country(code: $0, localizedName: Locale.current.localizedString(forRegionCode: isoAlpha2 ?? $0) ?? $0)
        }
        countries = countries.sorted { $0.localizedName < $1.localizedName }
        
        selectedCountry = customUI?.suggestedCountry
        
        countryTableView.layer.cornerRadius = 10
        countryTableView.delegate = self
        countryTableView.dataSource = self
        countryTableView.register(Cell.basic.class, forCellReuseIdentifier: Cell.basic.identifier)
        countryTableView.reloadData()
        
        documentTableView.layer.cornerRadius = 10
        documentTableView.delegate = self
        documentTableView.dataSource = self
        documentTableView.register(Cell.basic.class, forCellReuseIdentifier: Cell.basic.identifier)
        documentTableView.reloadData()
    }
    
    // MARK: - Functions
    func document(from indexPath: IndexPath) -> Jumio.Document? {
        guard let selectedCountry = selectedCountry,
              let document = countryMap[selectedCountry]?[indexPath.row] else { return nil }
        return document
    }
    
}

// MARK: - Country
extension SelectionViewController {
    struct Country {
        var code: String
        var localizedName: String
    }
}

// MARK: - Cell
extension SelectionViewController {
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

// MARK: - UITableViewDelegate & DataSource
extension SelectionViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView {
        case countryTableView:
            return countries.count
        case documentTableView:
            guard let country = selectedCountry else { return 0 }
            return countryMap[country]?.count ?? 0
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cell.basic.identifier)
        
        switch tableView {
        case countryTableView:
            cell?.textLabel?.text = countries[indexPath.row].localizedName
            cell?.accessoryType = selectedCountry == countries[indexPath.row].code ? .checkmark : .none
        case documentTableView:
            guard let document = document(from: indexPath) else { break }
            cell?.textLabel?.text = "\(document.type.rawValue) \(document.variant.rawValue)"
            cell?.accessoryType = .disclosureIndicator
        default:
            break
        }
        
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch tableView {
        case countryTableView:
            selectedCountry = countries[indexPath.row].code
            countryTableView.reloadData()
            documentTableView.reloadData()
        case documentTableView:
            guard let country = selectedCountry,
                  let document = document(from: indexPath) else { break }
            customUI?.select(country: country, document: document)
        default:
            break
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
