//         
//  BAMCheckoutCustomScanOverlayViewController.h
//
//  Copyright © 2018 Jumio Corporation. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <JumioCore/JMSDK.h>

@class BAMCheckoutCustomScanOverlayViewController;

__attribute__((visibility("default"))) @protocol BAMCheckoutCustomScanOverlayViewControllerDelegate <NSObject>

@required

/**
 * This method is called when an error occured while the ScanViewController is opend
 * @param error The error codes 200, 210, 220, 240, 300 and 320 will be returned.
 * @param retryPossible Indicates whether [self retryScan] can be called.
 **/
- (void)bamCheckoutStoppedWithError:(NSError *)error retryPossible:(BOOL)retryPossible;

@end


__attribute__((visibility("default"))) @interface BAMCheckoutCustomScanOverlayViewController : UIViewController

/**
 * The delegate that handles the callbacks sent from the ScanViewController
 **/
@property (nonatomic, weak) id<BAMCheckoutCustomScanOverlayViewControllerDelegate> delegate;

/**
 * Sets the vertical offset of the cardframe overlay from the center.
 **/
@property (nonatomic, assign) CGFloat verticalCardFrameOffset;

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
 * Toggles the built-in flash.
 * This method can not be called if scanning is paused or stopped
 **/
- (void) toggleFlash;

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
 * Call this method if you want to stop the capturing process.
 **/
- (void) stopScan;

/**
 * Call this method get the position of the card-frame on the screen.
 * @return A CGRect of the screen where the cardFrame appears and which must not be overlapped by the overlaying UI.
 **/
- (CGRect) cardFrame;

@end
