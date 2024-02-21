//
//  CredentialHandling.swift
//
//  Copyright © 2024 Jumio Corporation. All rights reserved.
//

import Jumio

protocol CredentialHandlingDelegate: AnyObject {
    func credentialNeedsConfiguration(for countries: [String])
    func credentialNeedsConfiguration(for acquireModes: [Jumio.Acquire.Mode])
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
    
    private var countries: [String] { (credential as? Jumio.IDCredential)?.supportedCountries ?? [] }
    private(set) var info: Jumio.Credential.Info?
    private var credential: Jumio.Credential?
    private var credentialParts: [Jumio.Credential.Part]?
    
    // MARK: - Functions
    func start(info: Jumio.Credential.Info, with controller: Jumio.Controller?) {
        // to start a credential, you will need the information for it, which is inside the first controllers' delegate
        self.info = info
        // starting a credential with given information
        credential = controller?.start(credentialInfo: info)
        // check if a credentials needs further configuration
        // for example ID credentials without preselection will need a selection of country + document
        if !isConfigured {
            configure(credential: credential)
        } else {
            // if it is already configured, you can directly check which credential parts needs to be scanned
            credentialParts = credential?.parts
            // and actually start scanning
            startNextScanPart()
        }
    }
    
    func select(country: String, document: Jumio.Document) {
        guard let idCredential = credential as? Jumio.IDCredential,
              idCredential.isSupportedConfiguration(country: country, document: document) else { return }
        idCredential.setConfiguration(country: country, document: document)
        configurationFinished()
    }
    
    func select(acquireMode: Jumio.Acquire.Mode) {
        guard let documentCredential = credential as? Jumio.DocumentCredential,
              documentCredential.isSupportedConfiguration(acquireMode: acquireMode) else { return }
        documentCredential.setConfiguration(acquireMode: acquireMode)
        configurationFinished()
    }
    
    func startNextScanPart(previousCredentialPart: Jumio.Credential.Part? = nil) {
        // same as on controller level with credential information
        // following 3 lines are to work through all credential parts
        // all need to be finished in order to be able to finish a credential
        var index = credentialParts?.firstIndex { $0 == previousCredentialPart } ?? 0
        index += previousCredentialPart != nil ? 1 : 0
        guard credentialParts?.count ?? 0 > index,
              let credentialPart = credentialParts?[index] else { return }
        let scanPartHandling = ScanPartHandling()
        delegate?.credential(initialized: scanPartHandling)
        // same as previously let the next object actually start itself
        scanPartHandling.start(credentialPart: credentialPart, of: credential)
    }
    
    func checkAndStartAddon() -> Bool {
        let scanPartHandling = ScanPartHandling()
        // Addons (for example for nfc) can be created, when the previous scan part is finished.
        // For initialization you need a Jumio.Scan.Part.Delegate
        if let addon = credential?.getAddonScanPart(scanPartDelegate: scanPartHandling) {
            // Addon is available and created. Now you can start it.
            delegate?.credential(initialized: scanPartHandling)
            scanPartHandling.start(addon: addon)
            return true
        }
        
        // Addon is not available. Move on with the next scan part or credential.
        return false
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
        credentialParts = nil
    }
    
    func physicalDocuments(for country: String) -> [Jumio.Document.Physical] {
        (credential as? Jumio.IDCredential)?.physicalDocuments(for: country) ?? []
    }
    
    func digitalDocuments(for country: String) -> [Jumio.Document.Digital] {
        (credential as? Jumio.IDCredential)?.digitalDocuments(for: country) ?? []
    }
    
    private func configure(credential: Jumio.Credential?) {
        if (credential as? Jumio.IDCredential) != nil {
            // for id credentials, the country and document type needs to be selected
            delegate?.credentialNeedsConfiguration(for: countries)
        } else if let credential = credential as? Jumio.DocumentCredential {
            // for document credentials, the acquire mode (either camera or file) needs to be selected
            delegate?.credentialNeedsConfiguration(for: credential.acquireModes)
        }
    }
    
    private func configurationFinished() {
        // after setting a valid configuration, credential parts are available as they might differ based on set configuration
        credentialParts = credential?.parts
        startNextScanPart()
    }
    
}
