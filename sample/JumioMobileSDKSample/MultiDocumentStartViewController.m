//
//  MultiDocumentStartViewController.m
//
//  Copyright © 2017 Jumio Corporation All rights reserved.
//

#import "MultiDocumentStartViewController.h"
@import Netverify;

@interface MultiDocumentStartViewController () <MultiDocumentViewControllerDelegate>
@property (nonatomic, strong) MultiDocumentViewController *multiDocumentViewController;
@end

@implementation MultiDocumentStartViewController

- (void) createMultiDocumentController {
    //Setup the Configuration for MultiDocument
    MultiDocumentConfiguration *config = [MultiDocumentConfiguration new];
    //Provide your API token
    config.merchantApiToken = @"YOUR_MULTIDOCUMENT_APITOKEN";
    //Provide your API secret
    config.merchantApiSecret = @"YOUR_MULTIDOCUMENT_APISECRET";
    //Set the delegate that implements MultiDocumentViewControllerDelegate
    config.delegate = self;
    
    //Set the dataCenter; default is JumioDataCenterUS
    //config.dataCenter = JumioDataCenterEU;
    
    //Make sure to specify issuing country (ISO 3166-1 alpha-3 country code)
    config.country = @"AUT";
    
    //One of the configured DocumentTypeCodes: BC, BS, CAAP, CB, CCS, CRC, HCC, IC, LAG, LOAP,
    //MEDC, MOAP, PB, SEL, SENC, SS, STUC, TAC, TR, UB, SSC, USSS, VC, VT, WWCC, CUSTOM
    config.type = @"BC";
    
    //The merchant scan reference allows you to identify the scan (max. 100 characters). Note: Must not contain sensitive data like PII (Personally Identifiable Information) or account login.
    config.merchantScanReference = @"YOURSCANREFERENCE";
    
    //You can also set a customer identifier (max. 100 characters). Note: The customer ID should not contain sensitive data like PII (Personally Identifiable Information) or account login.
    config.customerId = @"CUSTOMERID";
    
    //Use the following property to identify the scan in your reports (max. 100 characters).
    //config.merchantReportingCriteria = @"YOURREPORTINGCRITERIA";
    
    //Callback URL (max. 255 characters) for the confirmation after the verification is completed. This setting overrides your Jumio merchant settings.
    //config.callbackUrl = @"https://www.example.com";
    
    //Set the default camera position
    //config.cameraPosition = JumioCameraPositionFront;
    
    //Configure your desired status bar style
    //config.statusBarStyle = UIStatusBarStyleLightContent;
    
    //Additional information for this scan should not contain sensitive data like PII (Personally Identifiable Information) or account login
    //config.additionalInformation = @"YOURADDITIONALINFORMATION";
    
    // One of the Custom Document Type Codes as configurable by Merchant in Merchant UI.
    //config.customDocumentCode = @"YOURCUSTOMDOCUMENTCODE";
    
    // Overrides the label for the document name (on Help Screen beside document icon)
    //config.documentName = @"DOCUMENTNAME";
    
    //Perform the following call as soon as your app’s view controller is initialized. Create the MultiDocumentViewController instance by providing your Configuration with required merchant API token, merchant API secret and a delegate object.
    @try {
        self.multiDocumentViewController = [[MultiDocumentViewController alloc] initWithConfiguration:config];
    } @catch (NSException *exception) {
        [[[UIAlertView alloc] initWithTitle:exception.name
                                    message:exception.reason
                                   delegate:nil
                          cancelButtonTitle:@"OK"
                          otherButtonTitles: nil] show];
    }
    
    //Localizing labels
    //All label texts and button titles can be changed and localized using the Localizable-MultiDocument.strings file. Just adapt the values to your required language and use this file in your app.
    
    //Customizing look and feel
    //The SDK can be customized via UIAppearance to fit your application’s look and feel.
    //The API from Netverify is re-used to apply visual customization for MultiDocument. Please have a look at the above section where MultiDocumentViewController is created and configured.
    
    //You can get the current SDK version using the method below.
    //NSLog(@"%@", [self.multiDocumentViewController sdkVersion]);
}

- (IBAction) startMultiDocument: (id) sender {
    [self createMultiDocumentController];
    
    if (self.multiDocumentViewController) {
        [self presentViewController: self.multiDocumentViewController animated:YES completion:nil];
    } else {
        [self showAlertWithTitle:@"Netverify Mobile SDK" message: @"MultiDocumentViewController is nil"];
    }
}

/**
 * Implement the following delegate method for successful scans.
 * Dismiss the SDK view in your app once you received the result.
 * @param documentData The NetverifyDocumentData of the scanned document
 * @param scanReference The scanReference of the scan attempt
 **/
- (void) multiDocumentViewController:(MultiDocumentViewController*) multiDocumentViewController didFinishWithScanReference:(NSString*)scanReference {
    NSString* message = [NSString stringWithFormat: @"MultiDocumentViewController finished successfully with scan reference: %@", scanReference];
    NSLog(@"%@", message);
    
    //Dismiss the SDK
    [self dismissViewControllerAnimated: YES completion: ^{
        [self showAlertWithTitle:@"MultiDocument SDK" message:message];
    }];
}

/**
 * Implement the following delegate method for successful scans and user cancellation notifications. Dismiss the SDK view in your app once you received the result.
 * @param multiDocumentViewController The MultiDocumentViewController instance
 * @param error The returned Errors
 **/
- (void) multiDocumentViewController:(MultiDocumentViewController*) multiDocumentViewController didFinishWithError:(NSError*)error {
    NSLog(@"MultiDocumentViewController cancelled with error: %@", error.localizedDescription);
    //Dismiss the SDK
    [self dismissViewControllerAnimated: YES completion: nil];
}

@end
