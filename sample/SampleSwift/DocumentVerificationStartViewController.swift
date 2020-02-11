//
//  DocumentVerificationStartViewController.swift
//
//  Copyright © 2019 Jumio Corporation All rights reserved.
//

import DocumentVerification

class DocumentVerificationStartViewController: StartViewController, DocumentVerificationViewControllerDelegate {

    var documentVerificationViewController: DocumentVerificationViewController?
    @IBOutlet weak var enableExtraction: UISwitch!
    
    func createDocumentVerificationController() -> Void {
        
        //prevent SDK to be initialized on Jailbroken devices
        if JumioDeviceInfo.isJailbrokenDevice() {
            return
        }
        
        //Setup the Configuration for DocumentVerification
        let config:DocumentVerificationConfiguration = DocumentVerificationConfiguration()
        //Provide your API token and your API secret
        //Do not store your credentials hardcoded within the app. Make sure to store them server-side and load your credentials during runtime.
        config.apiToken = "YOUR_DOCUMENTVERIFICATION_APITOKEN"
        config.apiSecret = "YOUR_DOCUMENTVERIFICATION_APISECRET"
        //Set the delegate that implements DocumentVerificationViewControllerDelegate
        config.delegate = self
        
        //Set the dataCenter; default is JumioDataCenterUS
        //config.dataCenter = JumioDataCenterEU
        //config.dataCenter = JumioDataCenterSG
        
        //Make sure to specify issuing country (ISO 3166-1 alpha-3 country code)
        config.country = "AUT"
        
        //One of the configured DocumentTypeCodes: BC, BS, CAAP, CB, CCS, CRC, HCC, IC, LAG, LOAP,
        //MEDC, MOAP, PB, SEL, SENC, SS, STUC, TAC, TR, UB, SSC, VC, VT, WWCC, CUSTOM
        config.type = "BC"
        
        //The customer internal reference allows you to identify the scan (max. 100 characters). Note: Must not contain sensitive data like PII (Personally Identifiable Information) or account login.
        config.customerInternalReference = "CUSTOMER_INTERNAL_REFERENCE"
        
        //You can also set a customer identifier (max. 100 characters). Note: The customer ID should not contain sensitive data like PII (Personally Identifiable Information) or account login.
        config.userReference = "USER_REFERENCE"
        
        //Use the following property to identify the scan in your reports (max. 100 characters).
        //config.reportingCriteria = "YOURREPORTINGCRITERIA"
        
        //Callback URL (max. 255 characters) for the confirmation after the verification is completed. This setting overrides your Jumio account settings.
        //config.callbackUrl = "https://www.example.com"
        
        //Set the default camera position
        //config.cameraPosition = JumioCameraPositionFront
        
        //Configure your desired status bar style
        //config.statusBarStyle = .lightContent
        
        // Use a custom document code which can be configured in the settings tab of the Customer Portal
        //config.customDocumentCode = "YOURCUSTOMDOCUMENTCODE"
        
        // Overrides the label for the document name (on Help Screen beside document icon)
        //config.documentName = "DOCUMENTNAME"
        
        // Set the following property to enable/disable data extraction for documents. (default: true)
        config.enableExtraction = enableExtraction.isOn
        
        //Localizing labels
        //All label texts and button titles can be changed and localized using the Localizable-DocumentVerification.strings file. Just adapt the values to your required language and use this file in your app.
        
        //Customizing look and feel
        //The SDK can be customized via UIAppearance to fit your application’s look and feel.
        //Please note, that only the below listed UIAppearance selectors are supported and taken into consideration. Experimenting with other UIAppearance or not UIAppearance selectors may cause unexpected behaviour or crashes both in the SDK or in your application. This is best avoided.
        
        // - Navigation bar: tint color, title color, title image
        
        //UINavigationBar.jumioAppearance().tintColor = .yellow
        //UINavigationBar.jumioAppearance().barTintColor = .red
        //UINavigationBar.jumioAppearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white] as [NSAttributedString.Key : Any]
        
        //JumioNavigationBarTitleImageView.jumioAppearance().titleImage = UIImage.init(named: "<your-navigation-bar-title-image>")
        
        // - Custom general appearance - deactivate blur
        //DocumentVerificationBaseView.jumioAppearance().disableBlur = true
        
        // - Custom general appearance - enable dark mode
        //DocumentVerificationBaseView.jumioAppearance().enableDarkMode = true
        
        // - Custom general appearance - background color
        //DocumentVerificationBaseView.jumioAppearance().backgroundColor = .lightGray
        
        // - Custom general appearance - foreground color (text-elements and icons)
        //DocumentVerificationBaseView.jumioAppearance().foregroundColor = .red
        
        // - Custom general appearance - font
        //The font has to be loaded upfront within the mainBundle before initializing the SDK
        //DocumentVerificationBaseView.jumioAppearance().customLightFontName = "<your-font-name-loaded-in-your-app>"
        //DocumentVerificationBaseView.jumioAppearance().customRegularFontName = "<your-font-name-loaded-in-your-app>"
        //DocumentVerificationBaseView.jumioAppearance().customMediumFontName = "<your-font-name-loaded-in-your-app>"
        //DocumentVerificationBaseView.jumioAppearance().customBoldFontName = "<your-font-name-loaded-in-your-app>"
        //DocumentVerificationBaseView.jumioAppearance().customItalicFontName = "<your-font-name-loaded-in-your-app>"
        
        // - Custom Positive Button Background Colors, custom class has to be imported (the same applies to DocumentVerificationNegativeButton)
        //DocumentVerificationPositiveButton.jumioAppearance().setBackgroundColor(.cyan, for: .normal)
        //DocumentVerificationPositiveButton.jumioAppearance().setBackgroundColor(.blue, for: .highlighted)
        
        //Custom Positive Button Background Image, custom class has to be imported
        //DocumentVerificationPositiveButton.jumioAppearance().setBackgroundImage(UIImage.init(named: "<your-custom-image>"), for: .normal)
        //DocumentVerificationPositiveButton.jumioAppearance().setBackgroundImage(UIImage.init(named: "<your-custom-image>"), for: .highlighted)
        
        //Custom Positive Button Title Colors, custom class has to be imported
        //DocumentVerificationPositiveButton.jumioAppearance().setTitleColor(.gray, for: .normal)
        //DocumentVerificationPositiveButton.jumioAppearance().setTitleColor(.magenta, for: .highlighted)
        
        //Custom Positive Button Title Colors, custom class has to be imported
        //DocumentVerificationPositiveButton.jumioAppearance().borderColor = .green
        
        //You can get the current SDK version using the method below.
        //print("\(DocumentVerificationViewController.sdkVersion())")
        
        //Perform the following call as soon as your app’s view controller is initialized. Create the DocumentVerificationViewController instance by providing your Configuration with required API token, API secret and a delegate object.
        do {
            try ObjcExceptionHelper.catchException {
                self.documentVerificationViewController = DocumentVerificationViewController.init(configuration: config)
            }
        } catch {
            let err = error as NSError
            self.showAlert(withTitle: err.localizedDescription, message: err.userInfo[NSLocalizedFailureReasonErrorKey] as? String ?? "")
        }
    }
    
