//
//  DocumentVerificationStartViewController.m
//
//  Copyright © 2020 Jumio Corporation All rights reserved.
//

#import "DocumentVerificationStartViewController.h"
@import JumioCore;
@import DocumentVerification;

@interface DocumentVerificationStartViewController () <DocumentVerificationViewControllerDelegate>
@property (nonatomic, strong) DocumentVerificationViewController *documentVerificationViewController;
@end

@implementation DocumentVerificationStartViewController

- (void) createDocumentVerificationController {
    
    //prevent SDK to be initialized on Jailbroken devices
    if ([JumioDeviceInfo isJailbrokenDevice]) {
        return;
    }
    
    //Setup the Configuration for DocumentVerification
    DocumentVerificationConfiguration *config = [DocumentVerificationConfiguration new];
    //Provide your API token and your API secret
    //Do not store your credentials hardcoded within the app. Make sure to store them server-side and load your credentials during runtime.
    config.apiToken = @"YOUR_DOCUMENTVERIFICATION_APITOKEN";
    config.apiSecret = @"YOUR_DOCUMENTVERIFICATION_APISECRET";
    //Set the delegate that implements DocumentVerificationViewControllerDelegate
    config.delegate = self;
    
    //Set the dataCenter; default is JumioDataCenterUS
    //config.dataCenter = JumioDataCenterEU;
    //config.dataCenter = JumioDataCenterSG;
    
    //Make sure to specify issuing country (ISO 3166-1 alpha-3 country code)
    config.country = @"AUT";
    
    //One of the configured DocumentTypeCodes: BC, BS, CAAP, CB, CC, CCS, CRC, HCC, IC, LAG, LOAP,
    //MEDC, MOAP, PB, SEL, SENC, SS, SSC, STUC, TAC, TR, UB, VC, VT, WWCC, CUSTOM
    config.type = @"BC";
    
    //The customer internal reference allows you to identify the scan (max. 100 characters). Note: Must not contain sensitive data like PII (Personally Identifiable Information) or account login.
    config.customerInternalReference = @"CUSTOMER_INTERNAL_REFERENCE";
    
    //You can also set a customer identifier (max. 100 characters). Note: The customer ID should not contain sensitive data like PII (Personally Identifiable Information) or account login.
    config.userReference = @"USER_REFERENCE";
    
    //Use the following property to identify the scan in your reports (max. 100 characters).
    //config.reportingCriteria = @"YOURREPORTINGCRITERIA";
    
    //Callback URL (max. 255 characters) for the confirmation after the verification is completed. This setting overrides your Jumio account settings.
    //config.callbackUrl = @"https://www.example.com";
    
    //Set the default camera position
    //config.cameraPosition = JumioCameraPositionFront;
    
    //Configure your desired status bar style
    //config.statusBarStyle = UIStatusBarStyleLightContent;
    
    // Use a custom document code which can be configured in the settings tab of the Customer Portal
    //config.customDocumentCode = @"YOURCUSTOMDOCUMENTCODE";
    
    // Overrides the label for the document name (on Help Screen beside document icon)
    //config.documentName = @"DOCUMENTNAME";
    
    // Set the following property to enable/disable data extraction for documents. (default: YES) 
     config.enableExtraction = self.enableExtraction.isOn;
    
    //Localizing labels
    //All label texts and button titles can be changed and localized using the Localizable-DocumentVerification.strings file. Just adapt the values to your required language and use this file in your app.
    
    //Customizing look and feel
    //The SDK can be customized via UIAppearance to fit your application’s look and feel.
    //Please note, that only the below listed UIAppearance selectors are supported and taken into consideration. Experimenting with other UIAppearance or not UIAppearance selectors may cause unexpected behaviour or crashes both in the SDK or in your application. This is best avoided.
    
    // - Navigation bar: tint color, title color, title image
    //[[UINavigationBar jumioAppearance] setTintColor: [UIColor yellowColor]];
    //[[UINavigationBar jumioAppearance] setBarTintColor: [UIColor redColor]];
    //[[UINavigationBar jumioAppearance] setTitleTextAttributes: @{NSForegroundColorAttributeName: [UIColor whiteColor]}];
    
    //[[JumioNavigationBarTitleImageView jumioAppearance] setTitleImage: [UIImage imageNamed:@"<your-navigation-bar-title-image>"]];
    
    // - Custom general appearance - deactivate blur
    //[[DocumentVerificationBaseView jumioAppearance] setDisableBlur:@YES];
    
    // - Custom general appearance - enable dark mode
    //[[DocumentVerificationBaseView jumioAppearance] setEnableDarkMode:@YES];
    
    // - Custom general appearance - background color
    //[[DocumentVerificationBaseView jumioAppearance] setBackgroundColor: [UIColor grayColor]];
    
    // - Custom general appearance - foreground color (text-elements and icons)
    //[[DocumentVerificationBaseView jumioAppearance] setForegroundColor: [UIColor redColor]];
    
    // - Custom general appearance - font
    //The font has to be loaded upfront within the mainBundle before initializing the SDK
    //[[DocumentVerificationBaseView jumioAppearance] setCustomLightFontName: @"<your-font-name-loaded-in-your-app>"];
    //[[DocumentVerificationBaseView jumioAppearance] setCustomRegularFontName: @"<your-font-name-loaded-in-your-app>"];
    //[[DocumentVerificationBaseView jumioAppearance] setCustomMediumFontName: @"<your-font-name-loaded-in-your-app>"];
    //[[DocumentVerificationBaseView jumioAppearance] setCustomBoldFontName: @"<your-font-name-loaded-in-your-app>"];
    //[[DocumentVerificationBaseView jumioAppearance] setCustomItalicFontName: @"<your-font-name-loaded-in-your-app>"];
    
    // - Custom Positive Button Background Colors, custom class has to be imported (the same applies to DocumentVerificationNegativeButton)
    //[[DocumentVerificationPositiveButton jumioAppearance] setBackgroundColor:[UIColor cyanColor] forState:UIControlStateNormal];
    //[[DocumentVerificationPositiveButton jumioAppearance] setBackgroundColor:[UIColor blueColor] forState:UIControlStateHighlighted];
    
    //Custom Positive Button Background Image, custom class has to be imported
    //[[DocumentVerificationPositiveButton jumioAppearance] setBackgroundImage:[UIImage imageNamed:@"<your-custom-image>"] forState:UIControlStateNormal];
    //[[DocumentVerificationPositiveButton jumioAppearance] setBackgroundImage:[UIImage imageNamed:@"<your-custom-image>"] forState:UIControlStateHighlighted];
    
    //Custom Positive Button Title Colors, custom class has to be imported
    //[[DocumentVerificationPositiveButton jumioAppearance] setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    //[[DocumentVerificationPositiveButton jumioAppearance] setTitleColor:[UIColor magentaColor] forState:UIControlStateHighlighted];
    
    //Custom Positive Button Title Colors, custom class has to be imported
    //[[DocumentVerificationPositiveButton jumioAppearance] setBorderColor: [UIColor greenColor]];
    
    //You can get the current SDK version using the method below.
    //NSLog(@"%@", [DocumentVerificationViewController sdkVersion]);
    
    //Perform the following call as soon as your app’s view controller is initialized. Create the DocumentVerificationViewController instance by providing your Configuration with required API token, API secret and a delegate object.
    @try {
        self.documentVerificationViewController = [[DocumentVerificationViewController alloc] initWithConfiguration:config];
    } @catch (NSException *exception) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:exception.name message:exception.reason preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil]];
        [self presentViewController:alertController animated:YES completion:nil];
    }
}

