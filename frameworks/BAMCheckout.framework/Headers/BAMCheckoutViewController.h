//
//  BAMCheckoutViewController.h
//
//  Copyright © 2018 Jumio Corporation. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BAMCheckoutCardInformation.h"
#import "BAMCheckoutCustomScanOverlayViewController.h"
#import <JumioCore/JumioCore.h>

@class BAMCheckoutViewController;

/**
 * Protocol that is used for all BAMCheckout UI Objects to be customized via UIAppearance
 */
__attribute__((visibility("default"))) @protocol BAMCheckoutAppearance <NSObject>

/**
 * @return the instance of the class for UIAppearance
 **/
+ (instancetype _Nonnull)bamCheckoutAppearance;

@end

/**
 * Protocol that has to be implemented when using BAMCheckoutViewController
 **/
__attribute__((visibility("default"))) @protocol BAMCheckoutViewControllerDelegate <NSObject>

/**
 * Called when the SDK canceled.
 * @param controller the controller instance
 * @param error NSObject holds more detailed information about the error reason
 * @param scanReference the unique identifier of the scan session
 **/
- (void) bamCheckoutViewController: (BAMCheckoutViewController * _Nonnull) controller didCancelWithError:(NSError * _Nullable) error scanReference:(NSString * _Nullable) scanReference;
/**
 * Called when the SDK finished with success.
 * @param controller the controller instance
 * @param cardInformation data containing the extracted information
 * @param scanReference the unique identifier of the scan session
 **/
- (void) bamCheckoutViewController:(BAMCheckoutViewController * _Nonnull) controller didFinishScanWithCardInformation: (BAMCheckoutCardInformation * _Nonnull)cardInformation scanReference:(NSString * _Nonnull) scanReference;

@optional
/**
 * Called when the SDK is loaded and a scanReference is already present.
 * @param controller the controller instance
 * @param scanReference the unique identifier of the scan session
 **/
- (void) bamCheckoutViewController:(BAMCheckoutViewController * _Nonnull) controller didStartScanAttemptWithScanReference:(NSString * _Nonnull) scanReference;

@end

/**
 * Handle configuration of the BAMCheckout Mobile SDK.
 */
__attribute__((visibility("default"))) @interface BAMCheckoutConfiguration : NSObject

/**
 * A delegate implementing the BAMCheckoutViewControllerDelegate protocol
 **/
@property (nonatomic, weak, nullable) id<BAMCheckoutViewControllerDelegate> delegate;

/**
 *  The API token of your Jumio merchant account
 **/
@property (nonatomic, strong, nonnull) NSString* merchantApiToken;

/**
 * The corresponding API secret
 **/
@property (nonatomic, strong, nonnull) NSString* merchantApiSecret;

/**
 * Identify the scan in your reports. Set it to nil if you don't use it. (Maximum characters: 100)
 **/
@property (nonatomic, strong, nullable) NSString* merchantReportingCriteria;

/**
 * Specifiy the DataCenter that should be used
 **/
@property (nonatomic, assign) JumioDataCenter dataCenter;

/**
 * Set this token to use the SDK offline
 **/
@property (nonatomic, strong, nullable) NSString* offlineToken;

/**
 * Set the optional implementation of a custom overlay view controller
 **/
@property (nonatomic, strong, nullable) BAMCheckoutCustomScanOverlayViewController *customOverlay;

/**
 * Specify which card types your app supports by combining BAMCheckoutCreditCardType constants using the C bitwise OR operator
 **/
@property (nonatomic, assign) BAMCheckoutCreditCardTypes supportedCreditCardTypes;

/**
 * Enable scanning of expiry date (default: YES)
 **/
@property (nonatomic, assign) BOOL expiryRequired;

/**
 * Set the expiry field editable (default: NO)
 **/
@property (nonatomic, assign) BOOL expiryEditable;

/**
 * Require cvv input by the user (default: YES)
 **/
@property (nonatomic, assign) BOOL cvvRequired;

/**
 * The card number is displayed masked on every view (default: YES)
 **/
@property (nonatomic, assign) BOOL cardNumberMaskingEnabled;

/**
 * Enable scanning of card holder name (default: YES)
 **/
@property (nonatomic, assign) BOOL cardHolderNameRequired;

/**
 * User may edit the scanned card holder name (default: NO)
 **/
@property (nonatomic, assign) BOOL cardHolderNameEditable;

/**
 * Enable scanning of sort code and account number (default: NO)
 **/
@property (nonatomic, assign) BOOL sortCodeAndAccountNumberRequired;

/**
 * The device will vibrate shortly if a card is detected.
 **/
@property (nonatomic, assign) BOOL vibrationEffectEnabled;

/**
 * Set the file name to a sound file to give a short audio feedback to the user when the card is detected.
 **/
@property (nonatomic, strong, nullable) NSString* soundEffect;

/**
 * Automatically enable flash when scan is started
 **/
@property (nonatomic, assign) BOOL enableFlashOnScanStart;

/**
 * Set the default camera position
 **/
@property (nonatomic, assign) JumioCameraPosition cameraPosition;

/**
 * Configure the status bar style for the duration BAMCheckoutViewController is presented
 **/
@property (nonatomic, assign) UIStatusBarStyle statusBarStyle;

/** Custom fields the user is asked to fill in to finish a scan. Retrievable via the fieldId in BAMCheckoutCardInformation.
 @param fieldId Unique ID of your field
 @param title Label text describing the field
 @param keyboardType Configure a keyboard type for input
 @param regex Validate field input with a regular expression */
- (void) addCustomField: (NSString* _Nonnull) fieldId title: (NSString* _Nonnull) title keyboardType: (UIKeyboardType) keyboardType regularExpression: (NSString* _Nonnull) regex;

/** Custom fields the user is asked to fill in to finish a scan. Retrievable via the fieldId in BAMCheckoutCardInformation.
 @param fieldId Unique ID of your field
 @param title Label text describing the field
 @param values An array from which the user can select one value
 @param required If YES it cannot be nil. resetValueText will not available
 @param resetValueText value within the UIPickerView that resets the value to nil */
- (void) addCustomField: (NSString* _Nonnull) fieldId title: (NSString* _Nonnull) title values: (NSArray* _Nonnull) values required: (BOOL) required resetValueText: (NSString * _Nonnull) resetValueText;

@end

/**
 * Handle setup and presentation of the BAMCheckout Mobile SDK.
 **/
__attribute__((visibility("default"))) @interface BAMCheckoutViewController : JMNavigationController

/** Create an instance of BAMCheckoutViewController.
 @param configuration The configuration that is used for the current instance
 @return An initialized BAMCheckoutViewController instance
 @throws an NSException if BAMCheckoutConfiguration is not configured correctly. Please note that in Swift you need to catch the underlaying exception and translate it into NSError. Please check out our sample project if you need more information. */
- (instancetype _Nonnull) initWithConfiguration:(BAMCheckoutConfiguration * _Nonnull)configuration;

/** Update the Configuration of the BAMCheckout SDK.
 The configuration can only be updated when the BAMCheckoutViewController is dismissed and not visible.
 @param configuration The configuration that is used for the current instance
 @return YES if configuration was updated successfully
 @throws an NSException if BAMCheckoutConfiguration is not configured correctly. Please note that in Swift you need to catch the underlaying exception and translate it into NSError. Please check out our sample project if you need more information. */
- (BOOL) updateConfiguration:(BAMCheckoutConfiguration * _Nonnull)configuration;

/** Returns the BAMCheckout Mobile SDK version. */
- (NSString* _Nonnull) sdkVersion;

@end