    @IBAction func startDocumentVerification() -> Void {
        self.createDocumentVerificationController()
        
        if let documentVC = self.documentVerificationViewController {
            self.present(documentVC, animated: true, completion: nil)
        } else {
            showAlert(withTitle: "DocumentVerification Mobile SDK", message: "DocumentVerificationViewController is nil")
        }
    }
    
    /**
     * Implement the following delegate method for successful scans.
     * Dismiss the SDK view in your app once you received the result.
     * @param documentVerificationViewController The DocumentVerificationViewController instance
     * @param scanReference The scanReference of the scan attempt
     **/
    func documentVerificationViewController(_ documentVerificationViewController: DocumentVerificationViewController, didFinishWithScanReference scanReference: String?) {
        let message = "DocumentVerificationViewController finished successfully with scan reference: " + "\(scanReference ?? "")"
        print(message)
        
        //Dismiss the SDK
        self.dismiss(animated: true, completion: {
            self.showAlert(withTitle: "DocumentVerification Mobile SDK", message: message)
        })
    }
    
    /**
     * Implement the following delegate method for successful scans and user cancellation notifications. Dismiss the SDK view in your app once you received the result.
     * @param DocumentVerificationViewController The DocumentVerificationViewController instance
     * @param error The error describing the cause of the problematic situation
     **/
    func documentVerificationViewController(_ documentVerificationViewController: DocumentVerificationViewController, didFinishWithError error: DocumentVerificationError) {
    
        //handle the error cases as highlighted in our documentation: https://github.com/Jumio/mobile-sdk-ios/blob/master/docs/integration_faq.md#managing-errors
        
        print("DocumentVerificationViewController cancelled with error: \(error.message ?? "")")
        
        //Dismiss the SDK
        self.dismiss(animated: true, completion: nil)
    }
}
