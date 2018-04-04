//
//  JMImage.h
//
//  Copyright © 2018 Jumio Corporation. All rights reserved.
//

#import <Foundation/Foundation.h>

__attribute__((visibility("default"))) @interface JMImage : NSObject {
    @public
    CMSampleBufferRef sampleBuffer; // Raw buffer from camera
}

- (instancetype) initWithSampleBuffer: (CMSampleBufferRef) buffer croppedImageData: (NSData*) imageData focusValue: (CGFloat) value imageSizeCroppedImage: (CGSize) sizeCroppedImage;

// init used for scan methods other than MRZ
- (instancetype) initWithSampleBuffer: (CMSampleBufferRef) buffer;

@property (nonatomic, assign) CGSize imageSizeSampleBuffer;

@property (nonatomic, assign) CGFloat focusValueCroppedImage;
@property (nonatomic, assign) CGSize imageSizeCroppedImage;
@property (nonatomic, strong) NSData* croppedImageData;

@end
