//
//  CredentialHandling.swift
//  SampleApp-UIKit
//
//  Created by Christian Henzl on 08.08.21.
//

import Jumio

protocol CredentialHandlingDelegate: AnyObject {
    func credentialNeedsConfiguration(for countries: [String: [Jumio.Document]])
    func credential(initialized scanPartHandling: ScanPartHandling)
}

class CredentialHandling {
    typealias Delegate = CredentialHandlingDelegate
    
    // MARK: - Properties
    weak var delegate: Delegate?
    var isConfigured: Bool { credential?.isConfigured ?? false }
    var isComplete: Bool? { credential?.isComplete }
    
    // IDCredential only
    var suggestedCountry: String? { (credential as? Jumio.IDCredential)?.suggestedCountry }
    fileprivate var countries: [String: [Jumio.Document]] { (credential as? Jumio.IDCredential)?.countries ?? [:] }
    
    fileprivate(set) var info: Jumio.Credential.Info?
    fileprivate var credential: Jumio.Credential?
    fileprivate var scanSides: [Jumio.Scan.Side]?
    
    // MARK: - Functions
    func start(info: Jumio.Credential.Info, with controller: Jumio.Controller?) {
        // to start a credential, you will need the information for it, which is inside the first controllers' delegate
        self.info = info
        // starting a credential with given information
        credential = controller?.start(credentialInfo: info)
        // check if a credentials needs further configuration
        // for example ID credentials without preselection will need a selection of country + document
        if !isConfigured {
            delegate?.credentialNeedsConfiguration(for: countries)
        } else {
            // if it is already configured, you can directly check which scan sides needs to be scanned
            scanSides = credential?.scanSides
            // and actually start scanning
            startNextScanPart()
        }
    }
    
    func select(country: String, document: Jumio.Document) {
        guard let idCredential = credential as? Jumio.IDCredential,
              idCredential.isSupportedConfiguration(country: country, document: document) else { return }
        idCredential.setConfiguration(country: country, document: document)
        // after setting a valid configuration, scan sides are available as they might differ based on set configuration
        scanSides = idCredential.scanSides
        startNextScanPart()
    }
    
    func startNextScanPart(previousScanSide: Jumio.Scan.Side? = nil) {
        // same as on controller level with credential information
        // following 3 lines are to work through all scan sides
        // all need to be finished in order to be able to finish a credential
        var index = scanSides?.firstIndex { $0 == previousScanSide } ?? 0
        index += previousScanSide != nil ? 1 : 0
        guard let scanSide = scanSides?[index] else { return }
        let scanPartHandling = ScanPartHandling()
        delegate?.credential(initialized: scanPartHandling)
        // same as previously let the next object actually start itself
        scanPartHandling.start(scanSide: scanSide, of: credential)
    }
    
    func cancel() {
        credential?.cancel()
    }
    
    func finish() {
        credential?.finish()
    }
    
    func clean() {
        credential = nil
        info = nil
        scanSides = nil
    }
}
