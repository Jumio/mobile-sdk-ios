//
//  DefaultUI.swift
//
//  Copyright © 2024 Jumio Corporation. All rights reserved.
//

import UIKit
import Jumio

protocol DefaultUIDelegate: AnyObject {
    func defaultUIDidFinish(with result: Jumio.Result)
}

class DefaultUI {
    typealias Delegate = DefaultUIDelegate
    
    private var jumio: Jumio.SDK?
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
        // Uncomment the following lines if you want to check customization options inside the SDK
        // let customTheme = customizeSDKColors()
        // jumio?.customize(theme: customTheme)
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
