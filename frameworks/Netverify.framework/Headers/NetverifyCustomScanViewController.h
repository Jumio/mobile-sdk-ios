//
//  NetverifyScanViewController.h
//
//  Copyright © 2018 Jumio Corporation. All rights reserved.

#import <UIKit/UIKit.h>

@class NetverifyCustomScanViewController;
@class NetverifyConfirmationImageView;

/**
 * Defines the scan mode that is used
 **/
typedef NS_ENUM(NSUInteger, NetverifyScanMode) {
    /** Scan mode is not determined */
    NetverifyScanModeUndefined  = 0,
    /** Scan mode is MRZ */
    NetverifyScanModeMRZ,
    /** Scan mode is Barcode */
    NetverifyScanModeBarcode,
    /** Scan mode is OCR */
    NetverifyScanModeOCR,
    /** Scan mode is OCR with automatic ID detection */
    NetverifyScanModeOCR_Template,
    /** Scan mode is Face */
    NetverifyScanModeFace,
    /** Scan mode is mx^anual image picker */
    NetverifyScanModeManual
};

/**
 * Defines the part of the scan step
 **/
typedef NS_ENUM(NSUInteger, NetverifyScanSide) {
    /** Front side of the document */
    NetverifyScanSideFront  = 0,
    /** Back side of the document */
    NetverifyScanSideBack,
    /** Selfie */
    NetverifyScanSideFace
};

/**
 * Protocol that has to be implemented when using a NetverifyCustomScanViewController
 **/
@protocol NetverifyCustomScanViewControllerDelegate <NSObject>

/**
 * During the scanning of some ID cards, a legal advice need to be shown.
 * @param customScanView instance of the current scanViewController
 * @param message localized message that hast to be displayed
 * @param completion block that should be called when user marks the message as read
 **/
- (void) netverifyCustomScanViewController:(NetverifyCustomScanViewController * _Nonnull)customScanView shouldDisplayLegalAdvice:(NSString* _Nonnull) message completion:(void (^_Nonnull)(void))completion;

/**
 * For some scan views we advice to show a confirmationView after scanning. In this case this delegate method will be called providing the final image.
 * @param customScanView instance of the current scanViewController
 * @param view that draws the image
 * @param text localized message that should be displayed
 * @param confirmation block that should be called when user confirmed the image
 * @param retake block that should be called when user hit retry
 **/
- (void) netverifyCustomScanViewController:(NetverifyCustomScanViewController * _Nonnull)customScanView shouldDisplayConfirmationWithImageView:(NetverifyConfirmationImageView * _Nonnull)view text:(NSString * _Nonnull)text confirmation:(void (^_Nullable)(void))confirmation retake:(void (^_Nullable)(void))retake;

/**
 * No US Address has been found in the barcode. The scan preview will switch to frontside scanning if available. Check for the changed scan mode and help text. Will only be called on a Fastfill scan.
 * @param customScanView instance of the current scanViewController
 * @param message localized message that hast to be displayed
 * @param confirmation block that should be called when user marks the message as read
 **/
- (void) netverifyCustomScanViewController:(NetverifyCustomScanViewController* _Nonnull)customScanView shouldDisplayNoUSAddressFoundHint:(NSString* _Nonnull)message confirmation:(void (^_Nonnull)(void))confirmation;

/**
 * Triggered when we detect that the user accidentally scanned the front side although backside is required.
 * @param customScanView instance of the current scanViewController
 * @param message localized message that hast to be displayed
 * @param confirmation block that should be called when user marks the message as read
 **/
- (void) netverifyCustomScanViewController:(NetverifyCustomScanViewController* _Nonnull)customScanView shouldDisplayFlipDocumentHint:(NSString* _Nonnull)message confirmation:(void (^_Nonnull)(void))confirmation;

@optional
/**
 * Notify the user that the image is blurry and therefore can't be taken. (Manual image capturing only)
 * @param customScanView instance of the current scanViewController
 * @param message localized message that should be displayed
 **/
