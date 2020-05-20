//
//  AuthenticationStartViewController.m
//
//  Copyright © 2020 Jumio Corporation. All rights reserved.
//

#import "AuthenticationStartViewController.h"
@import JumioCore;
@import NetverifyFace;

@interface AuthenticationStartViewController () <AuthenticationControllerDelegate>
@property (nonatomic, strong) AuthenticationController *authenticationController;
@property (nonatomic, strong) UIViewController *authenticationScanViewController;

@end

@implementation AuthenticationStartViewController
    
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    NSString *transactionReference = [[NSUserDefaults standardUserDefaults] stringForKey:@"enrollmentTransactionReference"];
    if (transactionReference) {
        [self.transactionReferenceTextField setText:transactionReference];
    }
}

- (void) createAuthenticationController {
    //Prevent SDK to be initialized on Jailbroken devices
    if ([JumioDeviceInfo isJailbrokenDevice]) {
        return;
    }
    
    // Setup the Configuration for Authentication
    AuthenticationConfiguration *config = [self createAuthenticationConfiguration];
    
    @try {
        _authenticationController = [[AuthenticationController alloc] initWithConfiguration:config];
    } @catch (NSException *exception) {
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:exception.name message:exception.reason preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil]];
        [self presentViewController:alertController animated:YES completion:nil];
    }
}

- (AuthenticationConfiguration*) createAuthenticationConfiguration {
    AuthenticationConfiguration *config = [AuthenticationConfiguration new];
    
    //Provide your API token and your API secret
    //Do not store your credentials hardcoded within the app. Make sure to store them server-side and load your credentials during runtime.
    config.apiToken = @"YOUR_AUTHENTICATION_APITOKEN";
    config.apiSecret = @"YOUR_AUTHENTICATION_APISECRET";
    
    //Set the delegate that implements AuthenticationControllerDelegate
    config.delegate = self;
    
    //Use the following property to reference the Authentication transaction to a specific Netverify user identity
    //config.enrollmentTransactionReference = @"ENROLLMENT_TRANSACTION_REFERENCE";
    config.enrollmentTransactionReference = [self.transactionReferenceTextField text];
    
    //Instead an Authentication transaction can also be created via the facemap server to server API and set here
    //config.authenticationTransactionReference = @"AUTHENTICATION_TRANSACTION_REFERENCE";

    //Set the dataCenter; default is JumioDataCenterUS
    //config.dataCenter = JumioDataCenterEU;
    //config.dataCenter = JumioDataCenterSG;
    
    //You can also set a customer identifier (max. 100 characters). Note: The customer ID should not contain sensitive data like PII (Personally Identifiable Information) or account login.
    //config.userReference = @"USER_REFERENCE";
    
    //Callback URL (max. 255 characters) for the confirmation after the authentication is completed. This setting overrides your Jumio account settings.
    //config.callbackUrl = @"https://www.example.com";
    
    //Configure your desired status bar style
    //config.statusBarStyle = UIStatusBarStyleLightContent;
    
    //Localizing labels
    //All label texts and button titles can be changed and localized using the Localizable-Authentication.strings file. Just adapt the values to your required language and use this file in your app.
    
    //Customizing look and feel
    //The SDK can be customized via UIAppearance to fit your application’s look and feel.
    //Please note, that only the below listed UIAppearance selectors are supported and taken into consideration. Experimenting with other UIAppearance or not UIAppearance selectors may cause unexpected behaviour or crashes both in the SDK or in your application. This is best avoided.
    
    // - Navigation bar: tint color, title color, title image
    //[[UINavigationBar jumioAppearance] setTintColor:[UIColor yellowColor]];
    //[[UINavigationBar jumioAppearance] setBarTintColor:[UIColor redColor]];
    //[[UINavigationBar jumioAppearance] setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
    
    //[[JumioNavigationBarTitleImageView jumioAppearance] setTitleImage: [UIImage imageNamed:@"<your-navigation-bar-title-image>"]];
    
    // - Custom general appearance - deactivate blur
    //[[JumioBaseView jumioAppearance] setDisableBlur:@YES];
    
    // - Custom general appearance - enable dark mode
    //[[JumioBaseView jumioAppearance] setEnableDarkMode:@YES];
    
    // - Custom general appearance - background color
    //[[JumioBaseView jumioAppearance] setBackgroundColor: [UIColor grayColor]];
    
    // - Custom general appearance - foreground color (text-elements and icons)
    //[[JumioBaseView jumioAppearance] setForegroundColor: [UIColor redColor]];
    
    // - Custom Positive Button Background Colors, custom class has to be imported (the same applies to JumioNegativeButton)
    //[[JumioPositiveButton jumioAppearance] setBackgroundColor:[UIColor cyanColor] forState:UIControlStateNormal];
    //[[JumioPositiveButton jumioAppearance] setBackgroundColor:[UIColor blueColor] forState:UIControlStateHighlighted];
    
    //Custom Positive Button Background Image, custom class has to be imported
    //[[JumioPositiveButton jumioAppearance] setBackgroundImage:[UIImage imageNamed:@"<your-custom-image>"] forState:UIControlStateNormal];
    //[[JumioPositiveButton jumioAppearance] setBackgroundImage:[UIImage imageNamed:@"<your-custom-image>"] forState:UIControlStateHighlighted];
    
    //Custom Positive Button Title Colors, custom class has to be imported
    //[[JumioPositiveButton jumioAppearance] setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    //[[JumioPositiveButton jumioAppearance] setTitleColor:[UIColor magentaColor] forState:UIControlStateHighlighted];
    
    //Custom Positive Button Title Colors, custom class has to be imported
    //[[JumioPositiveButton jumioAppearance] setBorderColor: [UIColor greenColor]];
    
    // Color for the face oval outline
    //[[JumioScanOverlayView jumioAppearance] setFaceOvalColor: [UIColor orangeColor]];
    // Color for the progress bars
    //[[JumioScanOverlayView jumioAppearance] setFaceProgressColor: [UIColor purpleColor]];
    // Color for the background of the feedback view
    //[[JumioScanOverlayView jumioAppearance] setFaceFeedbackBackgroundColor: [UIColor yellowColor]];
    // Color for the text of the feedback view
    //[[JumioScanOverlayView jumioAppearance] setFaceFeedbackTextColor: [UIColor brownColor]];
    
    // - Custom general appearance - font
    //The font has to be loaded upfront within the mainBundle before initializing the SDK
    //[[JumioBaseView jumioAppearance] setCustomLightFontName: @"<your-font-name-loaded-in-your-app>"];
    //[[JumioBaseView jumioAppearance] setCustomRegularFontName: @"<your-font-name-loaded-in-your-app>"];
    //[[JumioBaseView jumioAppearance] setCustomMediumFontName: @"<your-font-name-loaded-in-your-app>"];
    //[[JumioBaseView jumioAppearance] setCustomBoldFontName: @"<your-font-name-loaded-in-your-app>"];
    //[[JumioBaseView jumioAppearance] setCustomItalicFontName: @"<your-font-name-loaded-in-your-app>"];
    
    //You can get the current SDK version using the method below.
    //NSLog(@"%@", [AuthenticationController sdkVersion]);
    
    return config;
}

