//
//  BAMCheckoutStartViewController.m
//
//  Copyright © 2019 Jumio Corporation All rights reserved.
//

#import "BAMCheckoutStartViewController.h"
#import "CustomScanOverlayViewController.h"
@import BAMCheckout;
#import <JumioCore/JMDeviceInfo.h>

@interface BAMCheckoutStartViewController () <BAMCheckoutViewControllerDelegate>
@property (nonatomic, strong) BAMCheckoutViewController *bamCheckoutViewController;
@end

@implementation BAMCheckoutStartViewController

- (void) createBAMCheckoutController{
    
    //prevent SDK to be initialized on Jailbroken devices
    if ([JMDeviceInfo isJailbrokenDevice]) {
        return;
    }
    
    //Setup the Configuration for BAMCheckout
    BAMCheckoutConfiguration *config = [BAMCheckoutConfiguration new];
    //Provide your API token
    config.merchantApiToken = @"YOUR_BAMCHECKOUT_APITOKEN";
    //Provide your API secret
    config.merchantApiSecret = @"YOUR_BAMCHECKOUT_APISECRET";
    
    //Set the delegate that implements BAMCheckoutViewControllerDelegate
    config.delegate = self;
    
    //Set the dataCenter; default is JumioDataCenterUS
    //config.dataCenter = JumioDataCenterEU;
    
    //Use the following property to enable offline credit card scanning.
    //config.offlineToken = @"YOUR_OFFLINE_TOKEN";
    
    //Use the following property to identify the scan in your reports (max. 100 characters).
    //config.merchantReportingCriteria = @"YOURREPORTINGCRITERIA";
    
    //To restrict supported card types, pass a bitmask of BAMCheckoutCreditCardTypes to the property supportedCreditCardTypes.
    //BAMCheckoutCreditCardTypes cardTypes = BAMCheckoutCreditCardTypeAll;
    //BAMCheckoutCreditCardTypes cardTypes = BAMCheckoutCreditCardTypeAmericanExpress | BAMCheckoutCreditCardTypeChinaUnionPay | BAMCheckoutCreditCardTypeDiners | BAMCheckoutCreditCardTypeDiscover | BAMCheckoutCreditCardTypeJCB | BAMCheckoutCreditCardTypeMasterCard | BAMCheckoutCreditCardTypeVisa;
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
    
    //You can add custom fields to the "Additional Info" view (text input field or selection)
    //[config addCustomField: @"idZipCode" title: @"Zip code" keyboardType: UIKeyboardTypeNumberPad regularExpression:@"[0-9]{5,}"];
    
    //NSArray* states = @[@"Alabama", @"Alaska", @"Arizona", @"Arkansas", @"California", @"Colorado", @"Connecticut", @"Delaware", @"Florida", @"Georgia", @"Hawaii", @"Idaho", @"Illinois", @"Indiana", @"Iowa", @"Kansas", @"Kentucky", @"Louisiana", @"Maine", @"Maryland", @"Massachusetts", @"Michigan", @"Minnesota", @"Mississippi", @"Missouri", @"Montana", @"Nebraska", @"Nevada", @"New Hampshire", @"New Jersey", @"New Mexico", @"New York", @"North Carolina", @"North Dakota", @"Ohio", @"Oklahoma", @"Oregon", @"Pennsylvania", @"Rhode Island", @"South Carolina", @"South Dakota", @"Tennessee", @"Texas", @"Utah", @"Vermont", @"Virginia", @"Washington", @"West Virginia", @"Wisconsin", @"Wyoming"];
    //[config addCustomField: @"idState" title: @"State" values:states required:NO resetValueText:@"-- no value --"];
    //or
    //[config addCustomField: @"idState" title: @"State" values:states required:YES resetValueText:@"not shown"];
    
    //Perform the following call as soon as your app’s view controller is initialized. This creates the BAMCheckoutViewController instance by providing your Configuration with required merchant API token, merchant API secret and a delegate object.
    @try {
        self.bamCheckoutViewController = [[BAMCheckoutViewController alloc] initWithConfiguration:config];
    } @catch (NSException *exception) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:exception.name message:exception.reason preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil]];
         [self presentViewController:alertController animated:YES completion:nil];
    }
    
    if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
        self.bamCheckoutViewController.modalPresentationStyle = UIModalPresentationFormSheet;  // For iPad, present from sheet
    }
    
    //Localizing labels
    //All label texts and button titles can be changed and localized using the Localizable-BAMCheckout.strings file. Just adapt the values to your required language and add this file in your Xcode project.
    
    //Customizing look and feel
    //The SDK can be customized to fit your application’s look and feel.
    //Please note, that only the below listed UIAppearance selectors are supported and taken into consideration. Experimenting with other UIAppearance or not UIAppearance selectors may cause unexpected behaviour or crashes both in the SDK or in your application. This is best avoided.
    
    // - Customize buttons: title color, background color, background image selectors for BAMCheckoutPositiveButton, BAMCheckoutNegativeButton
    
    //[[BAMCheckoutPositiveButton bamCheckoutAppearance] setBackgroundColor:[UIColor cyanColor] forState:UIControlStateNormal];
    //[[BAMCheckoutPositiveButton bamCheckoutAppearance] setBackgroundColor:[UIColor blueColor] forState:UIControlStateHighlighted];
    
    //[[BAMCheckoutPositiveButton bamCheckoutAppearance] setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    //[[BAMCheckoutPositiveButton bamCheckoutAppearance] setTitleColor:[UIColor magentaColor] forState:UIControlStateHighlighted];
    
    //If a backgroundImage is set, backgroundColor will have no effect
    //[[BAMCheckoutPositiveButton bamCheckoutAppearance] setBackgroundImage:[UIImage imageNamed:@"<your-custom-image>"] forState:UIControlStateNormal];
    //[[BAMCheckoutPositiveButton bamCheckoutAppearance] setBackgroundImage:[UIImage imageNamed:@"<your-custom-image>"] forState:UIControlStateHighlighted];
    
    // - Navigation bar: tint color, title color, title image
    
    //[[UINavigationBar bamCheckoutAppearance] setTintColor:[UIColor yellowColor]];
    //[[UINavigationBar bamCheckoutAppearance] setBarTintColor:[UIColor redColor]];
    //[[UINavigationBar bamCheckoutAppearance] setTitleTextAttributes: @{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    // - Navigation bar background color
    
    //[[UINavigationBar bamCheckoutAppearance] setBarTintColor:[UIColor redColor]];
    
    //[[BAMCheckoutNavigationBarTitleImageView bamCheckoutAppearance] setTitleImage:[UIImage imageNamed:@"<your-bamcheckout-navigation-bar-title-image>"]];
    
    //Custom general appearance - font
    //The font has to be loaded upfront within the mainBundle before initializing the SDK
    //[[BAMCheckoutBaseView bamCheckoutAppearance] setCustomLightFontName: @"<your-font-name-loaded-in-your-app>"];
    //[[BAMCheckoutBaseView bamCheckoutAppearance] setCustomRegularFontName: @"<your-font-name-loaded-in-your-app>"];
    //[[BAMCheckoutBaseView bamCheckoutAppearance] setCustomMediumFontName: @"<your-font-name-loaded-in-your-app>"];
    //[[BAMCheckoutBaseView bamCheckoutAppearance] setCustomBoldFontName: @"<your-font-name-loaded-in-your-app>"];
    
    // - Custom general appearance - deactivate blur
    //[[BAMCheckoutBaseView bamCheckoutAppearance] setDisableBlur:@(NO)];
    
    // - Custom general appearance - background color
    //[[BAMCheckoutBaseView bamCheckoutAppearance] setBackgroundColor: [UIColor grayColor]];
    
    // - Custom general appearance - foreground color (text-elements and icons)
    //[[BAMCheckoutBaseView bamCheckoutAppearance] setForegroundColor: [UIColor redColor]];
    
    // - Custom general appearance - ScanOverlay border color
    //[[BAMCheckoutScanOverlay bamCheckoutAppearance] setBorderColor: [UIColor greenColor]];
    
    // - Custom general appearance - ScanOverlay text color
    //[[BAMCheckoutScanOverlay bamCheckoutAppearance] setTextColor: [UIColor blueColor]];
    
    //You can get the current SDK version using the method below.
    //NSLog(@"%@", [self.bamCheckoutViewController sdkVersion]);
}

