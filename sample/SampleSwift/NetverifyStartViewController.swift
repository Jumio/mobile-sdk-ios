//
//  NetverifyStartViewController.swift
//
//  Copyright © 2019 Jumio Corporation All rights reserved.
//

import Netverify

class NetverifyStartViewController: StartViewController, NetverifyViewControllerDelegate {
    @IBOutlet weak var switchEnableVerification:UISwitch!
    @IBOutlet weak var switchEnableIdentityVerification:UISwitch!
    var netverifyViewController:NetverifyViewController?
    var customUIController:NetverifyUIController?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func createNetverifyController() -> Void {
        
        //prevent SDK to be initialized on Jailbroken devices
        if JumioDeviceInfo.isJailbrokenDevice() {
            return
        }
        
        //Setup the Configuration for Netverify
        let config:NetverifyConfiguration = createNetverifyConfiguration()
        //Set the delegate that implements NetverifyViewControllerDelegate
        config.delegate = self
        
        //Perform the following call as soon as your app’s view controller is initialized. Create the NetverifyViewController instance by providing your Configuration with required API token, API secret and a delegate object.
        
        do {
            try ObjcExceptionHelper.catchException {
                self.netverifyViewController = NetverifyViewController(configuration: config)
            }
        } catch {
            let err = error as NSError
            self.showAlert(withTitle: err.localizedDescription, message: err.userInfo[NSLocalizedFailureReasonErrorKey] as? String ?? "")
        }
        
        if (UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad) {
            self.netverifyViewController?.modalPresentationStyle = UIModalPresentationStyle.formSheet;  // For iPad, present from sheet
        }
    }
    
