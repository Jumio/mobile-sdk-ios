//
//  BAMCheckoutStartViewController.swift
//
//  Copyright © 2019 Jumio Corporation All rights reserved.
//

import BAMCheckout

class BAMCheckoutStartViewController: StartViewController, BAMCheckoutViewControllerDelegate {
    @IBOutlet weak var switchCvvRequired:UISwitch!
    var bamCheckoutViewController:BAMCheckoutViewController?
    
    func createBAMCheckoutController() -> Void {
        
        //prevent SDK to be initialized on Jailbroken devices
        if JumioDeviceInfo.isJailbrokenDevice() {
            return
        }
        
        //Setup the Configuration for BAMCheckout
        let config:BAMCheckoutConfiguration = BAMCheckoutConfiguration()
        //Provide your API token and your API secret
        //Do not store your credentials hardcoded within the app. Make sure to store them server-side and load your credentials during runtime.
        config.apiToken = "YOUR_BAMCHECKOUT_APITOKEN"
        config.apiSecret = "YOUR_BAMCHECKOUT_APISECRET"
        
        //Set the delegate that implements BAMCheckoutViewControllerDelegate
        config.delegate = self
        
        //Set the dataCenter; default is JumioDataCenterUS
        //config.dataCenter = JumioDataCenterEU
        //config.dataCenter = JumioDataCenterSG
        
        //Use the following property to enable offline credit card scanning.
        //config.offlineToken = "YOUR_OFFLINE_TOKEN"
        
        //Use the following property to identify the scan in your reports (max. 100 characters).
        //config.reportingCriteria = "YOURREPORTINGCRITERIA"
        
        //To restrict supported card types, pass a bitmask of BAMCheckoutCreditCardTypes to the property supportedCreditCardTypes.
        //let cardTypes:BAMCheckoutCreditCardTypes = BAMCheckoutCreditCardTypes(BAMCheckoutCreditCardType.all.rawValue)
        //let cardTypes:BAMCheckoutCreditCardTypes = BAMCheckoutCreditCardTypes(BAMCheckoutCreditCardType.americanExpress.rawValue | BAMCheckoutCreditCardType.chinaUnionPay.rawValue | BAMCheckoutCreditCardType.diners.rawValue | BAMCheckoutCreditCardType.discover.rawValue | BAMCheckoutCreditCardType.JCB.rawValue | BAMCheckoutCreditCardType.masterCard.rawValue | BAMCheckoutCreditCardType.visa.rawValue)
        //config.supportedCreditCardTypes = cardTypes
        
        //Expiry recognition, card holder name and CVV entry are enabled by default and can be disabled.
        //You can enable the recognition of sort code and account number.
        //config.expiryRequired = false
        //config.cardHolderNameRequired = false
        config.cvvRequired = self.switchCvvRequired.isOn
        //config.sortCodeAndAccountNumberRequired = true
        
        //You can show the unmasked credit card number to the user during the workflow if cardNumberMaskingEnabled is disabled
        //config.cardNumberMaskingEnabled = false
        
        //The user can edit the recognized expiry date if expiryEditable is enabled.
        //config.expiryEditable = true
        
        //The user can edit the recognized card holder name if cardHolderNameEditable is enabled.
        //config.cardHolderNameEditable = true
        
        //You can set a short vibration (only on iPhone) and sound effect to notify the user that the card has been detected.
        //config.vibrationEffectEnabled = true
        //config.soundEffect = "YOURSOUNDFILE.aif"
        
        //Automatically enable flash when scan is started
        //config.enableFlashOnScanStart = true
        
        //Set the default camera position
        //config.cameraPosition = JumioCameraPositionFront
        
        //Configure your desired status bar style
        //config.statusBarStyle = .lightContent
        
        //You can add custom fields to the "Additional Info" view (text input field or selection)
        //config.addCustomField("idZipCode", title: "Zip code", keyboardType: .numberPad, regularExpression: "[0-9]{5,}")
        
        //let states = ["Alabama", "Alaska", "Arizona", "Arkansas", "California", "Colorado", "Connecticut", "Delaware", "Florida", "Georgia", "Hawaii", "Idaho", "Illinois", "Indiana", "Iowa", "Kansas", "Kentucky", "Louisiana", "Maine", "Maryland", "Massachusetts", "Michigan", "Minnesota", "Mississippi", "Missouri", "Montana", "Nebraska", "Nevada", "New Hampshire", "New Jersey", "New Mexico", "New York", "North Carolina", "North Dakota", "Ohio", "Oklahoma", "Oregon", "Pennsylvania", "Rhode Island", "South Carolina", "South Dakota", "Tennessee", "Texas", "Utah", "Vermont", "Virginia", "Washington", "West Virginia", "Wisconsin", "Wyoming"]
        //config.addCustomField("idState", title: "State", values: states, required: false, resetValueText: "-- no value --")
        //or
        //config.addCustomField("idState", title: "State", values: states, required: true, resetValueText: "not shown")
        
        //Localizing labels
        //All label texts and button titles can be changed and localized using the Localizable-BAMCheckout.strings file. Just adapt the values to your required language and add this file in your Xcode project.
        
        //Customizing look and feel
        //The SDK can be customized to fit your application’s look and feel.
        //Please note, that only the below listed UIAppearance selectors are supported and taken into consideration. Experimenting with other UIAppearance or not UIAppearance selectors may cause unexpected behaviour or crashes both in the SDK or in your application. This is best avoided.
        
        // - Customize buttons: title color, background color, background image selectors for BAMCheckoutPositiveButton, BAMCheckoutNegativeButton
        
        //BAMCheckoutPositiveButton.jumioAppearance().setBackgroundColor(.cyan, for: .normal)
        //BAMCheckoutPositiveButton.jumioAppearance().setBackgroundColor(.blue, for: .highlighted)
        
        //BAMCheckoutPositiveButton.jumioAppearance().setTitleColor(.gray, for: .normal)
        //BAMCheckoutPositiveButton.jumioAppearance().setTitleColor(.magenta, for: .highlighted)
        
        //If a backgroundImage is set, backgroundColor will have no effect
        //BAMCheckoutPositiveButton.jumioAppearance().setBackgroundImage(UIImage.init(named: "<your-custom-image>"), for: .normal)
        //BAMCheckoutPositiveButton.jumioAppearance().setBackgroundImage(UIImage.init(named: "<your-custom-image>"), for: .highlighted)
        
        // - Navigation bar: tint color, title color, title image
        //UINavigationBar.jumioAppearance().tintColor = .yellow
        //UINavigationBar.jumioAppearance().barTintColor = .red
        //UINavigationBar.jumioAppearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white] as [NSAttributedString.Key : Any]
        
        //JumioNavigationBarTitleImageView.jumioAppearance().titleImage = UIImage.init(named: "<your-navigation-bar-title-image>")
        
        // - Custom general appearance - font
        //The font has to be loaded upfront within the mainBundle before initializing the SDK
        //BAMCheckoutBaseView.jumioAppearance().customLightFontName = "<your-font-name-loaded-in-your-app>"
        //BAMCheckoutBaseView.jumioAppearance().customRegularFontName = "<your-font-name-loaded-in-your-app>"
        //BAMCheckoutBaseView.jumioAppearance().customMediumFontName = "<your-font-name-loaded-in-your-app>"
        //BAMCheckoutBaseView.jumioAppearance().customBoldFontName = "<your-font-name-loaded-in-your-app>"
        
        // - Custom general appearance - deactivate blur
        //BAMCheckoutBaseView.jumioAppearance().disableBlur = true
        
        // - Custom general appearance - background color
        //BAMCheckoutBaseView.jumioAppearance().backgroundColor = .gray
        
        // - Custom general appearance - foreground color (text-elements and icons)
        //BAMCheckoutBaseView.jumioAppearance().foregroundColor = .red
        
        // - Custom general appearance - ScanOverlay border color
        //BAMCheckoutScanOverlay.jumioAppearance().borderColor = .green
        
        // - Custom general appearance - ScanOverlay text color
        //BAMCheckoutScanOverlay.jumioAppearance().textColor = .blue
        
        //You can get the current SDK version using the method below.
        //print("\(BAMCheckoutViewController.sdkVersion())")
        
        //Perform the following call as soon as your app’s view controller is initialized. This creates the BAMCheckoutViewController instance by providing your Configuration with required API token, API secret and a delegate object.
        do {
            try ObjcExceptionHelper.catchException {
                self.bamCheckoutViewController = BAMCheckoutViewController.init(configuration: config)
            }
        } catch {
            let err = error as NSError
            self.showAlert(withTitle: err.localizedDescription, message: err.userInfo[NSLocalizedFailureReasonErrorKey] as? String ?? "")
        }
        
        if (UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad) {
            self.bamCheckoutViewController?.modalPresentationStyle = UIModalPresentationStyle.formSheet;  // For iPad, present from sheet
        }
    }
    
