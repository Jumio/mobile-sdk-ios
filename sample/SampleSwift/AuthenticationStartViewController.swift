//
//  AuthenticationStartViewController.swift
//
//  Copyright © 2019 Jumio Corporation. All rights reserved.
//

import UIKit
import NetverifyFace

class AuthenticationStartViewController: StartViewController, AuthenticationControllerDelegate, AuthenticationScanViewControllerDelegate {

    @IBOutlet weak var transactionReferenceTextField: UITextField!
    var activityIndicatorView: UIActivityIndicatorView?
    var activityIndicatorConstraints = [NSLayoutConstraint]()
    
    var authenticationController: AuthenticationController?
    var authenticationScanViewController: UIViewController?
    
    @IBAction func startAuthentication() {
        self.createAuthenticationController()
    }
    
    @IBAction func startCustomUI() {
        self.createAuthenticationController(withCustomUI: true)
    }
    
    func createAuthenticationController(withCustomUI:Bool = false) {
        
        //Prevent SDK to be initialized on Jailbroken devices
        if JumioDeviceInfo.isJailbrokenDevice() {
            return
        }
        
        // Setup the Configuration for Authentication
        let config: AuthenticationConfiguration = createAuthenticationConfiguration(withCustomUI: withCustomUI)
        
        
        //Perform the following call as soon as your app’s view controller is initialized. Create the AuthenticationController instance by providing your Configuration with required API token, API secret and a delegate object.
        do {
            try ObjcExceptionHelper.catchException {
                self.authenticationController = AuthenticationController(configuration: config)
            }
        } catch {
            let err = error as NSError
            self.showAlert(withTitle: err.localizedDescription, message: err.userInfo[NSLocalizedFailureReasonErrorKey] as? String ?? "")
        }
    }
    
    func createAuthenticationConfiguration(withCustomUI:Bool) -> AuthenticationConfiguration {
        let config = AuthenticationConfiguration()
        
        //Provide your API token
        config.apiToken = "YOUR_AUTHENTICATION_APITOKEN"
        //Provide you API secret
        config.apiSecret = "YOUR_AUTHENTICATION_APISECRET"
        
        //Set the delegate that implements AuthenticationControllerDelegate
        config.delegate = self
        
        //Use the following property to reference the Authentication transaction to a specific Netverify user identity
        //config.enrollmentTransactionReference = "ENROLLMENT_TRANSACTION_REFERENCE"
        config.enrollmentTransactionReference = transactionReferenceTextField.text!
        
        //Set the dataCenter; default is JumioDataCenterUS
        //config.dataCenter = JumioDataCenterEU
        
        if (withCustomUI) {
            config.authenticationScanViewControllerDelegate = self
            
            JumioBaseView.jumioAppearance().disableBlur = true
            JumioBaseView.jumioAppearance().foregroundColor = UIColor.white
            JumioBaseView.jumioAppearance().backgroundColor = UIColor.init(red: 44/250.0, green: 152/250.0, blue: 240/250.0, alpha: 1.0)
        }
        
        //You can also set a customer identifier (max. 100 characters). Note: The customer ID should not contain sensitive data like PII (Personally Identifiable Information) or account login.
        //config.userReference = "USER_REFERENCE"
        
        //Callback URL (max. 255 characters) for the confirmation after the authentication is completed. This setting overrides your Jumio account settings.
        //config.callbackUrl = "https://www.example.com"
        
        //Configure your desired status bar style
        //config.statusBarStyle = UIStatusBarStyleLightContent
        
        //Localizing labels
        //All label texts and button titles can be changed and localized using the Localizable-Authentication.strings file. Just adapt the values to your required language and use this file in your app.
        
        //Customizing look and feel
        //The SDK can be customized via UIAppearance to fit your application’s look and feel.
        //Please note, that only the below listed UIAppearance selectors are supported and taken into consideration. Experimenting with other UIAppearance or not UIAppearance selectors may cause unexpected behaviour or crashes both in the SDK or in your application. This is best avoided.
        
        // - Navigation bar: tint color, title color, title image
        //UINavigationBar.jumioAppearance().tintColor = UIColor.yellow
        //UINavigationBar.jumioAppearance().barTintColor = UIColor.red
        //UINavigationBar.jumioAppearance().titleTextAttributes = [kCTForegroundColorAttributeName: UIColor.white] as [NSAttributedStringKey : Any]
        
        //AuthenticationNavigationBarTitleImageView.jumioAppearance().titleImage = UIImage.init(named: "<your-navigation-bar-title-image>")
        
        // - Custom general appearance - deactivate blur
        //JumioBaseView.jumioAppearance().disableBlur = true
        
        // - Custom general appearance - background color
        //JumioBaseView.jumioAppearance().backgroundColor = UIColor.lightGray
        
        // - Custom general appearance - foreground color (text-elements and icons)
        //JumioBaseView.jumioAppearance().foregroundColor = UIColor.red
        
        // - Custom Positive Button Background Colors, custom class has to be imported (the same applies to JumioNegativeButton)
        //JumioPositiveButton.jumioAppearance().setBackgroundColor(UIColor.cyan, for: UIControlState.normal)
        //JumioPositiveButton.jumioAppearance().setBackgroundColor(UIColor.blue, for: UIControlState.highlighted)
        
        //Custom Positive Button Background Image, custom class has to be imported
        //JumioPositiveButton.jumioAppearance().setBackgroundImage(UIImage.init(named: "<your-custom-image>"), for: UIControlState.normal)
        //JumioPositiveButton.jumioAppearance().setBackgroundImage(UIImage.init(named: "<your-custom-image>"), for: UIControlState.highlighted)
        
        //Custom Positive Button Title Colors, custom class has to be imported
        //JumioPositiveButton.jumioAppearance().setTitleColor(UIColor.gray, for: UIControlState.normal)
        //JumioPositiveButton.jumioAppearance().setTitleColor(UIColor.magenta, for: UIControlState.highlighted)
        
        //Custom Positive Button Title Colors, custom class has to be imported
        //JumioPositiveButton.jumioAppearance().borderColor = UIColor.green
        
        // Color for the face oval outline
        //JumioScanOverlayView.jumioAppearance().faceOvalColor = UIColor.orange
        // Color for the progress bars
        //JumioScanOverlayView.jumioAppearance().faceProgressColor = UIColor.purple
        // Color for the background of the feedback view
        //JumioScanOverlayView.jumioAppearance().faceFeedbackBackgroundColor = UIColor.yellow
        // Color for the text of the feedback view
        //JumioScanOverlayView.jumioAppearance().faceFeedbackTextColor = UIColor.brown
        
        // - Custom general appearance - font
        //The font has to be loaded upfront within the mainBundle before initializing the SDK
        //JumioBaseView.jumioAppearance().customLightFontName = "<your-font-name-loaded-in-your-app>"
        //JumioBaseView.jumioAppearance().customRegularFontName = "<your-font-name-loaded-in-your-app>"
        //JumioBaseView.jumioAppearance().customMediumFontName = "<your-font-name-loaded-in-your-app>"
        //JumioBaseView.jumioAppearance().customBoldFontName = "<your-font-name-loaded-in-your-app>"
        //JumioBaseView.jumioAppearance().customItalicFontName = "<your-font-name-loaded-in-your-app>"
        
        //You can get the current SDK version using the method below.
        //print("\(AuthenticationController.sdkVersion())")
        
        return config
    }
    
