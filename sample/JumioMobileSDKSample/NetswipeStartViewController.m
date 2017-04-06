//
//  NetswipeStartViewController.m
//
//  Copyright © 2017 Jumio Corporation All rights reserved.
//

#import "NetswipeStartViewController.h"
#import "CustomScanOverlayViewController.h"
@import Netswipe;

@interface NetswipeStartViewController () <NetswipeViewControllerDelegate>
@property (nonatomic, strong) NetswipeViewController *netswipeViewController;
@end

@implementation NetswipeStartViewController

- (void) createNetswipeController{
    
    //Setup the Configuration for Netswipe
    NetswipeConfiguration *config = [NetswipeConfiguration new];
    //Provide your API token
    config.merchantApiToken = @"YOUR_NETSWIPE_APITOKEN";
    //Provide your API secret
    config.merchantApiSecret = @"YOUR_NETSWIPE_APISECRET";
    
    //Set the delegate that implements NetswipeViewControllerDelegate
    config.delegate = self;
    
    //Set the dataCenter; default is JumioDataCenterUS
    //config.dataCenter = JumioDataCenterEU;
    
    //Use the following property to enable offline credit card scanning.
    //config.offlineToken = @"YOUR_OFFLINE_TOKEN";
    
    //Use the following property to identify the scan in your reports (max. 100 characters).
    //config.merchantReportingCriteria = @"YOURREPORTINGCRITERIA";
    
    //To restrict supported card types, pass a bitmask of NetswipeCreditCardTypes to the property supportedCreditCardTypes.
    //NetswipeCreditCardTypes cardTypes = NetswipeCreditCardTypeAll;
    //NetswipeCreditCardTypes cardTypes = NetswipeCreditCardTypeAmericanExpress | NetswipeCreditCardTypeChinaUnionPay | NetswipeCreditCardTypeDiners | NetswipeCreditCardTypeDiscover | NetswipeCreditCardTypeJCB | NetswipeCreditCardTypeMasterCard | NetswipeCreditCardTypeVisa;
    //config.supportedCreditCardTypes = cardTypes;
    
    //Expiry recognition, card holder name and CVV entry are enabled by default and can be disabled.
    //You can enable the recognition of sort code and account number.
    //config.expiryRequired = NO;
    //config.cardHolderNameRequired = NO;
    config.cvvRequired = self.switchCvvRequired.isOn;
    //config.sortCodeAndAccountNumberRequired = YES;
    
    //You can show the unmasked credit card number to the user during the workflow if cardNumberMaskingEnabled is disabled
    //config.cardNumberMaskingEnabled = NO;
    
    //The user can edit the recognized expiry date if expiryEditable is enabled.
    //config.expiryEditable = YES;
    
    //The user can edit the recognized card holder name if cardHolderNameEditable is enabled.
    //config.cardHolderNameEditable = YES;
    
    //You can set a short vibration (only on iPhone) and sound effect to notify the user that the card has been detected.
    //config.vibrationEffectEnabled = YES;
    //config.soundEffect = @"YOURSOUNDFILE.aif";
    
    //Automatically enable flash when scan is started
    //config.enableFlashOnScanStart = YES;
    
    //Set the default camera position
    //config.cameraPosition = JumioCameraPositionFront;
    
    //Configure your desired status bar style
    //config.statusBarStyle = UIStatusBarStyleLightContent;
    
    //Use the following method to provide the Adyen Public Key. This activates the generation of an encrypted Adyen payment data object.
    //config.adyenPublicKey = @"YOUR_ADYEN_PUBLIC_KEY";
    
    //You can add custom fields to the "Additional Info" view (text input field or selection)
    //[config addCustomField: @"idZipCode" title: @"Zip code" keyboardType: UIKeyboardTypeNumberPad regularExpression:@"[0-9]{5,}"];
    
    //NSArray* states = @[@"Alabama", @"Alaska", @"Arizona", @"Arkansas", @"California", @"Colorado", @"Connecticut", @"Delaware", @"Florida", @"Georgia", @"Hawaii", @"Idaho", @"Illinois", @"Indiana", @"Iowa", @"Kansas", @"Kentucky", @"Louisiana", @"Maine", @"Maryland", @"Massachusetts", @"Michigan", @"Minnesota", @"Mississippi", @"Missouri", @"Montana", @"Nebraska", @"Nevada", @"New Hampshire", @"New Jersey", @"New Mexico", @"New York", @"North Carolina", @"North Dakota", @"Ohio", @"Oklahoma", @"Oregon", @"Pennsylvania", @"Rhode Island", @"South Carolina", @"South Dakota", @"Tennessee", @"Texas", @"Utah", @"Vermont", @"Virginia", @"Washington", @"West Virginia", @"Wisconsin", @"Wyoming"];
    //[config addCustomField: @"idState" title: @"State" values:states required:NO resetValueText:@"-- no value --"];
    //or
    //[config addCustomField: @"idState" title: @"State" values:states required:YES resetValueText:@"not shown"];
    
    //Perform the following call as soon as your app’s view controller is initialized. This creates the NetswipeViewController instance by providing your Configuration with required merchant API token, merchant API secret and a delegate object.
    @try {
        self.netswipeViewController = [[NetswipeViewController alloc] initWithConfiguration:config];
    } @catch (NSException *exception) {
        [[[UIAlertView alloc] initWithTitle:exception.name
                                    message:exception.reason
                                   delegate:nil
                          cancelButtonTitle:@"OK"
                          otherButtonTitles: nil] show];
    }
    
    if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
        self.netswipeViewController.modalPresentationStyle = UIModalPresentationFormSheet;  // For iPad, present from sheet
    }
    
    //Localizing labels
    //All label texts and button titles can be changed and localized using the Localizable-Netswipe.strings file. Just adapt the values to your required language and add this file in your Xcode project.
    
    //Customizing look and feel
    //The SDK can be customized to fit your application’s look and feel.
    //Please note, that only the below listed UIAppearance selectors are supported and taken into consideration. Experimenting with other UIAppearance or not UIAppearance selectors may cause unexpected behaviour or crashes both in the SDK or in your application. This is best avoided.
    
    // - Customize buttons: title color, background color, background image selectors for NetswipePositiveButton, NetswipeNegativeButton
    
    //[[NetswipePositiveButton netswipeAppearance] setBackgroundColor:[UIColor cyanColor] forState:UIControlStateNormal];
    //[[NetswipePositiveButton netswipeAppearance] setBackgroundColor:[UIColor blueColor] forState:UIControlStateHighlighted];
    
    //[[NetswipePositiveButton netswipeAppearance] setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    //[[NetswipePositiveButton netswipeAppearance] setTitleColor:[UIColor magentaColor] forState:UIControlStateHighlighted];
    
    //If a backgroundImage is set, backgroundColor will have no effect
    //[[NetswipePositiveButton netswipeAppearance] setBackgroundImage:[UIImage imageNamed:@"<your-custom-image>"] forState:UIControlStateNormal];
    //[[NetswipePositiveButton netswipeAppearance] setBackgroundImage:[UIImage imageNamed:@"<your-custom-image>"] forState:UIControlStateHighlighted];
    
    // - Navigation bar: tint color, title color, title image
    
    //[[UINavigationBar netswipeAppearance] setTintColor:[UIColor yellowColor]];
    //[[UINavigationBar netswipeAppearance] setBarTintColor:[UIColor redColor]];
    //[[UINavigationBar netswipeAppearance] setTitleTextAttributes: @{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    // - Navigation bar background color
    
    //[[UINavigationBar netswipeAppearance] setBarTintColor:[UIColor redColor]];
    
    //[[NetswipeNavigationBarTitleImageView netswipeAppearance] setTitleImage:[UIImage imageNamed:@"<your-netswipe-navigation-bar-title-image>"]];
    
    //Custom general appearance - font
    //The font has to be loaded upfront within the mainBundle before initializing the SDK
    //[[NetswipeBaseView netswipeAppearance] setCustomLightFontName: @"<your-font-name-loaded-in-your-app>"];
    //[[NetswipeBaseView netswipeAppearance] setCustomRegularFontName: @"<your-font-name-loaded-in-your-app>"];
    //[[NetswipeBaseView netswipeAppearance] setCustomMediumFontName: @"<your-font-name-loaded-in-your-app>"];
    //[[NetswipeBaseView netswipeAppearance] setCustomBoldFontName: @"<your-font-name-loaded-in-your-app>"];
    
    // - Custom general appearance - deactivate blur
    //[[NetswipeBaseView netswipeAppearance] setDisableBlur:@(NO)];
    
    // - Custom general appearance - background color
    //[[NetswipeBaseView netswipeAppearance] setBackgroundColor: [UIColor grayColor]];
    
    // - Custom general appearance - foreground color (text-elements and icons)
    //[[NetswipeBaseView netswipeAppearance] setForegroundColor: [UIColor redColor]];
    
    // - Custom general appearance - ScanOverlay border color
    //[[NetswipeScanOverlay netswipeAppearance] setBorderColor: [UIColor greenColor]];
    
    // - Custom general appearance - ScanOverlay text color
    //[[NetswipeScanOverlay netswipeAppearance] setTextColor: [UIColor blueColor]];
    
    //You can get the current SDK version using the method below.
    //NSLog(@"%@", [self.netswipeViewController sdkVersion]);
}