    /**
     * Create the BAMCheckoutViewController with a custom ScanOverlay
     */
    func createBAMCheckoutControllerCustom() -> Void {
        //Perform the following call as soon as your app’s view controller is initialized. This creates the BAMCheckoutViewController instance by providing your Configuration with required API token, API secret, a delegate object and custom overlay.
        //Use the following snippet instead to initialize the BAMCheckoutViewController with a custom OverlayViewController
        let customOverlay:CustomScanOverlayViewController = CustomScanOverlayViewController(nibName: "CustomScanOverlayViewControllerSwift", bundle: nil)
    
        let config:BAMCheckoutConfiguration = BAMCheckoutConfiguration()
        config.apiToken = "YOUR_BAMCHECKOUT_APITOKEN"
        config.apiSecret = "YOUR_BAMCHECKOUT_APISECRET"
        config.delegate = self
        config.customOverlay = customOverlay
    
        self.bamCheckoutViewController = BAMCheckoutViewController.init(configuration: config)
    }
    
    @IBAction func startBAMCheckout() -> Void {
        //Create the BAMCheckoutViewController with default overlay
        self.createBAMCheckoutController()
        
        //Create the BAMCheckoutViewController with custom overlay
        //self.createBAMCheckoutControllerCustom()
        
        if let bamCheckoutVC = self.bamCheckoutViewController {
            self.present(bamCheckoutVC, animated: true, completion: nil)
        } else {
            showAlert(withTitle: "BAMCheckout Mobile SDK", message: "BAMCheckoutViewController is nil")
        }
    }
    
