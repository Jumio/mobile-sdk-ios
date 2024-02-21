//
//  ControllerHandling.swift
//
//  Copyright © 2024 Jumio Corporation. All rights reserved.
//

import Jumio

protocol ControllerHandlingDelegate: AnyObject {
    func controller(consentItems: [Jumio.ConsentItem])
    func controller(overview: [String])
    func controller(displayError: Jumio.Error)
    func controller(finished result: Jumio.Result)
    
    func controller(initialized credentialHandling: CredentialHandling)
}

class ControllerHandling {
    typealias Delegate = ControllerHandlingDelegate
    
    // MARK: - Properties
    weak var delegate: Delegate?
    var isComplete: Bool? { controller?.isComplete }
    
    private var controller: Jumio.Controller?
    private var credentialInformations: [Jumio.Credential.Info]?
    
    // MARK: - Functions
    func start(sdk: Jumio.SDK?) {
        // calling configured sdk instance start function with a Jumio.Controller.Delegate
        // in this case self. With this call we will start the workflow and next callback
        // is our delegate function:
        // jumio(controller: Jumio.Controller, didInitializeWith credentialInformations: [Jumio.Credential.Info], consentItems: [Jumio.ConsentItem]?)
        controller = sdk?.start(self)
    }
    
    func startNextCredential(previousInfo: Jumio.Credential.Info? = nil) {
        // following 3 lines are to work through all credential information
        // all need to be finished in order to be able to finish a workflow
        var index = credentialInformations?.firstIndex { $0.id == previousInfo?.id } ?? 0
        index += previousInfo != nil ? 1 : 0
        guard credentialInformations?.count ?? 0 > index,
              let info = credentialInformations?[index] else { return }
        let credentialHandling = CredentialHandling()
        delegate?.controller(initialized: credentialHandling)
        // same as on SDK -> Controller, let credential handling actually start
        // the credential as a credential instance will be returned
        credentialHandling.start(info: info, with: controller)
    }
    
    func userConsented(to consentItem: Jumio.ConsentItem) {
        controller?.userConsented(to: consentItem, decision: true)
    }
    
    func retry(error: Jumio.Error) {
        controller?.retry(error: error)
    }
    
    func cancel() {
        controller?.cancel()
    }
    
    func finish() {
        controller?.finish()
    }
    
    func clean() {
        controller = nil
        credentialInformations = nil
    }
}

// MARK: - Jumio.Controller.Delegate
extension ControllerHandling: Jumio.Controller.Delegate {
    func jumio(controller: Jumio.Controller, didInitializeWith credentialInformations: [Jumio.Credential.Info], consentItems: [Jumio.ConsentItem]?) {
        // check if consentItems are provided, if yes your user needs to consent to them
        if let consentItems = consentItems {
            delegate?.controller(consentItems: consentItems)
        }
        
        self.credentialInformations = credentialInformations
        let overviewItems: [String] = credentialInformations.map { info in
            switch info.category {
            case .id:
                return "\u{2022} capture your ID"
            case .face:
                return "\u{2022} capture your face"
            case .document:
                return "\u{2022} capture your document"
            @unknown default:
                return "\u{2022} unknown"
            }
        }
        delegate?.controller(overview: overviewItems)
    }
    
    func jumio(controller: Jumio.Controller, error: Jumio.Error) {
        print(error.code, error.message)
        guard controller === self.controller else { return }
        guard error.isRetryable else {
            // if an error is not retry-able the only possibility left is to cancel
            // the controller. This will result in finished call with a Jumio.Result
            // instance containing this error. Instead of instantly cancel, you could
            // inspect, show this given error. In our sample code we just cancel right away.
            controller.cancel()
            return
        }
        delegate?.controller(displayError: error)
    }
    
    func jumio(controller: Jumio.Controller, finished result: Jumio.Result) {
        // workflow is finished with given result.
        // A result can be successful or can contain an occurred error
        delegate?.controller(finished: result)
    }
    
    func jumio(controller: Jumio.Controller, logicalError: Jumio.LogicalError) {
        // Some kind of logical error occurred. Instead of throwing exception on every function, we decided
        // that it will be more convenient, if we are throwing such errors instead.
        // Means every time this function is being called, something was done in a wrong manner.
        // For example .deadCredential: Credential got already finished or canceled, therefore can't executed any action anymore.
        // or .multipleCredential: It is only allowed to have one credential active at a given point in time. You will need to
        // finish or cancel before you are able to initialize a new one.
        print(logicalError)
    }
}
