//
//  NetverifyDocumentSelectionButton.h
//
//  Copyright © 2018 Jumio Corporation. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "NetverifyViewController.h"

__attribute__((visibility("default"))) @interface NetverifyDocumentSelectionButton : UIButton <NetverifyAppearance>

- (void)setBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state UI_APPEARANCE_SELECTOR;
- (UIColor *)backgroundColorForState:(UIControlState)state UI_APPEARANCE_SELECTOR;

- (void)setIconColor:(UIColor *)iconColor forState:(UIControlState)state UI_APPEARANCE_SELECTOR;
- (UIColor *)iconColorForState:(UIControlState)state UI_APPEARANCE_SELECTOR;


@end
