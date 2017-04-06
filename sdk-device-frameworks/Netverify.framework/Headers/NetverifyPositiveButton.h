//
//  NetverifyPositiveButton.h
//
//  Copyright © 2016 Jumio Corporation All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NetverifyViewController.h"

@interface NetverifyPositiveButton : UIButton <NetverifyAppearance>

@property (nonatomic,strong) UIColor *borderColor UI_APPEARANCE_SELECTOR;

- (void)setBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state UI_APPEARANCE_SELECTOR;
- (UIColor *)backgroundColorForState:(UIControlState)state UI_APPEARANCE_SELECTOR;

@end
