//
//  JMImageUtilities.h
//
//  Copyright © 2018 Jumio Corporation. All rights reserved.
//

#import <JumioCore/JumioCore.h>

__attribute__((visibility("default"))) @interface JMImageUtilities : NSObject

+ (UIImage *)cropRect:(CGRect)rect fromImage:(UIImage*)image;

+ (UIImage *)scaleImageProportionaly:(UIImage*)sourceImage toSize:(CGSize)targetSize;
+ (UIImage *)scaleImage:(UIImage*)sourceImage toSize:(CGSize)targetSize;
+ (UIImage*)rotateImage:(UIImage*) image byDegrees:(CGFloat)degrees;

+ (UIImage *)applyBlurWithRadius:(CGFloat)blurRadius toImage:(UIImage*)image;
+ (UIImage *)imageWithColor:(UIColor *)color;
+ (UIImage *)imageWithColor:(UIColor *)color withSize:(CGSize)size;
@end