- (IBAction) startDocumentVerification: (id) sender {
    [self createDocumentVerificationController];
    
    if (self.documentVerificationViewController) {
        [self presentViewController: self.documentVerificationViewController animated:YES completion:nil];
    } else {
        [self showAlertWithTitle:@"Document Verification SDK" message: @"DocumentVerificationViewController is nil"];
    }
}

/**
 * Implement the following delegate method for successful scans.
 * Dismiss the SDK view in your app once you received the result.
 * @param documentVerificationViewController The DocumentVerificationViewController instance
 * @param scanReference The scanReference of the scan attempt
 **/
- (void) documentVerificationViewController:(DocumentVerificationViewController*)documentVerificationViewController didFinishWithScanReference:(NSString*)scanReference {
    NSString* message = [NSString stringWithFormat: @"DocumentVerificationViewController finished successfully with scan reference: %@", scanReference];
    NSLog(@"%@", message);
    
    //Dismiss the SDK
    [self dismissViewControllerAnimated: YES completion: ^{
        [self showAlertWithTitle:@"DocumentVerification SDK" message:message];
        self.documentVerificationViewController = nil;
    }];
}

/**
 * Implement the following delegate method for successful scans and user cancellation notifications. Dismiss the SDK view in your app once you received the result.
 * @param documentVerificationViewController The DocumentVerificationViewController instance
 * @param error The error describing the cause of the problematic situation
 **/
- (void) documentVerificationViewController:(DocumentVerificationViewController*)documentVerificationViewController didFinishWithError:(DocumentVerificationError*)error {
    
    //handle the error cases as highlighted in our documentation: https://github.com/Jumio/mobile-sdk-ios/blob/master/docs/integration_faq.md#managing-errors
    
    NSLog(@"DocumentVerificationViewController cancelled with error: %@", error.message);
    //Dismiss the SDK
    [self dismissViewControllerAnimated: YES completion: ^{
        self.documentVerificationViewController = nil;
    }];
}

@end
