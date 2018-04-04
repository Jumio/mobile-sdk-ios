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

__attribute__((visibility("default"))) @interface DocumentVerificationConfiguration : NSObject<NSCopying>
@property (nonatomic, strong, nonnull) NSString* merchantApiToken;               // The API token of your Jumio merchant account
@property (nonatomic, strong, nonnull) NSString* merchantApiSecret;              // The corresponding API secret
@property (nonatomic, assign) JumioDataCenter dataCenter;               // Specifiy the DataCenter that should be used
@property (nonatomic, strong, nonnull) NSString* type;                           // Type of the document
@property (nonatomic, strong, nonnull) NSString* country;                        // Specify a country the (format: ISO 3166-1 Alpha 3 code)
@property (nonatomic, strong, nonnull) NSString* merchantScanReference;          // Identify the scan in the Jumio merchant UI. (Maximum characters: 100)

@property (nonatomic, weak, nullable) id<DocumentVerificationViewControllerDelegate> delegate;  // A delegate implementing the DocumentVerificationViewControllerDelegate protocol

@property (nonatomic, strong, nonnull) NSString* customerId;                     // Specifies how the user is registered on your system. For example, you can use an email address, user name, or account number. Optional. (Maximum characters: 100)
@property (nonatomic, strong, nullable) NSString *callbackUrl;                    // Callback URL (max. 255 characters) for the confirmation after the verification is completed.
@property (nonatomic, strong, nullable) NSString *additionalInformation;          // Optional field (max. 255 characters) for filters in Merchantreports
@property (nonatomic, strong, nullable) NSString* merchantReportingCriteria;      // Criteria for filtering in Merchant reports (Maximum characters: 255)
@property (nonatomic, strong, nullable) NSString* customDocumentCode;             // Criteria for filtering in Merchant reports (Maximum characters: 255)
@property (nonatomic, assign) JumioCameraPosition cameraPosition;       // One of the Custom Document Type Codes as configurable the in Merchant UI.
@property (nonatomic, strong, nullable) NSString* documentName;                   // Overrides the label for the document name

@property (nonatomic, assign) UIStatusBarStyle statusBarStyle;          // Configure the status bar style for the duration DocumentVerificationViewController is presented

@end

#pragma mark - DocumentVerificationViewController

@class DocumentVerificationViewController;

__attribute__((visibility("default"))) @protocol DocumentVerificationViewControllerDelegate <NSObject>

@required
- (void) documentVerificationViewController:(DocumentVerificationViewController* _Nonnull) documentVerificationViewController didFinishWithScanReference:(NSString* _Nullable)scanReference;
- (void) documentVerificationViewController:(DocumentVerificationViewController* _Nonnull) documentVerificationViewController didFinishWithError:(DocumentVerificationError* _Nullable)error;

@end

__attribute__((visibility("default"))) @interface DocumentVerificationViewController : JMNavigationController

/** Create an instance of DocumentVerificationViewController.
 @param configuration The configuration that is used for the current instance
 @return An initialized DocumentVerificationViewController instance
 @throws an NSException if DocumentVerificationConfiguration is not configured correctly. Please note that in Swift you need to catch the underlaying exception and translate it into NSError. Please check out our sample project if you need more information. */

- (instancetype _Nonnull)initWithConfiguration:(DocumentVerificationConfiguration* _Nonnull)configuration;

- (NSString* _Nonnull) sdkVersion;

@end
