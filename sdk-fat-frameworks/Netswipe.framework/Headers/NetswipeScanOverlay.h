//
//  NetswipeScanOverlay.h
//
//  Copyright © 2016 Jumio Corporation All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NetswipeViewController.h"

@interface NetswipeScanOverlay : UIView<NetswipeAppearance>

@property (nonatomic, strong) UIColor *borderColor UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) UIColor *textColor UI_APPEARANCE_SELECTOR;

@end
