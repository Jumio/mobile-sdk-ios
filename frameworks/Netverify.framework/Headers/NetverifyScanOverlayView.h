//
//  NetverifyScanOverlayView.h
//
//  Copyright © 2018 Jumio Corporation. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NetverifyViewController.h"

__attribute__((visibility("default"))) @interface NetverifyScanOverlayView : UIView <NetverifyAppearance>

@property (nonatomic, strong) UIColor *colorOverlayStandard UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) UIColor *colorOverlayValid UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) UIColor *colorOverlayInvalid UI_APPEARANCE_SELECTOR;

@end
