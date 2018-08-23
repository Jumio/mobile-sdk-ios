//
//  NetswipeTitleImageView.h
//
//  Copyright © 2018 Jumio Corporation. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NetverifyViewController.h"

/**
 * UIView that implements NetverifyAppearance protocol that is used to define the uiimage that is - when set - drawn instead of the NavigationBar title.
 * Please check out our Surface Tool https://jumio.github.io/surface-ios/ to see what customization options are supported.
 **/
__attribute__((visibility("default"))) @interface NetverifyNavigationBarTitleImageView : UIImageView <NetverifyAppearance>

/**
 * UIImage object that is drawn instead of the title in the UINavigationBar.
 **/
@property (nonatomic, strong) UIImage *titleImage UI_APPEARANCE_SELECTOR;

@end
