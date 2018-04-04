//
//  JMCaptureSessionManager.h
//
//  Copyright © 2018 Jumio Corporation. All rights reserved.
//

#import <CoreMedia/CoreMedia.h>
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>
#import <CoreMedia/CoreMedia.h>
#import <UIKit/UIKit.h>

@class JMCaptureSessionManager;

@protocol CameraProcessingDataSource <NSObject>
- (BOOL) captureSessionManagerShouldProcessSampleBuffer;
@end

@protocol CameraProcessingDelegate <NSObject>
- (void) captureSessionManagerDidOutputSampleBuffer: (CMSampleBufferRef) sampleBuffer;
- (void) captureSessionManagerDidFinishProcessingSampleBuffer: (CMSampleBufferRef) sampleBuffer outputImageFrame: (uint8_t*) imageFrame outputRect: (CGRect) rect;

@optional
- (void) captureSessionManagerFlashNeeded:(BOOL)flashNeeded;
- (void) captureSessionManagerDidOutputmetaData:(NSArray *)metadataObjects;

@end

__attribute__((visibility("default"))) @interface JMCaptureSessionManagerConfiguration : NSObject

@property (nonatomic, assign) AVCaptureVideoOrientation videoOrientation;
@property (nonatomic, assign) AVCaptureDevicePosition cameraPosition;
@property (nonatomic, assign) int allowedCaptureDevicePositions;
@property (nonatomic, assign) BOOL applyOrientationToPreview;
@property (nonatomic, assign) id<CameraProcessingDataSource> cameraProcessingDataSource;
@property (nonatomic, assign) id<CameraProcessingDelegate> cameraProcessingDelegate;
@property (nonatomic, assign) BOOL requiresFaceMetaData; //default: NO
@property (nonatomic, assign) BOOL requiresBarcodeMetaData; //default: NO

@end


/**
 @class JMCaptureSessionManager
 @brief Manages capturing procedure with the built-in audio/video devices and provides a preview layer of the camera's sight.
 @author Philipp Rakuschan
 */
__attribute__((visibility("default"))) @interface JMCaptureSessionManager : NSObject <AVCaptureVideoDataOutputSampleBufferDelegate, AVCaptureMetadataOutputObjectsDelegate> {
    @protected
    dispatch_queue_t videoDataOutputQueue;
    int recordingFrameRate;         /**< integer value for recording frame rate calculated in dependency of encoding frame rate */
    uint8_t* croppedRGBFrameBuffer;
}

@property (atomic, strong) NSMutableData* croppedRGBFrameBufferData;
@property (weak, nonatomic, readonly) UIImage *imageToBlur;

@property (nonatomic, strong) AVCaptureVideoPreviewLayer *previewLayer;
@property (nonatomic, assign) AVCaptureVideoOrientation videoOrientation;
@property (nonatomic, readonly) NSString *captureSessionPreset;           /**< The preset used for capturing */
@property (nonatomic, assign, getter = isVideoOrientationSupported) BOOL videoOrientationSupported; /**< Indicates if video orientation can be set for capturing. If it cannot be set, the frames must get manually rotated to the proper direction */
@property (nonatomic, assign) BOOL previewVisible;                      /**< Indicates when preview on screen is actually visible */
@property (nonatomic, assign, getter = isCapturing) BOOL capturing;
@property (nonatomic, assign) BOOL cropRawFrameBufferAfterOutput; // NO for MRZ, YES for 3rd party OCR (CSSN)

@property (nonatomic, readonly) CGSize imageFrameSizeForCurrentConfiguration; // Returns raw image size of sample buffer for the current capture session configuration
@property (nonatomic, readonly) CGRect croppingRectForCurrentConfiguration; // Returns the cropping rect applied to the raw buffer for the current capture session configuration

// camera related
@property (nonatomic, readonly, getter = areTwoCamerasAvailable) BOOL twoCamerasAvailable;
@property (nonatomic, readonly, getter = isTorchAvailable) BOOL torchAvailable;
@property (nonatomic, readonly, getter = isTorchOn) BOOL torchOn;
@property (nonatomic, readonly, getter = isBackCameraActive) BOOL backCameraActive;
@property (weak, nonatomic, readonly) AVCaptureDevice *activeCameraDevice; // Either back or front

@property (atomic, strong) NSDate *dateOfLastFocusAdjustment;
@property (atomic, strong) NSDate *dateOfLastExposureAdjustment;
@property (atomic, strong) NSDate *dateOfLastWhiteBalanceAdjustment;

@property (nonatomic, assign) CGPoint focusPointOfInterest;
@property (nonatomic, assign) CGFloat cropFactorY;
@property (nonatomic, assign) CGFloat cropFactorWidth;
@property (nonatomic, assign) CGFloat cropRectOffsetFactorY;

