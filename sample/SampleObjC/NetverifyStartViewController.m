//
//  NetverifyStartViewController.m
//
//  Copyright © 2019 Jumio Corporation All rights reserved.
//

#import "NetverifyStartViewController.h"
@import JumioCore;
@import Netverify;

@interface NetverifyStartViewController () <NetverifyViewControllerDelegate>
@property (nonatomic, strong) NetverifyViewController *netverifyViewController;
@end

@implementation NetverifyStartViewController

/**
 * Present the NetverifyViewController
 */
- (void) createNetverifyController{
    
    //prevent SDK to be initialized on Jailbroken devices
    if ([JumioDeviceInfo isJailbrokenDevice]) {
        return;
    }
    
    //Setup the Configuration for Netverify
    NetverifyConfiguration *config = [NetverifyConfiguration new];
    //Provide your API token
    config.apiToken = @"YOUR_NETVERIFY_APITOKEN";
    //Provide your API secret
    config.apiSecret = @"YOUR_NETVERIFY_APISECRET";
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
    
    //The customer internal reference allows you to identify the scan (max. 100 characters). Note: Must not contain sensitive data like PII (Personally Identifiable Information) or account login.
    config.customerInternalReference = @"CUSTOMER_INTERNAL_REFERENCE";
    //Use the following property to identify the scan in your reports (max. 100 characters).
    //config.reportingCriteria = @"YOURREPORTINGCRITERIA";
    //You can also set a customer identifier (max. 100 characters). Note: The customer ID should not contain sensitive data like PII (Personally Identifiable Information) or account login.
    //config.userReference = @"USER_REFERENCE";
    
    //Callback URL (max. 255 characters) for the confirmation after the verification is completed. This setting overrides your Jumio account settings.
    //config.callbackUrl = @"https://www.example.com";
    
    //Enable/disable ID verification to receive a verification status and verified data positions (see Callback chapter). Note: Not possible for accounts configured as Fastfill only.
    config.enableVerification = self.switchEnableVerification.isOn;
    
    //You can enable/disable Identity Verification during the ID verification for a specific transaction. This setting overrides your default Jumio account settings.
    config.enableIdentityVerification = self.switchEnableIdentityVerification.isOn;
    
    //Set the default camera position
    //config.cameraPosition = JumioCameraPositionFront;
    
    //Configure your desired status bar style
    //config.statusBarStyle = UIStatusBarStyleLightContent;
    
    //Use the following method to only support IDs where data can be extracted on mobile only
    //config.dataExtractionOnMobileOnly = YES;
    
    //Use the following method to explicitly send debug-info to Jumio. (default: NO)
    //Only set this property to YES if you are asked by our Jumio support personal.
    //config.sendDebugInfoToJumio = YES;
    
    //Perform the following call as soon as your app’s view controller is initialized. Create the NetverifyViewController instance by providing your Configuration with required API token, API secret and a delegate object.
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
    //[[UINavigationBar jumioAppearance] setTintColor: [UIColor yellowColor]];
    //[[UINavigationBar jumioAppearance] setBarTintColor: [UIColor redColor]];
    //[[UINavigationBar jumioAppearance] setTitleTextAttributes: @{NSForegroundColorAttributeName: [UIColor whiteColor]}];
    
    //[[NetverifyNavigationBarTitleImageView jumioAppearance] setTitleImage: [UIImage imageNamed:@"<your-navigation-bar-title-image>"]];
    
    // - Custom general appearance - deactivate blur
    //[[NetverifyBaseView jumioAppearance] setDisableBlur:@YES];
    
    // - Custom general appearance - background color
    //[[NetverifyBaseView jumioAppearance] setBackgroundColor: [UIColor grayColor]];
    
    // - Custom general appearance - foreground color (text-elements and icons)
    //[[NetverifyBaseView jumioAppearance] setForegroundColor: [UIColor redColor]];
    
    // - Scan options Button/Header Background, Icon and Title Colors, custom class has to be imported
    //[[NetverifyDocumentSelectionButton jumioAppearance] setBackgroundColor:[UIColor yellowColor] forState:UIControlStateNormal];
    //[[NetverifyDocumentSelectionButton jumioAppearance] setBackgroundColor:[UIColor redColor] forState:UIControlStateHighlighted];
    //[[NetverifyDocumentSelectionHeaderView jumioAppearance] setBackgroundColor:[UIColor brownColor]];
    
    //[[NetverifyDocumentSelectionButton jumioAppearance] setIconColor:[UIColor redColor] forState:UIControlStateNormal];
    //[[NetverifyDocumentSelectionButton jumioAppearance] setIconColor:[UIColor yellowColor] forState:UIControlStateHighlighted];
    //[[NetverifyDocumentSelectionHeaderView jumioAppearance] setIconColor:[UIColor magentaColor]];
    
    //[[NetverifyDocumentSelectionButton jumioAppearance] setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    //[[NetverifyDocumentSelectionButton jumioAppearance] setTitleColor:[UIColor yellowColor] forState:UIControlStateHighlighted];
    //[[NetverifyDocumentSelectionHeaderView jumioAppearance] setTitleColor:[UIColor magentaColor]];
    
    // - Custom general appearance - font
    //The font has to be loaded upfront within the mainBundle before initializing the SDK
    //[[NetverifyBaseView jumioAppearance] setCustomLightFontName: @"<your-font-name-loaded-in-your-app>"];
    //[[NetverifyBaseView jumioAppearance] setCustomRegularFontName: @"<your-font-name-loaded-in-your-app>"];
    //[[NetverifyBaseView jumioAppearance] setCustomMediumFontName: @"<your-font-name-loaded-in-your-app>"];
    //[[NetverifyBaseView jumioAppearance] setCustomBoldFontName: @"<your-font-name-loaded-in-your-app>"];
    //[[NetverifyBaseView jumioAppearance] setCustomItalicFontName: @"<your-font-name-loaded-in-your-app>"];
    
    // - Custom Positive Button Background Colors, custom class has to be imported (the same applies to NetverifyNegativeButton and NetverifyFallbackButton)
    //[[NetverifyPositiveButton jumioAppearance] setBackgroundColor:[UIColor cyanColor] forState:UIControlStateNormal];
    //[[NetverifyPositiveButton jumioAppearance] setBackgroundColor:[UIColor blueColor] forState:UIControlStateHighlighted];
    
    //Custom Positive Button Background Image, custom class has to be imported
    //[[NetverifyPositiveButton jumioAppearance] setBackgroundImage:[UIImage imageNamed:@"<your-custom-image>"] forState:UIControlStateNormal];
    //[[NetverifyPositiveButton jumioAppearance] setBackgroundImage:[UIImage imageNamed:@"<your-custom-image>"] forState:UIControlStateHighlighted];
    
    //Custom Positive Button Title Colors, custom class has to be imported
    //[[NetverifyPositiveButton jumioAppearance] setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    //[[NetverifyPositiveButton jumioAppearance] setTitleColor:[UIColor magentaColor] forState:UIControlStateHighlighted];
    
    //Custom Positive Button Title Colors, custom class has to be imported
    //[[NetverifyPositiveButton jumioAppearance] setBorderColor: [UIColor greenColor]];
    
    // - Custom Scan Overlay Colors, custom class has to be imported
    //[[NetverifyScanOverlayView jumioAppearance] setColorOverlayStandard: [UIColor blueColor]];
    //[[NetverifyScanOverlayView jumioAppearance] setColorOverlayValid: [UIColor greenColor]];
    //[[NetverifyScanOverlayView jumioAppearance] setColorOverlayInvalid: [UIColor redColor]];
    //[[NetverifyScanOverlayView jumioAppearance] setScanBackgroundColor: [UIColor orangeColor]];
    
    // Color for the face oval outline
    //[[NetverifyScanOverlayView jumioAppearance] setFaceOvalColor: [UIColor orangeColor]];
    // Color for the progress bars
    //[[NetverifyScanOverlayView jumioAppearance] setFaceProgressColor: [UIColor purpleColor]];
    // Color for the background of the feedback view
    //[[NetverifyScanOverlayView jumioAppearance] setFaceFeedbackBackgroundColor: [UIColor yellowColor]];
    // Color for the text of the feedback view
    //[[NetverifyScanOverlayView jumioAppearance] setFaceFeedbackTextColor: [UIColor brownColor]];
    
    //You can get the current SDK version using the method below.
    //NSLog(@"%@", [NetverifyViewController sdkVersion]);
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
    [[NSUserDefaults standardUserDefaults] setObject:scanReference forKey:@"enrollmentTransactionReference"];
    
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
        
        //Destroy the instance to properly clean up the SDK
        [self.netverifyViewController destroy];
        self.netverifyViewController = nil;
    }];
}

/**
 * Implement the following delegate method for successful scans and user cancellation notifications.
 * Dismiss the SDK view in your app once you received the result.
 * @param netverifyViewController The NetverifyViewController instance
 * @param error The error describing the cause of the problematic situation
 * @param scanReference The scanReference of the scan attempt
 **/
- (void) netverifyViewController:(NetverifyViewController *)netverifyViewController didCancelWithError:(NetverifyError * _Nullable)error scanReference:(NSString * _Nullable)scanReference {
    NSLog(@"NetverifyViewController cancelled with error: %@, scanReference: %@", error.message, scanReference);
    //Dismiss the SDK
    [self dismissViewControllerAnimated: YES completion: ^{
        //Destroy the instance to properly clean up the SDK
        [self.netverifyViewController destroy];
        self.netverifyViewController = nil;
    }];
}

@end
