//
//  BAMCheckoutNegativeButton.h
//
//  Copyright © 2018 Jumio Corporation. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BAMCheckoutViewController.h"

/**
 * UIButton that implements BAMCheckoutAppearance protocol that is used within our confirmation or error views and invokes a negative action (e.g. cancel, retry).
 **/
__attribute__((visibility("default"))) @interface BAMCheckoutNegativeButton : UIButton<BAMCheckoutAppearance>

/**
 * UIColor that is used to draw the border.
 **/
@property (nonatomic,strong) UIColor *borderColor UI_APPEARANCE_SELECTOR;

/**
 * Sets the background color for specific states.
 * @param backgroundColor UIColor that should be used
 * @param state the UIControlState for which the color should be drawn
 **/
- (void)setBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state UI_APPEARANCE_SELECTOR;
/**
 * Returns the background color for specific states.
 * @param state the UIControlState for which the color should be drawn
 * @return UIColor that is to be used
 **/
- (UIColor *)backgroundColorForState:(UIControlState)state UI_APPEARANCE_SELECTOR;

@end
