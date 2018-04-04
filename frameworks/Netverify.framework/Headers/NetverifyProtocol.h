//
//  NetverifyProtocol.h
//
//  Copyright © 2018 Jumio Corporation. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NetverifyViewController;
@class NetverifyDocumentData;
@class NetverifyError;
@class NetverifyUIController;
@class NetverifyCountry;
@class NetverifyCustomScanViewController;

__attribute__((visibility("default"))) @protocol NetverifyViewControllerDelegate <NSObject>
@optional
/**
 * Called when the SDK and all resources are loaded. Error will be null in case of success.
 * @param netverifyViewController the controller instance
 * @param error holds more detailed information about the error reason
 **/
- (void) netverifyViewController: (NetverifyViewController* _Nonnull) netverifyViewController didFinishInitializingWithError:(NetverifyError* _Nullable)error;

@required
/**
 * Called when the SDK finished with success.
 * @param netverifyViewController the controller instance
 * @param documentData data containing the extracted information
 * @param scanReference the unique identifier of the scan session
 **/
- (void) netverifyViewController: (NetverifyViewController* _Nonnull) netverifyViewController didFinishWithDocumentData:(NetverifyDocumentData * _Nonnull)documentData scanReference: (NSString* _Nonnull) scanReference;

/**
 * Called when the SDK canceled.
 * @param netverifyViewController the controller instance
 * @param error NSObject holds more detailed information about the error reason
 * @param scanReference the unique identifier of the scan session
 **/
- (void) netverifyViewController: (NetverifyViewController* _Nonnull) netverifyViewController didCancelWithError: (NetverifyError* _Nullable) error scanReference: (NSString* _Nullable) scanReference;

@end


__attribute__((visibility("default"))) @protocol NetverifyUIControllerDelegate <NSObject>
@required

 /**
 * Called when the SDK and all resources are loaded. Error will be null in case of success. Always before netverifyUIController:didDetermineAvailableCountries:suggestedCountry:
 * @param netverifyViewController the controller instance
 * @param error holds more detailed information about the error reason
 **/
- (void) netverifyUIController: (NetverifyUIController* _Nonnull) netverifyUIController didFinishInitializingWithError:(NetverifyError* _Nullable)error;

/**
 * Called as soon as the SDK is set up and the required information is loaded and provides the available countries and document types. Only the valid NetverifyCountries and NetverifyDocuments which validate with the settings used in the NetverifyConfiguration will be provided here.
 * @param netverifyUIController the controller instance
 * @param countries array with NetverifyCountry objects
 * @param country is the suggested country object based on phone localization.
 **/
- (void) netverifyUIController: (NetverifyUIController* _Nonnull) netverifyUIController didDetermineAvailableCountries:(NSArray * _Nonnull)countries suggestedCountry:(NetverifyCountry * _Nullable)country;

/**
 * After setupWithDocument: is called on NetverifyUIController the scan view controller for the required scan side will be provided. While the order of the scan view controllers (Front, Back, Face) is predefined only the required ones will return in this method. The NetverifyCustomScanViewController should be presented and dismissed by the client application.
 * @param netverifyUIController the controller instance
 * @param scanViewController the viewController which has to be presented
 * @param isFallback determines if the scan view controller was switched to fallback
 **/
- (void) netverifyUIController: (NetverifyUIController* _Nonnull) netverifyUIController didDetermineNextScanViewController:(NetverifyCustomScanViewController* _Nonnull)scanViewController isFallback:(BOOL)isFallback;

/**
 * Called after all scan view controllers did finish scanning. Network tasks are still ongoing. We advice to show a loading animation. In case a nework error occurs further action is required (retry or cancel) in netverifyUIController:didDetermineError:retryPossible:
 * @param netverifyUIController the controller instance
 **/
- (void) netverifyUIControllerDidCaptureAllParts: (NetverifyUIController* _Nonnull) netverifyUIController;

/**
 * Called whenever an error (due to network, ressources, permissions, ...) occured. Please find more information about this in our gihub implementation guide.
 * @param netverifyUIController the controller instance
 * @param error holds more detailed information about the error reason
 * @param retryPossible defines if displaying a retry-button makes sense or if the error is final
 **/
- (void) netverifyUIController: (NetverifyUIController* _Nonnull) netverifyUIController didDetermineError:(NetverifyError* _Nonnull) error retryPossible:(BOOL)retryPossible;

/**
 * Called when the SDK finished with success.
 * @param netverifyUIController the controller instance
 * @param documentData data containing the extracted information
 * @param scanReference the unique identifier of the scan session
 **/
- (void) netverifyUIController: (NetverifyUIController* _Nonnull) netverifyUIController didFinishWithDocumentData:(NetverifyDocumentData * _Nonnull)documentData scanReference: (NSString* _Nonnull) scanReference;

/**
 * Called when the SDK canceled.
 * @param netverifyUIController the controller instance
 * @param error NSObject holds more detailed information about the error reason
 * @param scanReference the unique identifier of the scan session
 **/
- (void) netverifyUIController: (NetverifyUIController* _Nonnull) netverifyUIController didCancelWithError: (NetverifyError* _Nullable) error scanReference: (NSString* _Nullable) scanReference;

@end

