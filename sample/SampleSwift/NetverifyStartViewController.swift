//
//  NetverifyStartViewController.swift
//
//  Copyright © 2019 Jumio Corporation All rights reserved.
//

import Netverify

class NetverifyStartViewController: StartViewController, NetverifyViewControllerDelegate {
    @IBOutlet weak var switchRequireVerification:UISwitch!
    @IBOutlet weak var switchRequireFaceMatch:UISwitch!
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
        if JMDeviceInfo.isJailbrokenDevice() {
            return
        }
        
        //Setup the Configuration for Netverify
        let config:NetverifyConfiguration = createNetverifyConfiguration()
        //Set the delegate that implements NetverifyViewControllerDelegate
        config.delegate = self
        
        //Perform the following call as soon as your app’s view controller is initialized. Create the NetverifyViewController instance by providing your Configuration with required merchant API token, merchant API secret and a delegate object.
        
        do {
            try ObjcExceptionHelper.catchException {
                self.netverifyViewController = NetverifyViewController(configuration: config)
            }
        } catch {
            let err = error as NSError
            UIAlertController.presentAlertView(withTitle: err.localizedDescription, message: err.userInfo[NSLocalizedFailureReasonErrorKey] as? String ?? "", cancelButtonTitle: "OK", completion: nil)
        }
        