/**
 * Create the NetswipeViewController with a custom ScanOverlay
 */
- (void) createNetswipeControllerCustom {
    //Perform the following call as soon as your app’s view controller is initialized. This creates the NetswipeViewController instance by providing your Configuration with required merchant API token, merchant API secret, a delegate object and custom overlay.
    //Use the following snippet instead to initialize the NetswipeViewController with a custom OverlayViewController
    CustomScanOverlayViewController *customOverlay = [[CustomScanOverlayViewController alloc] initWithNibName:@"CustomScanOverlayViewController" bundle:nil];
    
    NetswipeConfiguration *config = [NetswipeConfiguration new];
    
    config.merchantApiToken = @"YOUR_NETSWIPE_APITOKEN";
    config.merchantApiSecret = @"YOUR_NETSWIPE_APISECRET";
    config.dataCenter = JumioDataCenterUS;
    config.delegate = self;
    config.merchantReportingCriteria = @"YOURREPORTINGCRITERIA";
    config.customOverlay = customOverlay;
    
    @try {
        self.netswipeViewController = [[NetswipeViewController alloc]initWithConfiguration:config];
    } @catch (NSException *exception) {
        [[[UIAlertView alloc] initWithTitle:exception.name
                                    message:exception.reason
                                   delegate:nil
                          cancelButtonTitle:@"OK"
                          otherButtonTitles: nil] show];
    }
}

