//
//  NetverifyDocumentSelectionButton.h
//
//  Copyright © 2018 Jumio Corporation. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "NetverifyViewController.h"

/**
 * UIButton that implements NetverifyAppearance protocol. Button that is used on Screen where users can select the document they wish to scan.
 * Please check out our Surface Tool https://jumio.github.io/surface-ios/ to see what customization options are supported.
 **/
__attribute__((visibility("default"))) @interface NetverifyDocumentSelectionButton : UIButton <NetverifyAppearance>

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

/**
 * Set the tint color of icons for specific states.
 * @param iconColor UIColor that should be used
 * @param state the UIControlState for which the color should be drawn
 **/
- (void)setIconColor:(UIColor *)iconColor forState:(UIControlState)state UI_APPEARANCE_SELECTOR;
/**
 * Returns the tint color for specific states.
 * @param state the UIControlState for which the color should be drawn
 * @return UIColor that is to be used
 **/
- (UIColor *)iconColorForState:(UIControlState)state UI_APPEARANCE_SELECTOR;


@end