    func createNetverifyConfiguration() -> NetverifyConfiguration {
        let config:NetverifyConfiguration = NetverifyConfiguration()
        //Provide your API token and your API secret
        //Do not store your credentials hardcoded within the app. Make sure to store them server-side and load your credentials during runtime.
        config.apiToken = "YOUR_NETVERIFY_APITOKEN"
        config.apiSecret = "YOUR_NETVERIFY_APISECRET"
        
        //Set the dataCenter; default is JumioDataCenterUS
        //config.dataCenter = JumioDataCenterEU
        
        //Use the following property to enable offline scanning.
        //config.offlineToken = "YOUR_OFFLINE_TOKEN"
        
        // Use the following method to convert ISO 3166-1 alpha-2 into alpha-3 country code (optional)
        // let alpha3CountryCode = ISOCountryConverter.convert(toAlpha3: "AT")
        
        //You can specify issuing country (ISO 3166-1 alpha-3 country code) and/or ID types and/or document variant to skip their selection during the scanning process.
        //config.preselectedCountry = "AUT"
        
        //var documentTypes: NetverifyDocumentType = []
        //documentTypes.insert(.driverLicense)
        //documentTypes.insert(.identityCard)
        //documentTypes.insert(.passport)
        //documentTypes.insert(.visa)

        //config.preselectedDocumentTypes = documentTypes
        
        //When a selected country and ID type support more document variants (paper and plastic), you can specify the document variant in advance or let the user choose during the verification process.
        //config.preselectedDocumentVariant = .plastic
        
        //The customer internal reference allows you to identify the scan (max. 100 characters). Note: Must not contain sensitive data like PII (Personally Identifiable Information) or account login.
        //config.customerInternalReference = "CUSTOMER_INTERNAL_REFERENCE"
        //Use the following property to identify the scan in your reports (max. 100 characters).
        //config.reportingCriteria = "YOUR_REPORTING_CRITERIA"
        //You can also set a customer identifier (max. 100 characters). Note: The customer ID should not contain sensitive data like PII (Personally Identifiable Information) or account login.
        //config.userReference = "USER_REFERENCE"
        
        //Set watchlist screening on transaction level. Enable to override the default search, or disable watchlist screening for this transaction.
        //config.watchlistScreening = .enabled
        //Search profile for watchlist screening. Optional.
        //config.watchlistSearchProfile = "YOUR_SEARCH_PROFILE"
        
        //Callback URL (max. 255 characters) for the confirmation after the verification is completed. This setting overrides your Jumio account settings.
        //config.callbackUrl = "https://www.example.com"
        
        //Enable ID verification to receive a verification status and verified data positions (see Callback chapter). Note: Not possible for accounts configured as Fastfill only.
        config.enableVerification = self.switchEnableVerification.isOn
        
        //You can enable Identity Verification during the ID verification for a specific transaction. This setting overrides your default Jumio account settings.
        config.enableIdentityVerification = self.switchEnableIdentityVerification.isOn
        
        //Set the default camera position
        //config.cameraPosition = JumioCameraPositionFront
        
        //Configure your desired status bar style
        //config.statusBarStyle = UIStatusBarStyle.lightContent
        
        //Use the following method to only support IDs where data can be extracted on mobile only
        //config.dataExtractionOnMobileOnly = true
        
        //Use the following method to explicitly send debug-info to Jumio. (default: NO)
        //Only set this property to YES if you are asked by our Jumio support personal.
        //config.sendDebugInfoToJumio = true
        
        //Localizing labels
        //All label texts and button titles can be changed and localized using the Localizable-Netverify.strings file. Just adapt the values to your required language and use this file in your app.
        
        //Customizing look and feel
        //The SDK can be customized via UIAppearance to fit your application’s look and feel.
        //Please note, that only the below listed UIAppearance selectors are supported and taken into consideration. Experimenting with other UIAppearance or not UIAppearance selectors may cause unexpected behaviour or crashes both in the SDK or in your application. This is best avoided.
        
        // - Navigation bar: tint color, title color, title image
        
        //UINavigationBar.jumioAppearance().tintColor = UIColor.yellow
        //UINavigationBar.jumioAppearance().barTintColor = UIColor.red
        //UINavigationBar.jumioAppearance().titleTextAttributes = [kCTForegroundColorAttributeName: UIColor.white] as [NSAttributedStringKey : Any]
        
        //JumioNavigationBarTitleImageView.jumioAppearance().titleImage = UIImage.init(named: "<your-navigation-bar-title-image>")
        
        // - Custom general appearance - deactivate blur
        //NetverifyBaseView.jumioAppearance().disableBlur = true
        
        // - Custom general appearance - background color
        //NetverifyBaseView.jumioAppearance().backgroundColor = UIColor.lightGray
        
        // - Custom general appearance - foreground color (text-elements and icons)
        //NetverifyBaseView.jumioAppearance().foregroundColor = UIColor.red
        
        // - Scan options Button/Header Background, Icon and Title Colors, custom class has to be imported
        //NetverifyDocumentSelectionButton.jumioAppearance().setBackgroundColor(UIColor.yellow, for: UIControlState.normal)
        //NetverifyDocumentSelectionButton.jumioAppearance().setBackgroundColor(UIColor.red, for: UIControlState.highlighted)
        //NetverifyDocumentSelectionHeaderView.jumioAppearance().backgroundColor = UIColor.brown

        //NetverifyDocumentSelectionButton.jumioAppearance().setIconColor(UIColor.red, for: UIControlState.normal)
        //NetverifyDocumentSelectionButton.jumioAppearance().setIconColor(UIColor.yellow, for: UIControlState.highlighted)
        //NetverifyDocumentSelectionHeaderView.jumioAppearance().iconColor = UIColor.magenta
        
        //NetverifyDocumentSelectionButton.jumioAppearance().setTitleColor(UIColor.red, for: UIControlState.normal)
        //NetverifyDocumentSelectionButton.jumioAppearance().setTitleColor(UIColor.yellow, for: UIControlState.highlighted)
        //NetverifyDocumentSelectionHeaderView.jumioAppearance().titleColor = UIColor.magenta
        
        // - Custom general appearance - font
        //The font has to be loaded upfront within the mainBundle before initializing the SDK
        //NetverifyBaseView.jumioAppearance().customLightFontName = "<your-font-name-loaded-in-your-app>"
        //NetverifyBaseView.jumioAppearance().customRegularFontName = "<your-font-name-loaded-in-your-app>"
        //NetverifyBaseView.jumioAppearance().customMediumFontName = "<your-font-name-loaded-in-your-app>"
        //NetverifyBaseView.jumioAppearance().customBoldFontName = "<your-font-name-loaded-in-your-app>"
        //NetverifyBaseView.jumioAppearance().customItalicFontName = "<your-font-name-loaded-in-your-app>"
        
        // - Custom Positive Button Background Colors, custom class has to be imported (the same applies to NetverifyNegativeButton and NetverifyFallbackButton)
        //NetverifyPositiveButton.jumioAppearance().setBackgroundColor(UIColor.cyan, for: UIControlState.normal)
        //NetverifyPositiveButton.jumioAppearance().setBackgroundColor(UIColor.blue, for: UIControlState.highlighted)
        
        //Custom Positive Button Background Image, custom class has to be imported
        //NetverifyPositiveButton.jumioAppearance().setBackgroundImage(UIImage.init(named: "<your-custom-image>"), for: UIControlState.normal)
        //NetverifyPositiveButton.jumioAppearance().setBackgroundImage(UIImage.init(named: "<your-custom-image>"), for: UIControlState.highlighted)
        
        //Custom Positive Button Title Colors, custom class has to be imported
        //NetverifyPositiveButton.jumioAppearance().setTitleColor(UIColor.gray, for: UIControlState.normal)
        //NetverifyPositiveButton.jumioAppearance().setTitleColor(UIColor.magenta, for: UIControlState.highlighted)
        
        //Custom Positive Button Title Colors, custom class has to be imported
        //NetverifyPositiveButton.jumioAppearance().borderColor = UIColor.green
        
        // - Custom Scan Overlay Colors, custom class has to be imported
        //NetverifyScanOverlayView.jumioAppearance().colorOverlayStandard = UIColor.blue
        //NetverifyScanOverlayView.jumioAppearance().colorOverlayValid = UIColor.green
        //NetverifyScanOverlayView.jumioAppearance().colorOverlayInvalid = UIColor.red
        //NetverifyScanOverlayView.jumioAppearance().scanBackgroundColor = UIColor.orange
        //NetverifyScanOverlayView.jumioAppearance().colorOverlayFill = UIColor.green
        
        // Color for the face oval outline
        //NetverifyScanOverlayView.jumioAppearance().faceOvalColor = UIColor.orange
        // Color for the progress bars
        //NetverifyScanOverlayView.jumioAppearance().faceProgressColor = UIColor.purple
        // Color for the background of the feedback view
        //NetverifyScanOverlayView.jumioAppearance().faceFeedbackBackgroundColor = UIColor.yellow
        // Color for the text of the feedback view
        //NetverifyScanOverlayView.jumioAppearance().faceFeedbackTextColor = UIColor.brown

        //You can get the current SDK version using the method below.
        //print("\(NetverifyViewController.sdkVersion())")
        
        return config
    }
    
