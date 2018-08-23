//
//  BAMCheckoutScanOverlay.h
//
//  Copyright © 2018 Jumio Corporation. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BAMCheckoutViewController.h"

/**
 * UIView that implements BAMCheckoutAppearance protocol that is used to tint our scan overlays.
 **/
__attribute__((visibility("default"))) @interface BAMCheckoutScanOverlay : UIView<BAMCheckoutAppearance>

/**
 * Set the UIColor that should be used for the scan overlay
 **/
@property (nonatomic, strong) UIColor *borderColor UI_APPEARANCE_SELECTOR;

/**
 * Set the UIColor for text elements displayed on the scan overlay
 **/
@property (nonatomic, strong) UIColor *textColor UI_APPEARANCE_SELECTOR;

@end
