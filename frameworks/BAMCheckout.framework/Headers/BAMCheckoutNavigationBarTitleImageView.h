//
//  BAMCheckoutNavigationBarTitleImageView.h
//
//  Copyright © 2018 Jumio Corporation. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BAMCheckoutViewController.h"

/**
 * UIView that implements BAMCheckoutAppearance protocol that is used to define the uiimage that is - when set - drawn instead of the NavigationBar title.
 **/
__attribute__((visibility("default"))) @interface BAMCheckoutNavigationBarTitleImageView : UIImageView <BAMCheckoutAppearance>

/**
 * UIImage object that is drawn instead of the title in the UINavigationBar.
 **/
@property (nonatomic, strong) UIImage *titleImage UI_APPEARANCE_SELECTOR;

@end
