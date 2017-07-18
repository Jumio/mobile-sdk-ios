//
//  BAMCheckoutNegativeButton.h
//
//  Copyright © 2016 Jumio Corporation All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BAMCheckoutViewController.h"

@interface BAMCheckoutNegativeButton : UIButton<BAMCheckoutAppearance>

@property (nonatomic,strong) UIColor *borderColor UI_APPEARANCE_SELECTOR;

- (void)setBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state UI_APPEARANCE_SELECTOR;
- (UIColor *)backgroundColorForState:(UIControlState)state UI_APPEARANCE_SELECTOR;

@end