    /**
     * Implement the following delegate method to receive the scanViewController to present, after initialization was finished successfully.
     * @param authenticationController the AuthenticationController instance
     * @param scanViewController UIViewController object to present
     **/
    
    func authenticationController(_ authenticationController: AuthenticationController, didFinishInitializingScanViewController scanViewController: AuthenticationScanViewController) {
        print("AuthenticationController did finish initializing")
        self.authenticationScanViewController = scanViewController
        self.present(self.authenticationScanViewController!, animated: true, completion: nil)
    }
    
    /**
     * Implement the following delegate method to receive the final AuthenticationResult.
     * Dismiss the SDK view in your app once you received the result.
     * @param authenticationController the AuthenticationController instance
     * @param authenticationResult contains final authentication result (success or failed)
     * @param transactionReference the unique identifier of the scan session
     **/
    func authenticationController(_ authenticationController: AuthenticationController, didFinishWith authenticationResult: AuthenticationResult, transactionReference: String) {
        print("AuthenticationController finished successfully with transaction reference: \(transactionReference)")
        self.removeActivityIndicator()
        
        var message = ""
        switch authenticationResult {
        case .success:
            message = "Authentication process was successful"
            break
        default:
            message = "Authentication process failed"
            break
        }
        
        self.authenticationScanViewController!.dismiss(animated: true, completion: {
            print(message)
            self.showAlert(withTitle: "Authentication Mobile SDK", message: message as String)
            self.authenticationController?.destroy()
            self.authenticationController = nil
        })
    }
    
    /**
     * Implement the following delegate method for successful scans and user cancellation notifications.
     * Dismiss the SDK view in your app once you received the result.
     * @param authenticationController the AuthenticationController instance
     * @param error holds more detailed information about the error reason
     * @param transactionReference the unique identifier of the scan session
     **/
    func authenticationController(_ authenticationController: AuthenticationController, didFinishWithError error: AuthenticationError, transactionReference: String?) {
        let message = "AuthenticationController finished with error: \(error.message) transactionReference: \(transactionReference ?? "")"
        print(message)
        self.removeActivityIndicator()
        
        //Dismiss the SDK
        let errorCompletion = {
            self.showAlert(withTitle: "Authentication Mobile SDK", message: message)
            self.authenticationController?.destroy()
            self.authenticationController = nil
        }
        
        if let maybeAuthenticationScanViewController = self.authenticationScanViewController {
            maybeAuthenticationScanViewController.dismiss(animated: true, completion: errorCompletion)
        } else {
            errorCompletion()
        }
    }
    
