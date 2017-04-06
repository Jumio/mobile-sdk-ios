//
//  NetswipeViewController.h
//
//  Copyright © 2016 Jumio Corporation All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NetswipeCardInformation.h"
#import "NetswipeCustomScanOverlayViewController.h"
#import <JumioCore/JumioCore.h>

@class NetswipeViewController;

@protocol NetswipeAppearance <NSObject>

+ (instancetype)netswipeAppearance;

@end

@protocol NetswipeViewControllerDelegate <NSObject>

- (void) netswipeViewController: (NetswipeViewController *) controller didCancelWithError:(NSError *) error scanReference:(NSString *) scanReference;
- (void) netswipeViewController:(NetswipeViewController *) controller didFinishScanWithCardInformation: (NetswipeCardInformation *)cardInformation scanReference:(NSString *) scanReference;

@optional
- (void) netswipeViewController:(NetswipeViewController *) controller didStartScanAttemptWithScanReference:(NSString *) scanReference;

@end

/**
 @class NetswipeConfiguration
 @brief Handle configuration of the Netswipe Mobile SDK.
 */
@interface NetswipeConfiguration : NSObject

@property (nonatomic, weak) id<NetswipeViewControllerDelegate> delegate;

@property (nonatomic, strong) NSString* merchantApiToken;                   // The API token of your Jumio merchant account
@property (nonatomic, strong) NSString* merchantApiSecret;                  // The corresponding API secret
@property (nonatomic, strong) NSString* merchantReportingCriteria;          // Identify the scan in your reports. Set it to nil if you don't use it. (Maximum characters: 100)

@property (nonatomic, assign) JumioDataCenter dataCenter;                   // Specifiy the DataCenter that should be used

@property (nonatomic, strong) NSString* offlineToken;                       // Set this token to use the SDK offline

@property (nonatomic, strong) NetswipeCustomScanOverlayViewController *customOverlay;  // Set the optional implementation of a custom overlay view controller

@property (nonatomic, assign) NetswipeCreditCardTypes supportedCreditCardTypes;  // Specify which card types your app supports by combining NetswipeCreditCardType constants using the C bitwise OR operator
@property (nonatomic, assign) BOOL expiryRequired;                          // Enable scanning of expiry date (default: YES)
@property (nonatomic, assign) BOOL expiryEditable;                          // Set the expiry field editable (default: NO)
@property (nonatomic, assign) BOOL cvvRequired;                             // Require cvv input by the user (default: YES)
@property (nonatomic, assign) BOOL cardNumberMaskingEnabled;                // The card number is displayed masked on every view (default: YES)

@property (nonatomic, assign) BOOL cardHolderNameRequired;                  // Enable scanning of card holder name (default: YES)
@property (nonatomic, assign) BOOL cardHolderNameEditable;                  // User may edit the scanned card holder name (default: NO)
@property (nonatomic, assign) BOOL sortCodeAndAccountNumberRequired;        // Enable scanning of sort code and account number (default: NO)

@property (nonatomic, assign) BOOL vibrationEffectEnabled;                  // The device will vibrate shortly if a card is detected.
@property (nonatomic, strong) NSString* soundEffect;                        // Set the file name to a sound file to give a short audio feedback to the user when the card is detected.
@property (nonatomic, assign) BOOL enableFlashOnScanStart;                  // Automatically enable flash when scan is started
@property (nonatomic, assign) JumioCameraPosition cameraPosition;           // Set the default camera position
@property (nonatomic, strong) NSString* adyenPublicKey;                     // Use the following method to provide the Adyen Public Key. This activates the generation of an encrypted Adyen payment data object.

@property (nonatomic, assign) UIStatusBarStyle statusBarStyle;              // Configure the status bar style for the duration NetswipeViewController is presented

/** Custom fields the user is asked to fill in to finish a scan. Retrievable via the fieldId in NetswipeCardInformation.
 @param fieldId Unique ID of your field
 @param title Label text describing the field
 @param keyboardType Configure a keyboard type for input
 @param regex Validate field input with a regular expression */
- (void) addCustomField: (NSString*) fieldId title: (NSString*) title keyboardType: (UIKeyboardType) keyboardType regularExpression: (NSString*) regex;

/** Custom fields the user is asked to fill in to finish a scan. Retrievable via the fieldId in NetswipeCardInformation.
 @param fieldId Unique ID of your field
 @param title Label text describing the field
 @param values An array from which the user can select one value
 @param required If YES it cannot be nil. resetValueText will not available
 @param resetValueText value within the UIPickerView that resets the value to nil */
- (void) addCustomField: (NSString*) fieldId title: (NSString*) title values: (NSArray*) values required: (BOOL) required resetValueText: (NSString *) resetValueText;

@end

/**
 @class NetswipeViewController
 @brief Handle setup and presentation of the Netswipe Mobile SDK.
 */
@interface NetswipeViewController : JMNavigationController

/** Create an instance of NetswipeViewController.
 @param configuration The configuration that is used for the current instance
 @return An initialized NetswipeViewController instance
 */
- (id) initWithConfiguration:(NetswipeConfiguration *)configuration;

/** Update the Configuration of the Netswipe SDK.
 The configuration can only be updated when the NetswipeViewController is dismissed and not visible.
 @param configuration The configuration that is used for the current instance
 @return YES if configuration was updated successfully
 */
- (BOOL) updateConfiguration:(NetswipeConfiguration *)configuration;

/** Returns the Netswipe Mobile SDK version. */
- (NSString*) sdkVersion;

@end
