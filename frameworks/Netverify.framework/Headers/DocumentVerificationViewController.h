//
//  DocumentVerificationViewController.h
//
//  Copyright © 2018 Jumio Corporation. All rights reserved.
//

#import <JumioCore/JMNavigationController.h>
#import <JumioCore/JMSDK.h>

@class DocumentVerificationError;

#pragma mark - DocumentVerificationConfiguration
__attribute__((visibility("default"))) @protocol DocumentVerificationViewControllerDelegate;

/**
 * Document Verification Settings class that is used to configure all available functional settings of DocumentVerificationViewController.
 **/
__attribute__((visibility("default"))) @interface DocumentVerificationConfiguration : NSObject<NSCopying>

/**
 * The API token of your Jumio merchant account
 **/
@property (nonatomic, strong, nonnull) NSString* merchantApiToken;

/**
 * The corresponding API secret
 **/
@property (nonatomic, strong, nonnull) NSString* merchantApiSecret;

/**
 * Specifiy the DataCenter that should be used
 **/
@property (nonatomic, assign) JumioDataCenter dataCenter;

/**
 * Type of the document
 **/
@property (nonatomic, strong, nonnull) NSString* type;

/**
 * Specify a country the (format: ISO 3166-1 Alpha 3 code)
 **/
@property (nonatomic, strong, nonnull) NSString* country;

/**
 * Identify the scan in the Jumio merchant UI. (Maximum characters: 100)
 **/
@property (nonatomic, strong, nonnull) NSString* merchantScanReference;

/**
 * A delegate implementing the DocumentVerificationViewControllerDelegate protocol
 **/
@property (nonatomic, weak, nullable) id<DocumentVerificationViewControllerDelegate> delegate;

/**
 * Specifies how the user is registered on your system. For example, you can use an email address, user name, or account number. Optional. (Maximum characters: 100)
 **/
@property (nonatomic, strong, nonnull) NSString* customerId;

/**
 * Callback URL (max. 255 characters) for the confirmation after the verification is completed.
 **/
@property (nonatomic, strong, nullable) NSString *callbackUrl;

/**
 * Criteria for filtering in Merchant reports (Maximum characters: 255)
 **/
@property (nonatomic, strong, nullable) NSString* merchantReportingCriteria;

/**
 * Criteria for filtering in Merchant reports (Maximum characters: 255)
 **/
@property (nonatomic, strong, nullable) NSString* customDocumentCode;

/**
 * One of the Custom Document Type Codes as configurable the in Merchant UI.
 **/
@property (nonatomic, assign) JumioCameraPosition cameraPosition;

/**
 * Overrides the label for the document name
 **/
@property (nonatomic, strong, nullable) NSString* documentName;

/**
 * Enable/disable data extraction for documents (default: YES)
 **/
@property (nonatomic, assign) BOOL enableExtraction;

/**
 * Configure the status bar style for the duration DocumentVerificationViewController is presented
 **/
@property (nonatomic, assign) UIStatusBarStyle statusBarStyle;

@end

#pragma mark - DocumentVerificationViewController

@class DocumentVerificationViewController;

/**
 * Protocol that has to be implemented when using DocumentVerificationViewController
 **/
__attribute__((visibility("default"))) @protocol DocumentVerificationViewControllerDelegate <NSObject>

@required
/**
 * Called when the SDK finished with success.
 * @param documentVerificationViewController the controller instance
 * @param scanReference the unique identifier of the scan session
 **/
- (void) documentVerificationViewController:(DocumentVerificationViewController* _Nonnull) documentVerificationViewController didFinishWithScanReference:(NSString* _Nullable)scanReference;

/**
 * Called when the SDK finished with error.
 * @param documentVerificationViewController the controller instance
 * @param error holds more detailed information about the error reason
 **/
- (void) documentVerificationViewController:(DocumentVerificationViewController* _Nonnull) documentVerificationViewController didFinishWithError:(DocumentVerificationError* _Nonnull)error;


@end


/**
 * Handles setup and presentation of the DocumentVerification Mobile SDK.
 */
__attribute__((visibility("default"))) @interface DocumentVerificationViewController : JMNavigationController

/** Create an instance of DocumentVerificationViewController.
 @param configuration The configuration that is used for the current instance
 @return An initialized DocumentVerificationViewController instance
 @throws an NSException if DocumentVerificationConfiguration is not configured correctly. Please note that in Swift you need to catch the underlaying exception and translate it into NSError. Please check out our sample project if you need more information. */
- (instancetype _Nonnull)initWithConfiguration:(DocumentVerificationConfiguration* _Nonnull)configuration;

/**
 * @return the DocumentVerification SDK version.
 */
- (NSString* _Nonnull) sdkVersion;

@end
