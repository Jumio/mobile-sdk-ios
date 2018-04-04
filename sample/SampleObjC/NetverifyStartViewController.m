//
//  NetverifyStartViewController.m
//
//  Copyright © 2018 Jumio Corporation All rights reserved.
//

#import "NetverifyStartViewController.h"
@import Netverify;

@interface NetverifyStartViewController () <NetverifyViewControllerDelegate>
@property (nonatomic, strong) NetverifyViewController *netverifyViewController;
@end

@implementation NetverifyStartViewController

/**
 * Present the NetverifyViewController
 */
- (void) createNetverifyController{
    
    //Setup the Configuration for Netverify
    NetverifyConfiguration *config = [NetverifyConfiguration new];
    //Provide your API token
    config.merchantApiToken = @"YOUR_NETVERIFY_APITOKEN";
    //Provide your API secret
    config.merchantApiSecret = @"YOUR_NETVERIFY_APISECRET";
    //Set the delegate that implements NetverifyViewControllerDelegate
    config.delegate = self;
    
    //Set the dataCenter; default is JumioDataCenterUS
    //config.dataCenter = JumioDataCenterEU;
    
    //Use the following property to enable offline scanning.
    //config.offlineToken = @"YOUR_OFFLINE_TOKEN";
    
    // Use the following method to convert ISO 3166-1 alpha-2 into alpha-3 country code (optional)
    // NSString* alpha3CountryCode = [ISOCountryConverter convertToAlpha3: @"AT"];
    
    //You can specify issuing country (ISO 3166-1 alpha-3 country code) and/or ID types and/or document variant to skip their selection during the scanning process.
    //config.preselectedCountry = @"AUT";
    //config.preselectedDocumentTypes = NetverifyDocumentTypeAll;
    //config.preselectedDocumentTypes = NetverifyDocumentTypePassport | NetverifyDocumentTypeVisa | NetverifyDocumentTypeIdentityCard | NetverifyDocumentTypeDriverLicense;
    
    //When a selected country and ID type support more document variants (paper and plastic), you can specify the document variant in advance or let the user choose during the verification process.
    //config.preselectedDocumentVariant = NetverifyDocumentVariantPlastic;
    
    //The merchant scan reference allows you to identify the scan (max. 100 characters). Note: Must not contain sensitive data like PII (Personally Identifiable Information) or account login.
    //config.merchantScanReference = @"YOURSCANREFERENCE";
    //Use the following property to identify the scan in your reports (max. 100 characters).
    //config.merchantReportingCriteria = @"YOURREPORTINGCRITERIA";
    //You can also set a customer identifier (max. 100 characters). Note: The customer ID should not contain sensitive data like PII (Personally Identifiable Information) or account login.
    //config.customerId = @"CUSTOMERID";
    
    //Callback URL (max. 255 characters) for the confirmation after the verification is completed. This setting overrides your Jumio merchant settings.
    //config.callbackUrl = @"https://www.example.com";
    
    //Enable ID verification to receive a verification status and verified data positions (see Callback chapter). Note: Not possible for accounts configured as Fastfill only.
    config.requireVerification = self.switchRequireVerification.isOn;
    
    //You can enable face match during the ID verification for a specific transaction. This setting overrides your default Jumio merchant settings.
    config.requireFaceMatch = self.switchRequireFaceMatch.isOn;
    
    //Set the default camera position
    //config.cameraPosition = JumioCameraPositionFront;
    
    //Configure your desired status bar style
    //config.statusBarStyle = UIStatusBarStyleLightContent;
    
    //Additional information for this scan should not contain sensitive data like PII (Personally Identifiable Information) or account login
    //config.additionalInformation = @"YOURADDITIONALINFORMATION";
    
    //Use the following method to only support IDs where data can be extracted on mobile only
    //config.dataExtractionOnMobileOnly = YES;
    
    //Use the following method to explicitly send debug-info to Jumio. (default: NO)
    //Only set this property to YES if you are asked by our Jumio support personal.
    //config.sendDebugInfoToJumio = YES;
    
    //Perform the following call as soon as your app’s view controller is initialized. Create the NetverifyViewController instance by providing your Configuration with required merchant API token, merchant API secret and a delegate object.
    @try {
        self.netverifyViewController = [[NetverifyViewController alloc] initWithConfiguration:config];
    } @catch (NSException *exception) {
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:exception.name message:exception.reason preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil]];
        [self presentViewController:alertController animated:YES completion:nil];
    }
    
    //Localizing labels
    //All label texts and button titles can be changed and localized using the Localizable-Netverify.strings file. Just adapt the values to your required language and use this file in your app.
    
    //Customizing look and feel
    //The SDK can be customized via UIAppearance to fit your application’s look and feel.
    //Please note, that only the below listed UIAppearance selectors are supported and taken into consideration. Experimenting with other UIAppearance or not UIAppearance selectors may cause unexpected behaviour or crashes both in the SDK or in your application. This is best avoided.
    
    // - Navigation bar: tint color, title color, title image
    //[[UINavigationBar netverifyAppearance] setTintColor: [UIColor yellowColor]];
    //[[UINavigationBar netverifyAppearance] setBarTintColor: [UIColor redColor]];
    //[[UINavigationBar netverifyAppearance] setTitleTextAttributes: @{NSForegroundColorAttributeName: [UIColor whiteColor]}];
    
    //[[NetverifyNavigationBarTitleImageView netverifyAppearance] setTitleImage: [UIImage imageNamed:@"<your-netverify-navigation-bar-title-image>"]];
    
    // - Custom general appearance - deactivate blur
    //[[NetverifyBaseView netverifyAppearance] setDisableBlur:@YES];
    
    // - Custom general appearance - background color
    //[[NetverifyBaseView netverifyAppearance] setBackgroundColor: [UIColor grayColor]];
    
    // - Custom general appearance - foreground color (text-elements and icons)
    //[[NetverifyBaseView netverifyAppearance] setForegroundColor: [UIColor redColor]];
    
    // - Scan options Button/Header Background, Icon and Title Colors, custom class has to be imported
    //[[NetverifyDocumentSelectionButton netverifyAppearance] setBackgroundColor:[UIColor yellowColor] forState:UIControlStateNormal];
    //[[NetverifyDocumentSelectionButton netverifyAppearance] setBackgroundColor:[UIColor redColor] forState:UIControlStateHighlighted];
    //[[NetverifyDocumentSelectionHeaderView netverifyAppearance] setBackgroundColor:[UIColor brownColor]];
    
    //[[NetverifyDocumentSelectionButton netverifyAppearance] setIconColor:[UIColor redColor] forState:UIControlStateNormal];
    //[[NetverifyDocumentSelectionButton netverifyAppearance] setIconColor:[UIColor yellowColor] forState:UIControlStateHighlighted];
    //[[NetverifyDocumentSelectionHeaderView netverifyAppearance] setIconColor:[UIColor magentaColor]];
    
    //[[NetverifyDocumentSelectionButton netverifyAppearance] setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    //[[NetverifyDocumentSelectionButton netverifyAppearance] setTitleColor:[UIColor yellowColor] forState:UIControlStateHighlighted];
    //[[NetverifyDocumentSelectionHeaderView netverifyAppearance] setTitleColor:[UIColor magentaColor]];
    
    // - Custom general appearance - font
    //The font has to be loaded upfront within the mainBundle before initializing the SDK
    //[[NetverifyBaseView netverifyAppearance] setCustomLightFontName: @"<your-font-name-loaded-in-your-app>"];
    //[[NetverifyBaseView netverifyAppearance] setCustomRegularFontName: @"<your-font-name-loaded-in-your-app>"];
    //[[NetverifyBaseView netverifyAppearance] setCustomMediumFontName: @"<your-font-name-loaded-in-your-app>"];
    //[[NetverifyBaseView netverifyAppearance] setCustomBoldFontName: @"<your-font-name-loaded-in-your-app>"];
    //[[NetverifyBaseView netverifyAppearance] setCustomItalicFontName: @"<your-font-name-loaded-in-your-app>"];
    
    // - Custom Positive Button Background Colors, custom class has to be imported (the same applies to NetverifyNegativeButton and NetverifyFallbackButton)
    //The same applies to NetverifyNegativeButton and NetverifyFallbackButton
    //[[NetverifyPositiveButton netverifyAppearance] setBackgroundColor:[UIColor cyanColor] forState:UIControlStateNormal];
    //[[NetverifyPositiveButton netverifyAppearance] setBackgroundColor:[UIColor blueColor] forState:UIControlStateHighlighted];
    
    //Custom Positive Button Background Image, custom class has to be imported
    //[[NetverifyPositiveButton netverifyAppearance] setBackgroundImage:[UIImage imageNamed:@"<your-custom-image>"] forState:UIControlStateNormal];
    //[[NetverifyPositiveButton netverifyAppearance] setBackgroundImage:[UIImage imageNamed:@"<your-custom-image>"] forState:UIControlStateHighlighted];
    
    //Custom Positive Button Title Colors, custom class has to be imported
    //[[NetverifyPositiveButton netverifyAppearance] setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    //[[NetverifyPositiveButton netverifyAppearance] setTitleColor:[UIColor magentaColor] forState:UIControlStateHighlighted];
    
    //Custom Positive Button Title Colors, custom class has to be imported
    //[[NetverifyPositiveButton netverifyAppearance] setBorderColor: [UIColor greenColor]];
    
    // - Custom Scan Overlay Colors, custom class has to be imported
    //[[NetverifyScanOverlayView netverifyAppearance] setColorOverlayStandard: [UIColor blueColor]];
    //[[NetverifyScanOverlayView netverifyAppearance] setColorOverlayValid: [UIColor greenColor]];
    //[[NetverifyScanOverlayView netverifyAppearance] setColorOverlayInvalid: [UIColor redColor]];
    
    //You can get the current SDK version using the method below.
    //NSLog(@"%@", [self.netverifyViewController sdkVersion]);
}