+ (BOOL)isCameraAvailableAtPosition:(AVCaptureDevicePosition)devicePosition;

- (id) initWithConfiguration:(JMCaptureSessionManagerConfiguration *) configuration;
- (void) updateConfiguration:(JMCaptureSessionManagerConfiguration *) configuration;
- (void) detachDelegateAndDataSource;
- (void) removeCaptureInputs;
- (void) removeCaptureOutputs;
- (void) updateSessionPreset;

- (void) restartCapturing;
- (void) startCapturing;
- (void) stopCapturing;

// IPHONE-4616 BAM: Pause for Customer Overlay is not working
// Exclusively for BAM credit card scanning, as the custom scan view has a start and stop scan functionality
- (void) startCapturingAndPreview;
- (void) stopCapturingAndPreview;

- (void) setRequiresFaceMetaDataWithCaptureDevicePosition:(AVCaptureDevicePosition)devicePosition;
- (void) enableVideoDataOutput;
- (void) disableVideoDataOutput;
- (void) addDefaultVideoInput;

- (void) setVideoOrientation: (AVCaptureVideoOrientation) videoOrientation includingPreviewLayer: (BOOL) considerPreviewLayer;
- (CGSize) imageFrameSizeForCurrentCaptureSessionPresetWithVideoOrientation: (AVCaptureVideoOrientation) videoOrientation; // Returns raw image size of sample buffer for the current capture session configuration and configurable video orientation
- (CGSize) captureOutputSizeForInterfaceOrientation: (UIInterfaceOrientation) interfaceOrientation;
//- (CGSize) captureOutputAspectRatioForInterfaceOrientation: (UIInterfaceOrientation) interfaceOrientation;

- (CGRect)transformCGRect:(CGRect)source forUIImageOrientation:(UIImageOrientation)orientation size:(CGSize)imageSize;

- (AVCaptureDevicePosition) finalCameraPosition;

- (void)setTorchMode:(AVCaptureTorchMode)torchMode;
- (void)toggleTorchMode;

- (void) focusOnCard;
- (void) focusOnPoint: (CGPoint) focusPoint;

- (void) toggleCamera;
- (void) manualFocusInEffectFor:(float)second;

- (CGSize) imageFrameSizeForCurrentConfigurationWithPadding;
- (CGSize) imageFrameSizeForCurrentConfiguration;

- (UIImage*) imageFromCurrentRawBGRABuffer;
- (UIImage*) imageFromCurrentRawBGRABufferWithoutPadding;
- (UIImage*) imageFromCurrentCroppedRGBBuffer;
+ (UIImage*) imageFromRGBBuffer: (uint8_t*) buffer size: (CGSize) size;
- (UIImage*) imageFromRawBGRABuffer:(uint8_t*) buffer size: (CGSize) size copy: (BOOL) copy;
- (NSData*) dataFromRawBGRABuffer: (uint8_t*) buffer bufferSize: (CGSize) size inRect:(CGRect)rect;
- (NSData*) dataFromRawBGRABufferInRect:(CGRect)rect;
- (BOOL) convertRawBGRABuffer:(uint8_t *)srcBuffer bufferSize:(CGSize)size inRect:(CGRect)rect toMutableDataObject: (NSMutableData*) dstData;

- (void) setCropRectOffsetFactorYWithAbsolutePixels:(CGFloat)cropRectOffsetYPixels;
- (void) setCropRectOffsetFactorYFromAbsolutePixels:(CGFloat)cropRectOffsetYPixels;

/**
 * @brief Calculates the focus confidence from the current sample buffer.
 * @discussion The focus value of the sample buffer image is calculated via
 * @code + (float)focusConfidenceFromData:(char *)data length:(int)length width:(int)width height:(int)height stride:(int)stride channels:(int)channels;
 * @return image quality value or -1 if some error occured in the process.
 */
- (float)focusConfidenceFromCurrentSampleBuffer;

/**
 * @brief Calculates the focus confidence of the image.
 * @discussion Returns the focus threshold on which isRefocusNeeded thresholds the image.  A high value means a sharp, clear image. If the value returned is -1 then an error has occured and the returned value should be discarded.
 * @param data is a pointer to the image data. Must not be nil.
 * @param length is the size of the image. Must not be nil.
 * @param width is the width of the image. Must not be nil.
 * @param height is the height of the image. Must not be nil.
 * @param stride is the stride of the image. Must not be nil.
 * @param channels is the number of image channels. Must not be nil.
 * @return image quality value or -1 if some error occured in the process.
 */
+ (float)focusConfidenceFromData:(char *)data length:(int)length width:(int)width height:(int)height stride:(int)stride channels:(int)channels;

- (BOOL) detectFaceOnSampleBuffer: (CMSampleBufferRef) sampleBuffer inRect: (CGRect) rect;

- (void) cleanUp;

@end
