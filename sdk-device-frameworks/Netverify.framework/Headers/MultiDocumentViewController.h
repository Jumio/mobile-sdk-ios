//
//  MultiDocumentViewController.h
//
//  Copyright © 2016 Jumio Corporation All rights reserved.
//

#import <JumioCore/JMNavigationController.h>
#import <JumioCore/JMSDK.h>

#pragma mark - MultiDocumentConfiguration
@protocol MultiDocumentViewControllerDelegate;

@interface MultiDocumentConfiguration : NSObject<NSCopying>
@property (nonatomic, strong) NSString* merchantApiToken;               // The API token of your Jumio merchant account
@property (nonatomic, strong) NSString* merchantApiSecret;              // The corresponding API secret
@property (nonatomic, assign) JumioDataCenter dataCenter;               // Specifiy the DataCenter that should be used
@property (nonatomic, strong) NSString* type;                           // Type of the document
@property (nonatomic, strong) NSString* country;                        // Specify a country the (format: ISO 3166-1 Alpha 3 code)
@property (nonatomic, strong) NSString* merchantScanReference;          // Identify the scan in the Jumio merchant UI. (Maximum characters: 100)

@property (nonatomic, weak) id<MultiDocumentViewControllerDelegate> delegate;  // A delegate implementing the MultiDocumentViewControllerDelegate protocol

@property (nonatomic, strong) NSString* customerId;                     // Specifies how the user is registered on your system. For example, you can use an email address, user name, or account number. Optional. (Maximum characters: 100)
@property (nonatomic, strong) NSString *callbackUrl;                    // Callback URL (max. 255 characters) for the confirmation after the verification is completed.
@property (nonatomic, strong) NSString *additionalInformation;          // Optional field (max. 255 characters) for filters in Merchantreports
@property (nonatomic, strong) NSString* merchantReportingCriteria;      // Criteria for filtering in Merchant reports (Maximum characters: 255)
@property (nonatomic, strong) NSString* customDocumentCode;             // Criteria for filtering in Merchant reports (Maximum characters: 255)
@property (nonatomic, assign) JumioCameraPosition cameraPosition;       // One of the Custom Document Type Codes as configurable the in Merchant UI.
@property (nonatomic, strong) NSString* documentName;                   // Overrides the label for the document name

@property (nonatomic, assign) UIStatusBarStyle statusBarStyle;          // Configure the status bar style for the duration MultiDocumentViewController is presented

@end

#pragma mark - MultiDocumentViewController

@class MultiDocumentViewController;

@protocol MultiDocumentViewControllerDelegate <NSObject>

@required
- (void) multiDocumentViewController:(MultiDocumentViewController*) multiDocumentViewController didFinishWithScanReference:(NSString*)scanReference;
- (void) multiDocumentViewController:(MultiDocumentViewController*) multiDocumentViewController didFinishWithError:(NSError*)error;

@end

@interface MultiDocumentViewController : JMNavigationController

- (instancetype)initWithConfiguration:(MultiDocumentConfiguration*)configuration;

- (NSString*) sdkVersion;

@end
