//
//  SceneDelegate.swift
//
//  Copyright © 2026 Jumio Corporation. All rights reserved.
//

import UIKit
import Jumio

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = scene as? UIWindowScene else { return }
        window = UIWindow(windowScene: windowScene)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let rootViewController = storyboard.instantiateInitialViewController()!
        window?.rootViewController = rootViewController
        window?.makeKeyAndVisible()
        
        // Handling any URLs passed at launch
        if let urlContext = connectionOptions.urlContexts.first {
            _ = Jumio.SDK.handleDeeplinkURL(urlContext.url)
        }
    }
    
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        guard let url = URLContexts.first?.url else { return }
        _ = Jumio.SDK.handleDeeplinkURL(url)
    }
}
