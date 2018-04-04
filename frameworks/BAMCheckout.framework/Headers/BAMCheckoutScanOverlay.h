//
//  BAMCheckoutScanOverlay.h
//
//  Copyright © 2018 Jumio Corporation. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BAMCheckoutViewController.h"

__attribute__((visibility("default"))) @interface BAMCheckoutScanOverlay : UIView<BAMCheckoutAppearance>

@property (nonatomic, strong) UIColor *borderColor UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) UIColor *textColor UI_APPEARANCE_SELECTOR;

@end