- (void) netverifyCustomScanViewController:(NetverifyCustomScanViewController * _Nonnull)customScanView shouldDisplayBlurHint:(NSString* _Nonnull) message;

@end

/**
 * View Controller that handles scanning. It can display and handle different scanning methods.
 **/
__attribute__((visibility("default"))) @interface NetverifyCustomScanViewController : UIViewController

/**
 * delegate class which implements the NetverifyCustomScanViewControllerDelegate protocol
 **/
@property (nonatomic, assign, nonnull) id <NetverifyCustomScanViewControllerDelegate> customScanViewControllerDelegate;

/**
 * UIView which should be used to add any additional custom views as a subview
 **/
@property (nonatomic, strong) UIView* _Nonnull customOverlayLayer;

/**
 * This method can not be called if scanning is paused or stopped
 * @return BOOL Determines whether an alternative scan method is available
 **/
- (BOOL) isFallbackAvailable;

/**
 * Switch to the alternative scan method
 **/
- (void) switchToFallback;

/**
 * This method can not be called if scanning is paused or stopped
 * @return true if a flash is available
 **/
- (BOOL) hasFlash;

/**
 * This method can not be called if scanning is paused or stopped
 * @return true if there is AVCaptureDevicePositionFront and AVCaptureDevicePositionBack
 **/
- (BOOL) hasMultipleCameras;

/**
 * This method can not be called if scanning is paused or stopped
 * @return true if the flash is currently on.
 **/
- (BOOL) isFlashOn;

/**
 * This method can not be called if scanning is paused or stopped
 * @return The current camera position.
 **/
- (JumioCameraPosition) currentCameraPosition;

/**
 * Determines whether the Scan View is a manual image picker
 **/
- (BOOL) isImagePicker;

/**
 * Target action for the shutter button in case the Scan View is a manual image picker
 **/
- (void) takeImage;

/**
 * @return Determines whether the flash can be toggled
 **/
- (BOOL) canToggleFlash;

/**
 * Toggles the built-in flash.
 * This method can not be called if scanning is paused or stopped
 **/
- (void) toggleFlash;

/**
 * Determines whether the primary camera position can be switched
 **/
- (BOOL) canSwitchCamera;

/**
 * Switches between available cameraPositions.
 * This method can not be called if scanning is paused or stopped
 **/
- (void) switchCamera;

/**
 * Call this method if you want to restart the capturing process.
 **/
- (void) retryScan;

/**
 * Call this method if you want to pause the capturing process. Camera preview will not be paused.
 **/
- (void) pauseScan;

/**
 * @return the dimensions of the ROI overlay which must not be overlayed by any custom views
 **/
- (CGRect) overlayFrame;

/**
 * Method to get the suggested help text
 * @return String of localized short help text
 **/
- (NSString * _Nonnull) localizedShortHelpText;

/**
 * Method to get the suggested help text in long version
 * @return String of localized full help text
 **/
- (NSString * _Nonnull) localizedLongHelpText;

/**
 * @return the running number of scanViewControllers within the whole workflow which can be used to display the progress in the workflow. e.g. Step 1 of 3
 **/
- (NSUInteger) currentStep;

/**
 * @return the number of total scanViewControllers which can be used to display the progress in the workflow. e.g. Step 1 of 3
 **/
- (NSUInteger) totalSteps;

/**
 * @return the scanMode of the current scanViewController
 **/
- (NetverifyScanMode) currentScanMode;

/**
 * Sets the vertical offset of the overlay (MRZ, OCR_Card) from the center.
 **/
@property (nonatomic, assign) CGFloat verticalRoiOffset;

/**
 * Call this method to get the position of the region of interest on the screen.
 * @return A CGRect of the screen coordinates where the region of interest appears and which must not be overlapped by the overlaying UI.
 **/
- (CGRect) roiFrame;

@end
