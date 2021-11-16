//
//  DefaultUI.swift
//  SampleApp-UIKit
//
//  Created by Ormir Gjurgjej on 12.07.21.
//

import UIKit
import Jumio

protocol DefaultUIDelegate: AnyObject {
    func defaultUIDidFinish(with result: Jumio.Result)
}

class DefaultUI {
    typealias Delegate = DefaultUIDelegate
    
    fileprivate var jumio: Jumio.SDK?
    weak var delegate: DefaultUI.Delegate?
    
    var viewController: Jumio.ViewController? {
        do {
            let vc = try jumio?.viewController()
            return vc
        } catch let error {
            print(error)
        }
        
        print("Couldn't get a jumio viewController!")
        return nil
    }
    
    func start(with token: String, dataCenter: Jumio.DataCenter) {
        jumio = Jumio.SDK()
        jumio?.defaultUIDelegate = self
        jumio?.token = token
        jumio?.dataCenter = dataCenter
        
        jumio?.startDefaultUI()
    }
    
    func clean() {
        jumio = nil
    }
}

extension DefaultUI: Jumio.DefaultUIDelegate {
    func jumio(sdk: Jumio.SDK, finished result: Jumio.Result) {
        delegate?.defaultUIDidFinish(with: result)
    }
}
