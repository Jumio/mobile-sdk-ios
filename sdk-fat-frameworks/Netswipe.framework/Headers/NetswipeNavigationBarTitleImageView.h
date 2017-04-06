//
//  NetswipeNavigationBarTitleImageView.h
//
//  Copyright © 2016 Jumio Corporation All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NetswipeViewController.h"

@interface NetswipeNavigationBarTitleImageView : UIImageView <NetswipeAppearance>

@property (nonatomic, strong) UIImage *titleImage UI_APPEARANCE_SELECTOR;

@end