        if (UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad) {
            self.netverifyViewController?.modalPresentationStyle = UIModalPresentationStyle.formSheet;  // For iPad, present from sheet
        }
    }
    
    func createNetverifyConfiguration() -> NetverifyConfiguration {
        let config:NetverifyConfiguration = NetverifyConfiguration()
        //Provide your API token
        config.merchantApiToken = "YOUR_NETVERIFY_APITOKEN"
        //Provide your API secret
        config.merchantApiSecret = "YOUR_NETVERIFY_APISECRET"
        
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
        
        //The merchant scan reference allows you to identify the scan (max. 100 characters). Note: Must not contain sensitive data like PII (Personally Identifiable Information) or account login.
        //config.merchantScanReference = "YOURSCANREFERENCE"
        //Use the following property to identify the scan in your reports (max. 100 characters).
        //config.merchantReportingCriteria = "YOURREPORTINGCRITERIA"
        //You can also set a customer identifier (max. 100 characters). Note: The customer ID should not contain sensitive data like PII (Personally Identifiable Information) or account login.
        //config.customerId = "CUSTOMERID"
        
        //Callback URL (max. 255 characters) for the confirmation after the verification is completed. This setting overrides your Jumio merchant settings.
        //config.callbackUrl = "https://www.example.com"
        
        //Enable ID verification to receive a verification status and verified data positions (see Callback chapter). Note: Not possible for accounts configured as Fastfill only.
        config.requireVerification = self.switchRequireVerification.isOn
        
        //You can enable face match during the ID verification for a specific transaction. This setting overrides your default Jumio merchant settings.
        config.requireFaceMatch = self.switchRequireFaceMatch.isOn
        
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
        
        //UINavigationBar.netverifyAppearance().tintColor = UIColor.yellow
        //UINavigationBar.netverifyAppearance().barTintColor = UIColor.red
        //UINavigationBar.netverifyAppearance().titleTextAttributes = [kCTForegroundColorAttributeName: UIColor.white] as [NSAttributedStringKey : Any]
        
        //NetverifyNavigationBarTitleImageView.netverifyAppearance().titleImage = UIImage.init(named: "<your-bamcheckout-navigation-bar-title-image>")
        
        // - Custom general appearance - deactivate blur
        //NetverifyBaseView.netverifyAppearance().disableBlur = true
        
        // - Custom general appearance - background color
        //NetverifyBaseView.netverifyAppearance().backgroundColor = UIColor.lightGray
        
        // - Custom general appearance - foreground color (text-elements and icons)
        //NetverifyBaseView.netverifyAppearance().foregroundColor = UIColor.red
        
        // - Scan options Button/Header Background, Icon and Title Colors, custom class has to be imported
        //NetverifyDocumentSelectionButton.netverifyAppearance().setBackgroundColor(UIColor.yellow, for: UIControlState.normal)
        //NetverifyDocumentSelectionButton.netverifyAppearance().setBackgroundColor(UIColor.red, for: UIControlState.highlighted)
        //NetverifyDocumentSelectionHeaderView.netverifyAppearance().backgroundColor = UIColor.brown

        //NetverifyDocumentSelectionButton.netverifyAppearance().setIconColor(UIColor.red, for: UIControlState.normal)
        //NetverifyDocumentSelectionButton.netverifyAppearance().setIconColor(UIColor.yellow, for: UIControlState.highlighted)
        //NetverifyDocumentSelectionHeaderView.netverifyAppearance().iconColor = UIColor.magenta
        
        //NetverifyDocumentSelectionButton.netverifyAppearance().setTitleColor(UIColor.red, for: UIControlState.normal)
        //NetverifyDocumentSelectionButton.netverifyAppearance().setTitleColor(UIColor.yellow, for: UIControlState.highlighted)
        //NetverifyDocumentSelectionHeaderView.netverifyAppearance().titleColor = UIColor.magenta
        
        // - Custom general appearance - font
        //The font has to be loaded upfront within the mainBundle before initializing the SDK
        //NetverifyBaseView.netverifyAppearance().customLightFontName = "<your-font-name-loaded-in-your-app>"
        //NetverifyBaseView.netverifyAppearance().customRegularFontName = "<your-font-name-loaded-in-your-app>"
        //NetverifyBaseView.netverifyAppearance().customMediumFontName = "<your-font-name-loaded-in-your-app>"
        //NetverifyBaseView.netverifyAppearance().customBoldFontName = "<your-font-name-loaded-in-your-app>"
        //NetverifyBaseView.netverifyAppearance().customItalicFontName = "<your-font-name-loaded-in-your-app>"
        
        // - Custom Positive Button Background Colors, custom class has to be imported (the same applies to NetverifyNegativeButton and NetverifyFallbackButton)
        //The same applies to NetverifyNegativeButton and NetverifyFallbackButton
        //NetverifyPositiveButton.netverifyAppearance().setBackgroundColor(UIColor.cyan, for: UIControlState.normal)
        //NetverifyPositiveButton.netverifyAppearance().setBackgroundColor(UIColor.blue, for: UIControlState.highlighted)
        
        //Custom Positive Button Background Image, custom class has to be imported
        //NetverifyPositiveButton.netverifyAppearance().setBackgroundImage(UIImage.init(named: "<your-custom-image>"), for: UIControlState.normal)
        //NetverifyPositiveButton.netverifyAppearance().setBackgroundImage(UIImage.init(named: "<your-custom-image>"), for: UIControlState.highlighted)
        
        //Custom Positive Button Title Colors, custom class has to be imported
        //NetverifyPositiveButton.netverifyAppearance().setTitleColor(UIColor.gray, for: UIControlState.normal)
        //NetverifyPositiveButton.netverifyAppearance().setTitleColor(UIColor.magenta, for: UIControlState.highlighted)
        
        //Custom Positive Button Title Colors, custom class has to be imported
        //NetverifyPositiveButton.netverifyAppearance().borderColor = UIColor.green
        
        // - Custom Scan Overlay Colors, custom class has to be imported
        //NetverifyScanOverlayView.netverifyAppearance().colorOverlayStandard = UIColor.blue
        //NetverifyScanOverlayView.netverifyAppearance().colorOverlayValid = UIColor.green
        //NetverifyScanOverlayView.netverifyAppearance().colorOverlayInvalid = UIColor.red
        
        // Color for the face oval outline
        //NetverifyScanOverlayView.netverifyAppearance().faceOvalColor = UIColor(red: 46/255.0, green: 255/255.0, blue: 71/255.0, alpha: 0.69)
        // Color for the progress bars
        //NetverifyScanOverlayView.netverifyAppearance().faceProgressColor = UIColor(red: 46/255.0, green: 255/255.0, blue: 71/255.0, alpha: 0.69)
        // Color for the background of the feedback view
        //NetverifyScanOverlayView.netverifyAppearance().faceFeedbackBackgroundColor = UIColor(red: 46/255.0, green: 255/255.0, blue: 71/255.0, alpha: 0.69)
        // Color for the text of the feedback view
        //NetverifyScanOverlayView.netverifyAppearance().faceFeedbackTextColor = UIColor(red: 46/255.0, green: 255/255.0, blue: 71/255.0, alpha: 0.69)

        //You can get the current SDK version using the method below.
        //print("\(self.netverifyViewController?.sdkVersion() ?? "")")
        
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
        customUIViewController.requiresVerification = config.requireVerification
        
        //Set the delegate that implements NetverifyViewControllerDelegate
        config.customUIDelegate = customUIViewControllerDelegate
        
        //Perform the following call as soon as your app’s view controller is initialized. Create the NetverifyViewController instance by providing your Configuration with required merchant API token, merchant API secret and a delegate object.
        do {
            try ObjcExceptionHelper.catchException {
                self.customUIController = NetverifyUIController(configuration: config)
                
                NetverifyScanOverlayView.netverifyAppearance().colorOverlayStandard = UIColor(red: 44.0/255.0, green: 152.0/255.0, blue: 240.0/255.0, alpha: 1.0)
            }
        } catch {
            let err = error as NSError
            UIAlertController.presentAlertView(withTitle: err.localizedDescription, message: err.userInfo[NSLocalizedFailureReasonErrorKey] as? String ?? "", cancelButtonTitle: "OK", completion: nil)
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
        print("NetverifyViewController finished successfully with scan reference: %@", scanReference);
        
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
        print(message)
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
        print("NetverifyViewController cancelled with error: " + "\(error?.message ?? "")" + "scanReference: " + "\(scanReference ?? "")")
        
        //Dismiss the SDK
        self.dismiss(animated: true) {
            self.netverifyViewController?.destroy()
            self.netverifyViewController = nil
        }
    }
}
