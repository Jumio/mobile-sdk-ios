//
//  NetverifyConfiguration.h
//
//  Copyright © 2018 Jumio Corporation. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Netverify/NetverifyDocumentData.h>
#import <Netverify/NetverifyProtocol.h>
#import <JumioCore/JMSDK.h>

/**
 * Netverify Settings class that is used to configure all available functional settings of NetverifyViewController or NetverifyUIController.
 **/
__attribute__((visibility("default"))) @interface NetverifyConfiguration : NSObject <NSCopying>

/**
 * The API token of your Jumio merchant account
 **/
@property (nonatomic, strong, nonnull) NSString* merchantApiToken;

/**
 * The corresponding API secret
 **/
@property (nonatomic, strong, nonnull) NSString* merchantApiSecret;

/**
 * Identify the scan in the Jumio merchant UI. (Maximum characters: 100)
 **/
@property (nonatomic, strong, nullable) NSString* merchantScanReference;

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
 * A delegate implementing the NetverifyViewControllerDelegate protocol
 **/
@property (nonatomic, weak, nullable) id<NetverifyViewControllerDelegate> delegate;

/**
 * A delegate implementing the NetverifyUIControllerDelegate protocol. Only use this when using Custom UI.
 **/
@property (nonatomic, weak, nullable) id<NetverifyUIControllerDelegate> customUIDelegate;

/**
 * Specify a country to skip selection by the user (format: ISO 3166-1 Alpha 3 code)
 **/
@property (nonatomic, strong, nullable) NSString* preselectedCountry;

/**
 * Preselect selection to one or more documentTypes to restrict or skip selection by the user
 **/
@property (nonatomic, assign) NetverifyDocumentType preselectedDocumentTypes;

/**
 * Specify a document variant to skip selection by the user
 **/
@property (nonatomic, assign) NetverifyDocumentVariant preselectedDocumentVariant;

/**
 * Enable a face match check between a camera still image and the document front side (default: YES)
 **/
@property (nonatomic, assign) BOOL requireFaceMatch;

/**
 * Enable verification of a scanned identity (default: YES)
 **/
@property (nonatomic, assign) BOOL requireVerification;

/**
 * Specifies how the user is registered on your system. For example, you can use an email address, user name, or account number. Optional. (Maximum characters: 100)
 **/
@property (nonatomic, strong, nullable) NSString* customerId;

/**
 * Set the default camera position
 **/
@property (nonatomic, assign) JumioCameraPosition cameraPosition;

/**
 * Callback URL (max. 255 characters) for the confirmation after the verification is completed.
 * This setting overrides your Jumio merchant settings.
 **/
@property (nonatomic, strong, nullable) NSString *callbackUrl;

/**
 * Use the following method to only support IDs where data can be extracted on mobile only
 **/
@property (nonatomic, assign) BOOL dataExtractionOnMobileOnly;

/**
 * Use the following method to explicitly send debug-info to Jumio. (default: NO)
 * Only set this property to YES if you are asked by our Jumio support personal.
 **/
@property (nonatomic, assign) BOOL sendDebugInfoToJumio;

/**
 * Configure the status bar style for the duration NetverifyViewController is presented
 **/
@property (nonatomic, assign) UIStatusBarStyle statusBarStyle;

@end
