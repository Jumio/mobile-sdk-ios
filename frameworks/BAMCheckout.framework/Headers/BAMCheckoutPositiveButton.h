//
//  BAMCheckoutPositiveButton.h
//
//  Copyright © 2018 Jumio Corporation. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BAMCheckoutViewController.h"

__attribute__((visibility("default"))) @interface BAMCheckoutPositiveButton : UIButton<BAMCheckoutAppearance>

@property (nonatomic,strong) UIColor *borderColor UI_APPEARANCE_SELECTOR;

- (void)setBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state UI_APPEARANCE_SELECTOR;
- (UIColor *)backgroundColorForState:(UIControlState)state UI_APPEARANCE_SELECTOR;

@end