/**
 * Create the BAMCheckoutViewController with a custom ScanOverlay
 */
- (void) createBAMCheckoutControllerCustom {
    //Perform the following call as soon as your app’s view controller is initialized. This creates the BAMCheckoutViewController instance by providing your Configuration with required merchant API token, merchant API secret, a delegate object and custom overlay.
    //Use the following snippet instead to initialize the BAMCheckoutViewController with a custom OverlayViewController
    CustomScanOverlayViewController *customOverlay = [[CustomScanOverlayViewController alloc] initWithNibName:@"CustomScanOverlayViewController" bundle:nil];
    
    BAMCheckoutConfiguration *config = [BAMCheckoutConfiguration new];
    
    config.merchantApiToken = @"YOUR_BAMCHECKOUT_APITOKEN";
    config.merchantApiSecret = @"YOUR_BAMCHECKOUT_APISECRET";
    config.dataCenter = JumioDataCenterUS;
    config.delegate = self;
    config.merchantReportingCriteria = @"YOURREPORTINGCRITERIA";
    config.customOverlay = customOverlay;
    
    @try {
        self.bamCheckoutViewController = [[BAMCheckoutViewController alloc]initWithConfiguration:config];
    } @catch (NSException *exception) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:exception.name message:exception.reason preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil]];
        [self presentViewController:alertController animated:YES completion:nil];
    }
}

