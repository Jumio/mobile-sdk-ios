//
//  SelectionViewController.swift
//
//  Copyright © 2024 Jumio Corporation. All rights reserved.
//

import UIKit
import Jumio

protocol SelectionViewControllerDelegate: AnyObject {
    func selectionViewController(_ sender: SelectionViewController, physicalDocumentsFor country: String) -> [Jumio.Document.Physical]
    func selectionViewController(_ sender: SelectionViewController, digitalDocumentsFor country: String) -> [Jumio.Document.Digital]
}

class SelectionViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var countryTableView: UITableView!
    @IBOutlet weak var documentTableView: UITableView!
    
    // MARK: - Properties
    var countryArray: [String] = []
    weak var delegate: SelectionViewControllerDelegate?
    
    private var countries: [Country] = []
    private var selectedCountry: String?
    private var documents: [Jumio.Document] {
        guard let selectedCountry = selectedCountry else { return [] }
        let physicalDocuments = delegate?.selectionViewController(self, physicalDocumentsFor: selectedCountry) ?? []
        let digitalDocuments = delegate?.selectionViewController(self, digitalDocumentsFor: selectedCountry) ?? []
        return physicalDocuments + digitalDocuments
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        countries = countryArray.map {
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
        guard indexPath.row < documents.count else { return nil }
        return documents[indexPath.row]
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
            return documents.count
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
            if let physicalDocument = document as? Jumio.Document.Physical {
                cell?.textLabel?.text = "\(physicalDocument.type.rawValue) \(physicalDocument.variant.rawValue)"
            } else if let digitalDocument = document as? Jumio.Document.Digital {
                cell?.textLabel?.text = "\(digitalDocument.title)"
            }
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
