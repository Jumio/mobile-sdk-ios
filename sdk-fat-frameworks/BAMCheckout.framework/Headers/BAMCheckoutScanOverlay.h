//
//  BAMCheckoutScanOverlay.h
//
//  Copyright © 2016 Jumio Corporation All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BAMCheckoutViewController.h"

@interface BAMCheckoutScanOverlay : UIView<BAMCheckoutAppearance>

@property (nonatomic, strong) UIColor *borderColor UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) UIColor *textColor UI_APPEARANCE_SELECTOR;

@end