- (IBAction)startAuthentication {
    [self createAuthenticationController];
}

/**
 * Implement the following delegate method to receive the scanViewController to present, after initialization was finished successfully.
 * @param authenticationController the AuthenticationController instance
 * @param scanViewController UIViewController object to present
 **/
- (void)authenticationController:(nonnull AuthenticationController *)authenticationController didFinishInitializingScanViewController:(nonnull UIViewController *)scanViewController {
    NSLog(@"AuthenticationController did finish initializing");
    self.authenticationScanViewController = scanViewController;
    [self presentViewController:self.authenticationScanViewController animated:YES completion:nil];
}

/**
 * Implement the following delegate method to receive the final AuthenticationResult.
 * Dismiss the SDK view in your app once you received the result.
 * @param authenticationController the AuthenticationController instance
 * @param authenticationResult contains final authentication result (success or failed)
 * @param transactionReference the unique identifier of the scan session
 **/
- (void)authenticationController:(nonnull AuthenticationController *)authenticationController didFinishWithAuthenticationResult:(AuthenticationResult)authenticationResult transactionReference:(nonnull NSString *)transactionReference {
    NSLog(@"AuthenticationController finished successfully with transaction reference: %@", transactionReference);
    
    NSString *message;
    switch (authenticationResult) {
        case AuthenticationResultSuccess:
            message = @"Authentication process was successful";
            break;
        case AuthenticationResultFailed:
        default:
            message = @"Authentication process failed";
            break;
    }
    
    //Dismiss the SDK
    [self.authenticationScanViewController dismissViewControllerAnimated:YES completion:^{
        NSLog(@"%@", message);
        [self showAlertWithTitle:@"Authentication Mobile SDK" message:message];
        
        //Destroy the instance to properly clean up the SDK
        [self.authenticationController destroy];
        self.authenticationController = nil;
    }];
}

/**
 * Implement the following delegate method for successful scans and user cancellation notifications.
 * Dismiss the SDK view in your app once you received the result.
 * @param authenticationController the AuthenticationController instance
 * @param error holds more detailed information about the error reason
 * @param transactionReference the unique identifier of the scan session
 **/
- (void)authenticationController:(nonnull AuthenticationController *)authenticationController didFinishWithError:(nonnull AuthenticationError *)error transactionReference:(NSString * _Nullable)transactionReference {
    NSString *message = [NSString stringWithFormat:@"AuthenticationController finished with error: %@, transactionReference: %@", error.message, transactionReference];
    
    //Dismiss the SDK
    void (^errorCompletion)(void) = ^{
        
        //handle the error cases as highlighted in our documentation: https://github.com/Jumio/mobile-sdk-ios/blob/master/docs/integration_faq.md#managing-errors
        
        NSLog(@"%@", message);
        [self showAlertWithTitle:@"Authentication Mobile SDK" message:message];
        
        //Destroy the instance to properly clean up the SDK
        [self.authenticationController destroy];
        self.authenticationController = nil;
    };
    
    if (self.authenticationScanViewController) {
        [self.authenticationScanViewController dismissViewControllerAnimated:YES completion:errorCompletion];
    } else {
        errorCompletion();
    }
}

//Helper methods
- (IBAction)transactionRefernece_onDone {
    [self.view endEditing:YES];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}
    
@end