- (IBAction) startNetswipe: (id) sender {
    //Create the NetswipeViewController with default overlay
    [self createNetswipeController];
    
    //Create the NetswipeViewController with custom overlay
    //[self createNetswipeControllerCustom];
    
    
    //To show the SDK, call the method below within your ViewController.
    if (self.netswipeViewController) {
        [self presentViewController: self.netswipeViewController animated:YES completion:nil];
    } else {
        [self showAlertWithTitle:@"Netswipe Mobile SDK" message: @"NetswipeViewController is nil"];
    }
}

#pragma mark - NetswipeViewControllerDelegate

/**
 * Upon success, the parameter cardInformation will be returned. Call clear after processing the card information to make sure no sensitive data remains in the device's memory.
 * @param controller The NetswipeViewController
 * @param cardInformation The card information result
 * @param scanReference The reference of the scan attempt
 */
- (void)netswipeViewController:(NetswipeViewController *)controller didFinishScanWithCardInformation:(NetswipeCardInformation *)cardInformation scanReference:(NSString *)scanReference {
    
    //Use the cardInformation
    NSMutableString *cardNumber = cardInformation.cardNumber;
    NSMutableString *cardNumberGrouped = cardInformation.cardNumberGrouped;
    NSMutableString *expiryMonth = cardInformation.cardExpiryMonth;
    NSMutableString *expiryYear = cardInformation.cardExpiryYear;
    NSMutableString *expiryDate = cardInformation.cardExpiryDate;
    NSMutableString *cvv = cardInformation.cardCVV;
    NSMutableString *cardHolderName = cardInformation.cardHolderName;
    NSMutableString *sortCode = cardInformation.cardSortCode;
    NSString *accountNumber = cardInformation.cardAccountNumber;
    BOOL sortCodeValid = cardInformation.cardSortCodeValid;
    BOOL accountNumberValid = cardInformation.cardAccountNumberValid;
    
    //The Encrypted ADYEN string
    //NSString *encryptedAdyenString = cardInformation.encryptedAdyenString;
    
    //Get the value of the additional field
    //NSMutableString *zipCode = [cardInformation getCustomField: @"idZipCode"];
    //NSLog(@"Additional field value: %@", zipCode);
    
    NSString *message = [NSString stringWithFormat:@"Request reference: %@\nCard number: %@\nGrouped: %@\nExpiry date: %@\nExpiry date month: %@\nExpiry date year: %@\nCVV code: %@\nCard holder: %@\nSort code: %@\nAccount number: %@\nSort Code valid: %@\n Account Number valid: %@",scanReference, cardNumber, cardNumberGrouped, expiryDate, expiryMonth, expiryYear, cvv, cardHolderName, sortCode, accountNumber, sortCodeValid ? @"YES" : @"NO", accountNumberValid ? @"YES" : @"NO"];
    
    //Dismiss the SDK
    [self dismissViewControllerAnimated: YES completion: ^{
        [self showAlertWithTitle:@"Netswipe Mobile SDK" message:message];
    }];
}


/**
 * The parameter error contains the user cancellation reason.
 * @param controller The NetswipeViewController
 * @param error The error codes 200, 210, 220, 240, 250, 260 and 310 will be returned. Using the custom scan view, the error codes 260 and 310 will be returned.
 **/
- (void)netswipeViewController:(NetswipeViewController *)controller didCancelWithError:(NSError *)error scanReference:(NSString *)scanReference {
    NSInteger code = error.code;
    NSString *message = error.localizedDescription;
    NSLog(@"Cancelled with error code: %ld, message: %@, scan reference: %@", (long)code, message, scanReference);
    
    //Dismiss the SDK
    [self dismissViewControllerAnimated: YES completion: nil];
}

/**
 * Will be called on a scan attempt
 * @param controller The NetswipeViewController
 * @param requestReference The requestReference of the scan attempt
 */
- (void)netswipeViewController:(NetswipeViewController *)controller didStartScanAttemptWithScanReference:(NSString *)scanReference {
    NSLog(@"NetswipeViewController did start scan attempt with request reference: %@", scanReference);
}

@end
