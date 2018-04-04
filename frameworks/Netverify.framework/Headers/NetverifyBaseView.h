//
//  NetverifyBaseView.h
//
//  Copyright © 2018 Jumio Corporation. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NetverifyViewController.h"

__attribute__((visibility("default"))) @interface NetverifyBaseView : UIView <NetverifyAppearance>

@property (nonatomic, strong) NSNumber *disableBlur UI_APPEARANCE_SELECTOR;

@property (nonatomic, strong) UIColor *foregroundColor UI_APPEARANCE_SELECTOR;

@property (nonatomic, strong) NSString *customLightFontName UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) NSString *customRegularFontName UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) NSString *customMediumFontName UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) NSString *customBoldFontName UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) NSString *customItalicFontName UI_APPEARANCE_SELECTOR;

@end
