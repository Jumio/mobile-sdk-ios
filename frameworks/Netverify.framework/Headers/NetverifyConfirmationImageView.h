//
//  NetverifyConfirmationImageView.h
//
//  Copyright © 2018 Jumio Corporation. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 * UIView that draws the image taken in NetverifyCustomScanViewController. This view will be provided via the  netverifyCustomScanViewController:shouldDisplayConfirmationWithImageView:text:confirmation:retake: delegate method after a successful scan was performed. Simply add this view as subview and it will draw itself accordingly. We suggest to ask the user if the image is readable and properly alligned to prevent bad quality images.
 **/
__attribute__((visibility("default"))) @interface NetverifyConfirmationImageView : UIView

/**
 * returns the size of the image
 **/
@property (nonatomic, assign, readonly) CGSize imageSize;

@end
