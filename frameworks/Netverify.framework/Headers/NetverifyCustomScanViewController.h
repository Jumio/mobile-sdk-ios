//
//  NetverifyScanViewController.h
//
//  Copyright © 2018 Jumio Corporation. All rights reserved.

#import <UIKit/UIKit.h>

@class NetverifyCustomScanViewController;

typedef enum {
    NetverifyScanModeUndefined  = 0,
    NetverifyScanModeMRZ,
    NetverifyScanModeBarcode,
    NetverifyScanModeOCR,
    NetverifyScanModeOCR_Template,
    NetverifyScanModeFace,
    NetverifyScanModeManual
} NetverifyScanMode;

typedef enum {
    NetverifyScanSideFront  = 0,
    NetverifyScanSideBack,
    NetverifyScanSideFace
} NetverifyScanSide;


@protocol NetverifyCustomScanViewControllerDelegate <NSObject>

- (void) netverifyCustomScanViewController:(NetverifyCustomScanViewController * _Nonnull)customScanView shouldDisplayLegalAdvice:(NSString* _Nonnull) message completion:(void (^_Nonnull)(void))completion;
- (void) netverifyCustomScanViewController:(NetverifyCustomScanViewController * _Nonnull)customScanView shouldDisplayConfirmationWithImageView:(UIView * _Nonnull)view text:(NSString * _Nonnull)text confirmation:(void (^_Nullable)(void))confirmation retake:(void (^_Nullable)(void))retake;

@end

/**
 * @class NetverifyCustomScanViewController
 * @brief View Controller that handles scanning. It can display and handle different scanning methods.
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

@end
