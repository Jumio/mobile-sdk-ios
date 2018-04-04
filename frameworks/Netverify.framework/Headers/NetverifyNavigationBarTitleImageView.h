//
//  NetswipeTitleImageView.h
//
//  Copyright © 2018 Jumio Corporation. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NetverifyViewController.h"

__attribute__((visibility("default"))) @interface NetverifyNavigationBarTitleImageView : UIImageView <NetverifyAppearance>

@property (nonatomic, strong) UIImage *titleImage UI_APPEARANCE_SELECTOR;

@end
