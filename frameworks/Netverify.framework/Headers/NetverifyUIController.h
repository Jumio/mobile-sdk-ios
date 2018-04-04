//
//  NetverifyUIController.h
//
//  Copyright © 2018 Jumio Corporation. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <Netverify/NetverifyConfiguration.h>

@class NetverifyDocument;

/**
 * @class NetverifyUIController
 * @brief Main controller that defines the workflow of Fastfill and Netverify.
 **/
__attribute__((visibility("default"))) @interface NetverifyUIController : NSObject

/**
 * Create an instance of the Netverify SDK.
 * @param configuration is used for the current instance
 * @return NetverifyUIController instance
 * @throws an NSException if NetverifyConfiguration is not configured correctly. Please note that in Swift you need to catch the underlaying exception and translate it into NSError. Please check out our sample project if you need more information.
 **/
- (instancetype _Nonnull) initWithConfiguration:(NetverifyConfiguration* _Nonnull)configuration;

/**
 * Use this method to setup the NetverifyUIController correctly before any scan view controller will be provided.
 * @param document selected for scanning after provided via netverifyUIController:didDetermineAvailableCountries:suggestedCountry: delegate method. (please note that in case paperDocument should be used selectedVariant has to be set prior calling this method)
 **/
- (void) setupWithDocument:(NetverifyDocument* _Nonnull)document;

/**
 * Call the cancel method anytime in the workflow to abort the netverifyUIController process.
 * Dismissing a currently active NetverifyCustomScanViewController has to be done in the client application.
 * After calling cancel NetverifyUIController object has to be newly created.
 **/
- (void) cancel;

/**
 * Call this method in case an error was received in netverifyUIController:didDetermineError:retryPossible:
 * Calling this method only makes sense if retryPossible: is positive
 **/
- (void) retryAfterError;

/**
 * @return the Netverify SDK version.
 **/
- (NSString* _Nonnull) sdkVersion;

/**
 * @return a sessionID if sendDebugInfoToJumio is set to YES.
 **/
- (NSUUID* _Nullable) debugID;

@end
