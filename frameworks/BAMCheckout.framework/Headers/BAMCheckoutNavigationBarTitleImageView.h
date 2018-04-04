//
//  BAMCheckoutNavigationBarTitleImageView.h
//
//  Copyright © 2018 Jumio Corporation. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BAMCheckoutViewController.h"

__attribute__((visibility("default"))) @interface BAMCheckoutNavigationBarTitleImageView : UIImageView <BAMCheckoutAppearance>

@property (nonatomic, strong) UIImage *titleImage UI_APPEARANCE_SELECTOR;

@end
