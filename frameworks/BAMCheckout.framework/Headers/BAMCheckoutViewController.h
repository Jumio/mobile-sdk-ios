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

__attribute__((visibility("default"))) @protocol BAMCheckoutAppearance <NSObject>

+ (instancetype _Nonnull)bamCheckoutAppearance;

@end

__attribute__((visibility("default"))) @protocol BAMCheckoutViewControllerDelegate <NSObject>

- (void) bamCheckoutViewController: (BAMCheckoutViewController * _Nonnull) controller didCancelWithError:(NSError * _Nullable) error scanReference:(NSString * _Nullable) scanReference;
- (void) bamCheckoutViewController:(BAMCheckoutViewController * _Nonnull) controller didFinishScanWithCardInformation: (BAMCheckoutCardInformation * _Nonnull)cardInformation scanReference:(NSString * _Nonnull) scanReference;

@optional
- (void) bamCheckoutViewController:(BAMCheckoutViewController * _Nonnull) controller didStartScanAttemptWithScanReference:(NSString * _Nonnull) scanReference;

@end

/**
 @class BAMCheckoutConfiguration
 @brief Handle configuration of the BAMCheckout Mobile SDK.
 */
__attribute__((visibility("default"))) @interface BAMCheckoutConfiguration : NSObject

@property (nonatomic, weak, nullable) id<BAMCheckoutViewControllerDelegate> delegate;

@property (nonatomic, strong, nonnull) NSString* merchantApiToken;                   // The API token of your Jumio merchant account
@property (nonatomic, strong, nonnull) NSString* merchantApiSecret;                  // The corresponding API secret
@property (nonatomic, strong, nullable) NSString* merchantReportingCriteria;          // Identify the scan in your reports. Set it to nil if you don't use it. (Maximum characters: 100)

@property (nonatomic, assign) JumioDataCenter dataCenter;                   // Specifiy the DataCenter that should be used

@property (nonatomic, strong, nullable) NSString* offlineToken;                       // Set this token to use the SDK offline

@property (nonatomic, strong, nullable) BAMCheckoutCustomScanOverlayViewController *customOverlay;  // Set the optional implementation of a custom overlay view controller

@property (nonatomic, assign) BAMCheckoutCreditCardTypes supportedCreditCardTypes;  // Specify which card types your app supports by combining BAMCheckoutCreditCardType constants using the C bitwise OR operator
@property (nonatomic, assign) BOOL expiryRequired;                          // Enable scanning of expiry date (default: YES)
@property (nonatomic, assign) BOOL expiryEditable;                          // Set the expiry field editable (default: NO)
@property (nonatomic, assign) BOOL cvvRequired;                             // Require cvv input by the user (default: YES)
@property (nonatomic, assign) BOOL cardNumberMaskingEnabled;                // The card number is displayed masked on every view (default: YES)

@property (nonatomic, assign) BOOL cardHolderNameRequired;                  // Enable scanning of card holder name (default: YES)
@property (nonatomic, assign) BOOL cardHolderNameEditable;                  // User may edit the scanned card holder name (default: NO)
@property (nonatomic, assign) BOOL sortCodeAndAccountNumberRequired;        // Enable scanning of sort code and account number (default: NO)

@property (nonatomic, assign) BOOL vibrationEffectEnabled;                  // The device will vibrate shortly if a card is detected.
@property (nonatomic, strong, nullable) NSString* soundEffect;                        // Set the file name to a sound file to give a short audio feedback to the user when the card is detected.
@property (nonatomic, assign) BOOL enableFlashOnScanStart;                  // Automatically enable flash when scan is started
@property (nonatomic, assign) JumioCameraPosition cameraPosition;           // Set the default camera position

@property (nonatomic, assign) UIStatusBarStyle statusBarStyle;              // Configure the status bar style for the duration BAMCheckoutViewController is presented

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
 @class BAMCheckoutViewController
 @brief Handle setup and presentation of the BAMCheckout Mobile SDK.
 */
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