    @IBAction func startNetverify() -> Void {
        self.createNetverifyController()
        
        if let netverifyVC = self.netverifyViewController {
            self.present(netverifyVC, animated: true, completion: nil)
        } else {
            showAlert(withTitle: "Netverify Mobile SDK", message: "NetverifyViewController is nil")
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let customUIViewController = segue.destination as? NetverifyCustomUIViewController else { return }
        let customUIViewControllerDelegate = customUIViewController as NetverifyUIControllerDelegate
        
        let config  = self.createNetverifyConfiguration()
        customUIViewController.requiresVerification = config.enableVerification
        NetverifyBaseView.jumioAppearance().disableBlur = true
        NetverifyBaseView.jumioAppearance().foregroundColor = UIColor.white
        NetverifyBaseView.jumioAppearance().backgroundColor = UIColor.init(red: 44/250.0, green: 152/250.0, blue: 240/250.0, alpha: 1.0)
        
        //Set the delegate that implements NetverifyViewControllerDelegate
        config.customUIDelegate = customUIViewControllerDelegate
        
        //Perform the following call as soon as your app’s view controller is initialized. Create the NetverifyViewController instance by providing your Configuration with required API token, API secret and a delegate object.
        do {
            try ObjcExceptionHelper.catchException {
                self.customUIController = NetverifyUIController(configuration: config)
                
                NetverifyScanOverlayView.jumioAppearance().colorOverlayStandard = UIColor(red: 44.0/255.0, green: 152.0/255.0, blue: 240.0/255.0, alpha: 1.0)
            }
        } catch {
            let err = error as NSError
            self.showAlert(withTitle: err.localizedDescription, message: err.userInfo[NSLocalizedFailureReasonErrorKey] as? String ?? "")
        }
    }
    
    
    /**
     * Implement the following delegate method for SDK initialization.
     * @param netverifyViewController The NetverifyViewController instance
     * @param error The error describing the cause of the problematic situation, only set if initializing failed
     **/
    func netverifyViewController(_ netverifyViewController: NetverifyViewController, didFinishInitializingWithError error: NetverifyError?) {
        print("NetverifyViewController did finish initializing")
    }
    
    /**
     * Implement the following delegate method for successful scans.
     * Dismiss the SDK view in your app once you received the result.
     * @param netverifyViewController The NetverifyViewController instance
     * @param documentData The NetverifyDocumentData of the scanned document
     * @param scanReference The scanReference of the scan
     **/
    func netverifyViewController(_ netverifyViewController: NetverifyViewController, didFinishWith documentData: NetverifyDocumentData, scanReference: String) {
        print("NetverifyViewController finished successfully with scan reference: \(scanReference)")
        // Share the scan reference for the Authentication SDK
        UserDefaults.standard.set(scanReference, forKey: "enrollmentTransactionReference")
        
        let selectedCountry:String = documentData.selectedCountry
        let selectedDocumentType:NetverifyDocumentType = documentData.selectedDocumentType
        var documentTypeStr:String
        switch (selectedDocumentType) {
        case .driverLicense:
            documentTypeStr = "DL"
            break;
        case .identityCard:
            documentTypeStr = "ID"
            break;
        case .passport:
            documentTypeStr = "PP"
            break;
        case .visa:
            documentTypeStr = "Visa"
            break;
        default:
            documentTypeStr = ""
            break;
        }
        
        //id
        let idNumber:String? = documentData.idNumber
        let personalNumber:String? = documentData.personalNumber
        let issuingDate:Date? = documentData.issuingDate
        let expiryDate:Date? = documentData.expiryDate
        let issuingCountry:String? = documentData.issuingCountry
        let optionalData1:String? = documentData.optionalData1
        let optionalData2:String? = documentData.optionalData2
        
        //person
        let lastName:String? = documentData.lastName
        let firstName:String? = documentData.firstName
        let dateOfBirth:Date? = documentData.dob
        let gender:NetverifyGender = documentData.gender
        var genderStr:String;
        switch (gender) {
            case .unknown:
                genderStr = "Unknown"
            
            case .F:
                genderStr = "female"
            
            case .M:
                genderStr = "male"
            
            case .X:
                genderStr = "Unspecified"
            
            default:
                genderStr = "Unknown"
        }
       
        let originatingCountry:String? = documentData.originatingCountry
        
        //address
        let street:String? = documentData.addressLine
        let city:String? = documentData.city
        let state:String? = documentData.subdivision
        let postalCode:String? = documentData.postCode
        
        // Raw MRZ data
        let mrzData:NetverifyMrzData? = documentData.mrzData
        
        let message:NSMutableString = NSMutableString.init()
        message.appendFormat("Selected Country: %@", selectedCountry)
        message.appendFormat("\nDocument Type: %@", documentTypeStr)
        if (idNumber != nil) { message.appendFormat("\nID Number: %@", idNumber!) }
        if (personalNumber != nil) { message.appendFormat("\nPersonal Number: %@", personalNumber!) }
        if (issuingDate != nil) { message.appendFormat("\nIssuing Date: %@", issuingDate! as CVarArg) }
        if (expiryDate != nil) { message.appendFormat("\nExpiry Date: %@", expiryDate! as CVarArg) }
        if (issuingCountry != nil) { message.appendFormat("\nIssuing Country: %@", issuingCountry!) }
        if (optionalData1 != nil) { message.appendFormat("\nOptional Data 1: %@", optionalData1!) }
        if (optionalData2 != nil) { message.appendFormat("\nOptional Data 2: %@", optionalData2!) }
        if (lastName != nil) { message.appendFormat("\nLast Name: %@", lastName!) }
        if (firstName != nil) { message.appendFormat("\nFirst Name: %@", firstName!) }
        if (dateOfBirth != nil) { message.appendFormat("\ndob: %@", dateOfBirth! as CVarArg) }
        message.appendFormat("\nGender: %@", genderStr)
        if (originatingCountry != nil) { message.appendFormat("\nOriginating Country: %@", originatingCountry!) }
        if (street != nil) { message.appendFormat("\nStreet: %@", street!) }
        if (city != nil) { message.appendFormat("\nCity: %@", city!) }
        if (state != nil) { message.appendFormat("\nState: %@", state!) }
        if (postalCode != nil) { message.appendFormat("\nPostal Code: %@", postalCode!) }
        if (mrzData != nil) {
            if (mrzData?.line1 != nil) {
            message.appendFormat("\nMRZ Data: %@\n", (mrzData?.line1)!)
            }
            if (mrzData?.line2 != nil) {
                message.appendFormat("%@\n", (mrzData?.line2)!)
            }
            if (mrzData?.line3 != nil) {
                message.appendFormat("%@\n", (mrzData?.line3)!)
            }
        }
        
        //Dismiss the SDK
        self.dismiss(animated: true, completion: {
            print(message)
            self.showAlert(withTitle: "Netverify Mobile SDK", message: message as String)
            self.netverifyViewController?.destroy()
            self.netverifyViewController = nil
        })
    }
    
    /**
     * Implement the following delegate method for successful scans and user cancellation notifications. Dismiss the SDK view in your app once you received the result.
     * @param netverifyViewController The NetverifyViewController
     * @param error The error describing the cause of the problematic situation
     * @param scanReference The scanReference of the scan attempt
     **/
    func netverifyViewController(_ netverifyViewController: NetverifyViewController, didCancelWithError error: NetverifyError?, scanReference: String?) {
        
        //handle the error cases as highlighted in our documentation: https://github.com/Jumio/mobile-sdk-ios/blob/master/docs/integration_faq.md#managing-errors
        
        print("NetverifyViewController cancelled with error: \(error?.message ?? "") scanReference: \(scanReference ?? "")")
        
        //Dismiss the SDK
        self.dismiss(animated: true) {
            self.netverifyViewController?.destroy()
            self.netverifyViewController = nil
        }
    }
}
