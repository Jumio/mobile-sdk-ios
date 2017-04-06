//
//  NetswipeBaseView.h
//
//  Copyright © 2016 Jumio Corporation All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NetswipeViewController.h"

@interface NetswipeBaseView : UIView <NetswipeAppearance>

@property (nonatomic, strong) NSNumber *disableBlur UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) UIColor *foregroundColor UI_APPEARANCE_SELECTOR;

@property (nonatomic, strong) NSString *customLightFontName UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) NSString *customRegularFontName UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) NSString *customMediumFontName UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) NSString *customBoldFontName UI_APPEARANCE_SELECTOR;

@end