- (IBAction) startNetverify: (id) sender {
    [self createNetverifyController];
    
    //To show the SDK, call the method below within your ViewController.
    if (self.netverifyViewController) {
        [self presentViewController: self.netverifyViewController animated:YES completion:nil];
    } else {
        [self showAlertWithTitle:@"Netverify Mobile SDK" message: @"NetverifyViewController is nil"];
    }
}

#pragma mark - NetverifyViewControllerDelegate

/**
 * Implement the following delegate method for SDK initialization.
 * @param netverifyViewController The NetverifyViewController instance
 **/
- (void) netverifyViewController:(NetverifyViewController *)netverifyViewController didFinishInitializingWithError:(NetverifyError * _Nullable)error {
    NSLog(@"NetverifyViewController did finish initializing, error: %@", error.message);
}

/**
 * Implement the following delegate method for successful scans.
 * Dismiss the SDK view in your app once you received the result.
 * @param netverifyViewController The NetverifyViewController instance
 * @param documentData The NetverifyDocumentData of the scanned document
 * @param scanReference The scanReference of the scan
 **/
- (void) netverifyViewController:(NetverifyViewController *)netverifyViewController didFinishWithDocumentData:(NetverifyDocumentData *)documentData scanReference:(NSString *)scanReference {
    NSLog(@"NetverifyViewController finished successfully with scan reference: %@", scanReference);
    
    NSString *selectedCountry = documentData.selectedCountry;
    NetverifyDocumentType selectedDocumentType = documentData.selectedDocumentType;
    NSString *documentTypeStr;
    switch (selectedDocumentType) {
        case NetverifyDocumentTypeDriverLicense:
            documentTypeStr = @"DL";
            break;
        case NetverifyDocumentTypeIdentityCard:
            documentTypeStr = @"ID";
            break;
        case NetverifyDocumentTypePassport:
            documentTypeStr = @"PP";
            break;
        case NetverifyDocumentTypeVisa:
            documentTypeStr = @"Visa";
            break;
        default:
            break;
    }
    
    //id
    NSString *idNumber = documentData.idNumber;
    NSString *personalNumber = documentData.personalNumber;
    NSDate *issuingDate = documentData.issuingDate;
    NSDate *expiryDate = documentData.expiryDate;
    NSString *issuingCountry = documentData.issuingCountry;
    NSString *optionalData1 = documentData.optionalData1;
    NSString *optionalData2 = documentData.optionalData2;
    
    //person
    NSString *lastName = documentData.lastName;
    NSString *firstName = documentData.firstName;
    NSString *middleName = documentData.middleName;
    NSDate *dateOfBirth = documentData.dob;
    NetverifyGender gender = documentData.gender;
    NSString *genderStr;
    switch (gender) {
        default:
        case NetverifyGenderUnknown: {
            genderStr = @"Unknown";
        } break;
        case NetverifyGenderF: {
            genderStr = @"female";
        } break;
        case NetverifyGenderM: {
            genderStr = @"male";
        } break;
        case NetverifyGenderX: {
            genderStr = @"Unspecified";
        } break;
    }
    NSString *originatingCountry = documentData.originatingCountry;
    
    //address
    NSString *street = documentData.addressLine;
    NSString *city = documentData.city;
    NSString *state = documentData.subdivision;
    NSString *postalCode = documentData.postCode;
    
    // Raw MRZ data
    NetverifyMrzData *mrzData = documentData.mrzData;
    
    NSMutableString *message = [NSMutableString stringWithFormat:@"Selected Country: %@", selectedCountry];
    
    [message appendFormat:@"\nDocument Type: %@", documentTypeStr];
    [message appendFormat:@"\nID Number: %@", idNumber];
    if (personalNumber) [message appendFormat:@"\nPersonal Number: %@", personalNumber];
    if (issuingDate) [message appendFormat:@"\nIssuing Date: %@", issuingDate];
    if (expiryDate) [message appendFormat:@"\nExpiry Date: %@", expiryDate];
    if (issuingCountry) [message appendFormat:@"\nIssuing Country: %@", issuingCountry];
    if (optionalData1) [message appendFormat:@"\nOptional Data 1: %@", optionalData1];
    if (optionalData2) [message appendFormat:@"\nOptional Data 2: %@", optionalData2];
    if (lastName) [message appendFormat:@"\nLast Name: %@", lastName];
    if (firstName) [message appendFormat:@"\nFirst Name: %@", firstName];
    if (middleName) [message appendFormat:@"\nMiddle Name: %@", middleName];
    if (dateOfBirth) [message appendFormat:@"\ndob: %@", dateOfBirth];
    [message appendFormat:@"\nGender: %@", genderStr];
    if (originatingCountry) [message appendFormat:@"\nOriginating Country: %@", originatingCountry];
    if (street) [message appendFormat:@"\nStreet: %@", street];
    if (city) [message appendFormat:@"\nCity: %@", city];
    if (state) [message appendFormat:@"\nState: %@", state];
    if (postalCode) [message appendFormat:@"\nPostal Code: %@", postalCode];
    if (mrzData) {
        if (mrzData.line1) {
            [message appendFormat:@"\nMRZ Data: %@\n", mrzData.line1];
        }
        if (mrzData.line2) {
            [message appendFormat:@"%@\n", mrzData.line2];
        }
        if (mrzData.line3) {
            [message appendFormat:@"%@\n", mrzData.line3];
        }
    }
    
    //Dismiss the SDK
    [self dismissViewControllerAnimated: YES completion: ^{
        NSLog(@"%@",message);
        [self showAlertWithTitle:@"Netverify Mobile SDK" message:message];
    }];
}

/**
 * Implement the following delegate method for successful scans and user cancellation notifications. Dismiss the SDK view in your app once you received the result.
 * @param netverifyViewController The NetverifyViewController instance
 * @param error The error describing the cause of the problematic situation
 * @param scanReference The scanReference of the scan attempt
 **/
- (void) netverifyViewController:(NetverifyViewController *)netverifyViewController didCancelWithError:(NetverifyError * _Nullable)error scanReference:(NSString * _Nullable)scanReference {
    NSLog(@"NetverifyViewController cancelled with error: %@, scanReference: %@", error.message, scanReference);
    //Dismiss the SDK
    [self dismissViewControllerAnimated: YES completion: nil];
}

@end
