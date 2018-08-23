//
//  NetverifyScanOverlayView.h
//
//  Copyright © 2018 Jumio Corporation. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NetverifyViewController.h"

/**
 * UIView that implements NetverifyAppearance protocol that is used to tint our scan overlays.
 * Please check out our Surface Tool https://jumio.github.io/surface-ios/ to see what customization options are supported.
 **/
__attribute__((visibility("default"))) @interface NetverifyScanOverlayView : UIView <NetverifyAppearance>

/**
 * Set the UIColor that should be used for all standard scan overlays
 **/
@property (nonatomic, strong) UIColor *colorOverlayStandard UI_APPEARANCE_SELECTOR;
/**
 * Set the UIColor that should be used when highlighting a valid scan
 **/
@property (nonatomic, strong) UIColor *colorOverlayValid UI_APPEARANCE_SELECTOR;
/**
 * Set the UIColor that should be used when highlighting a invalid scan
 **/
@property (nonatomic, strong) UIColor *colorOverlayInvalid UI_APPEARANCE_SELECTOR;

@end
