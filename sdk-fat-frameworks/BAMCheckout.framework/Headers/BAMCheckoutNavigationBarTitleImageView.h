//
//  BAMCheckoutNavigationBarTitleImageView.h
//
//  Copyright © 2016 Jumio Corporation All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BAMCheckoutViewController.h"

@interface BAMCheckoutNavigationBarTitleImageView : UIImageView <BAMCheckoutAppearance>

@property (nonatomic, strong) UIImage *titleImage UI_APPEARANCE_SELECTOR;

@end
