//
//  NetverifyScanOverlayView.h
//
//  Copyright © 2016 Jumio Corporation All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NetverifyViewController.h"

@interface NetverifyScanOverlayView : UIView <NetverifyAppearance>

@property (nonatomic, strong) UIColor *colorOverlayStandard UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) UIColor *colorOverlayValid UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) UIColor *colorOverlayInvalid UI_APPEARANCE_SELECTOR;

@end