    /**
     * Will be called on a scan attempt
     * @param controller The BAMCheckoutViewController
     * @param requestReference The requestReference of the scan attempt
     */
    func bamCheckoutViewController(_ controller: BAMCheckoutViewController, didStartScanAttemptWithScanReference scanReference: String) {
        
    }
    
    /**
     * Upon success, the parameter cardInformation will be returned. Call clear after processing the card information to make sure no sensitive data remains in the device's memory.
     * @param controller The BAMCheckoutViewController
     * @param cardInformation The card information result
     * @param scanReference The reference of the scan attempt
     */
    func bamCheckoutViewController(_ controller: BAMCheckoutViewController, didFinishScanWith cardInformation: BAMCheckoutCardInformation, scanReference: String) {
        
        //Use the cardInformation
        let cardNumber:NSMutableString = cardInformation.cardNumber
        let cardNumberGrouped:NSMutableString = cardInformation.cardNumberGrouped
        let expiryMonth:NSMutableString? = cardInformation.cardExpiryMonth
        let expiryYear:NSMutableString? = cardInformation.cardExpiryYear
        let expiryDate:NSMutableString? = cardInformation.cardExpiryDate
        let cvv:NSMutableString? = cardInformation.cardCVV
        let cardHolderName:NSMutableString? = cardInformation.cardHolderName
        let sortCode:NSMutableString? = cardInformation.cardSortCode
        let accountNumber:NSMutableString? = cardInformation.cardAccountNumber
        let sortCodeValid:Bool = cardInformation.cardSortCodeValid
        let accountNumberValid:Bool = cardInformation.cardAccountNumberValid
        
        //Get the value of the additional field
        //let zipCode = [cardInformation getCustomField: @"idZipCode"];
        //print("Additional field value: %@", zipCode);
        
        let message:NSMutableString = NSMutableString.init()
        message.appendFormat("Request reference: %@\nCard number: %@\nGrouped: %@\n", scanReference, cardNumber as String, cardNumberGrouped as String)
        if (expiryDate != nil) { message.appendFormat("Expiry date: %@\nExpiry date month: %@\nExpiry date year: %@\n", expiryDate as String? ?? "", expiryMonth!, expiryYear!) }
        if (cvv != nil) { message.appendFormat("CVV code: %@\n", cvv!) }
        if (cardHolderName != nil) { message.appendFormat("Card holder: %@\n", cardHolderName!) }
        if (sortCode != nil) {
            message.appendFormat("Sort code: %@\n", sortCode!)
            message.appendFormat("Sort Code valid: %@\n", String(sortCodeValid))
        }
        if (accountNumber != nil) {
            message.appendFormat("Account number: %@\n", accountNumber!)
            message.appendFormat("Account Number valid:",  String(accountNumberValid))
        }
        
        //Dismiss the SDK
        self.dismiss(animated: true, completion: {
            print(message)
            self.showAlert(withTitle: "BAMCheckout Mobile SDK", message: message as String)
            })
    }
    
    /**
     * The parameter error contains the user cancellation reason.
     * @param controller The BAMCheckoutViewController
     * @param error The error codes 200, 210, 220, 240, 250, 260 and 310 will be returned. Using the custom scan view, the error codes 260 and 310 will be returned.
     **/
    func bamCheckoutViewController(_ controller: BAMCheckoutViewController, didCancelWithError error: Error?, scanReference: String?) {
        
        //handle the error cases as highlighted in our documentation: https://github.com/Jumio/mobile-sdk-ios/blob/master/docs/integration_faq.md#managing-errors
        
        print("BAMCheckoutViewController cancelled with error: \(error?.localizedDescription ?? ""), scanReference: \(String(describing: (scanReference != nil) ? scanReference : ""))");
        
        //Dismiss the SDK
        self.dismiss(animated: true, completion: nil)
    }
}