    //MARK: AuthenticationScanViewControllerDelegate implementation
    func authenticationScanViewControllerDidStartBiometricAnalysis(_ authenticationScanViewController: AuthenticationScanViewController) {
        self.activityIndicatorView = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.whiteLarge)
        self.activityIndicatorView?.translatesAutoresizingMaskIntoConstraints = false
        self.activityIndicatorView?.color = UIColor.darkGray
        self.activityIndicatorView?.startAnimating()
        
        authenticationScanViewController.customOverlayLayer.addSubview(self.activityIndicatorView!)
        
        self.activityIndicatorConstraints.append(NSLayoutConstraint(item: self.activityIndicatorView!, attribute: .centerX, relatedBy: .equal, toItem: authenticationScanViewController.customOverlayLayer, attribute: .centerX, multiplier: 1.0, constant: 0.0))
        self.activityIndicatorConstraints.append(NSLayoutConstraint(item: self.activityIndicatorView!, attribute: .centerY, relatedBy: .equal, toItem: authenticationScanViewController.customOverlayLayer, attribute: .centerY, multiplier: 1.0, constant: 0.0))
        NSLayoutConstraint.activate(self.activityIndicatorConstraints)
    }
    
    func authenticationScanViewController(_ authenticationScanViewController: AuthenticationScanViewController, shouldDisplayHelpWithText message: String, animationView: UIView) {
        print("AuthenticationScanViewController shouldDisplayHelpWithText: \(message)")
        self.removeActivityIndicator()
        
        guard let helpAnimationView = Bundle.main.loadNibNamed("HelpAnimationView", owner: self, options: nil)?.first as? HelpAnimationView else { return }
        helpAnimationView.translatesAutoresizingMaskIntoConstraints = false
        helpAnimationView.descriptionLabel.text = message
        helpAnimationView.addContinueHandler(action: {
            helpAnimationView.removeFromSuperview()
            authenticationScanViewController.retryScan()
        })
        
        helpAnimationView.animationView.addSubview(animationView)
        helpAnimationView.animationView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[animationView]|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: ["animationView":animationView]))
        helpAnimationView.animationView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[animationView]|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: ["animationView":animationView]))
        
        authenticationScanViewController.customOverlayLayer.addSubview(helpAnimationView)
        authenticationScanViewController.customOverlayLayer.bringSubviewToFront(helpAnimationView)
        authenticationScanViewController.customOverlayLayer.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[helpView]|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: ["helpView":helpAnimationView]))
        authenticationScanViewController.customOverlayLayer.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[helpView]|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: ["helpView":helpAnimationView]))
    }
    
    func authenticationScanViewController(_ authenticationScanViewController: AuthenticationScanViewController, didDetermineRecoverableError error: AuthenticationError) {
        let message = "AuthenticationScanViewController didDetermineRecoverableError: \(error.message) (\(error.code))"
        print(message)
        
        self.removeActivityIndicator()
        
        let alert = UIAlertController(title: "Authentication Mobile SDK", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Retry", style: .default, handler: {(_: UIAlertAction!) in
            authenticationScanViewController.retryAfterError()
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: {(_: UIAlertAction!) in
            authenticationScanViewController.cancel()
            authenticationScanViewController.dismiss(animated: true)
        }))
        
        authenticationScanViewController.present(alert, animated: true, completion: nil)
    }
    
    // Helper methods
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let transactionReference =  UserDefaults.standard.object(forKey: "enrollmentTransactionReference") as? String {
            transactionReferenceTextField.text = transactionReference
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        
        if let scanReference = transactionReferenceTextField.text {
            UserDefaults.standard.set(scanReference, forKey: "enrollmentTransactionReference")
        }
    }
    
    @IBAction func transactionReference_onDone(_ sender: Any) {
        self.view.endEditing(true)
        
        if let scanReference = transactionReferenceTextField.text {
            UserDefaults.standard.set(scanReference, forKey: "enrollmentTransactionReference")
        }
    }
    
    func removeActivityIndicator() {
        guard self.activityIndicatorView != nil else { return}
        
        NSLayoutConstraint.deactivate(activityIndicatorConstraints)
        self.activityIndicatorConstraints.removeAll()
        
        self.activityIndicatorView?.removeFromSuperview()
        self.activityIndicatorView = nil
        
    }
}