- (IBAction) startBAMCheckout: (id) sender {
    //Create the BAMCheckoutViewController with default overlay
    [self createBAMCheckoutController];
    
    //Create the BAMCheckoutViewController with custom overlay
    //[self createBAMCheckoutControllerCustom];
    
    
    //To show the SDK, call the method below within your ViewController.
    if (self.bamCheckoutViewController) {
        [self presentViewController: self.bamCheckoutViewController animated:YES completion:nil];
    } else {
        [self showAlertWithTitle:@"BAMCheckout Mobile SDK" message: @"BAMCheckoutViewController is nil"];
    }
}

#pragma mark - BAMCheckoutViewControllerDelegate

/**
 * Will be called on a scan attempt
 * @param controller The BAMCheckoutViewController
 * @param requestReference The requestReference of the scan attempt
 */
- (void)bamCheckoutViewController:(BAMCheckoutViewController *)controller didStartScanAttemptWithScanReference:(NSString *)scanReference {
    NSLog(@"BAMCheckoutViewController did start scan attempt with request reference: %@", scanReference);
}

/**
 * Upon success, the parameter cardInformation will be returned. Call clear after processing the card information to make sure no sensitive data remains in the device's memory.
 * @param controller The BAMCheckoutViewController
 * @param cardInformation The card information result
 * @param scanReference The reference of the scan attempt
 */
- (void)bamCheckoutViewController:(BAMCheckoutViewController *)controller didFinishScanWithCardInformation:(BAMCheckoutCardInformation *)cardInformation scanReference:(NSString *)scanReference {
    
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
    
    //Get the value of the additional field
    //NSMutableString *zipCode = [cardInformation getCustomField: @"idZipCode"];
    //NSLog(@"Additional field value: %@", zipCode);
    
    NSMutableString *message = [NSMutableString new];
    
    [message appendFormat: @"Request reference: %@\nCard number: %@\nGrouped: %@\n", scanReference, cardNumber, cardNumberGrouped];
    if (expiryDate) {
        [message appendFormat:@"Expiry date: %@\nExpiry date month: %@\nExpiry date year: %@\n", expiryDate, expiryMonth, expiryYear];
    }
    if (cvv) {
        [message appendFormat:@"CVV code: %@\n", cvv];
    }
    if (cardHolderName) {
        [message appendFormat:@"Card holder: %@\n", cardHolderName];
    }
    if (sortCode) {
        [message appendFormat:@"Sort code: %@\n", sortCode];
        [message appendFormat:@"Sort Code valid: %@\n", sortCodeValid ? @"YES" : @"NO"];
    }
    if (accountNumber != nil) {
        [message appendFormat:@"Account number: %@\n", accountNumber];
        [message appendFormat:@"Account Number valid: %@",  accountNumberValid ? @"YES" : @"NO"];
    }

    
    //Dismiss the SDK
    [self dismissViewControllerAnimated: YES completion: ^{
        [self showAlertWithTitle:@"BAMCheckout Mobile SDK" message:message];
    }];
}


/**
 * The parameter error contains the user cancellation reason.
 * @param controller The BAMCheckoutViewController
 * @param error The error codes 200, 210, 220, 240, 250, 260 and 310 will be returned. Using the custom scan view, the error codes 260 and 310 will be returned.
 **/
- (void)bamCheckoutViewController:(BAMCheckoutViewController *)controller didCancelWithError:(NSError *)error scanReference:(NSString *)scanReference {
    NSInteger code = error.code;
    NSString *message = error.localizedDescription;
    NSLog(@"Cancelled with error code: %ld, message: %@, scan reference: %@", (long)code, message, scanReference);
    
    //Dismiss the SDK
    [self dismissViewControllerAnimated: YES completion: nil];
}

@end
