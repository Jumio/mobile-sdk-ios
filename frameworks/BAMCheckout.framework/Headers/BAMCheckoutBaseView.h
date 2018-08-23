//
//  BAMCheckoutBaseView.h
//
//  Copyright © 2018 Jumio Corporation. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BAMCheckoutViewController.h"

/**
 * Base class which is used to set our SDK via UIAppearance pattern
 **/
__attribute__((visibility("default"))) @interface BAMCheckoutBaseView : UIView <BAMCheckoutAppearance>

/**
 * Disable blurred background by setting this property to true
 **/
@property (nonatomic, strong) NSNumber *disableBlur UI_APPEARANCE_SELECTOR;

/**
 * Sets the color of the foreground. If nil the standard color will be used.
 **/
@property (nonatomic, strong) UIColor *foregroundColor UI_APPEARANCE_SELECTOR;

/**
 * Set the fontname of your light font used within the application.
 **/
@property (nonatomic, strong) NSString *customLightFontName UI_APPEARANCE_SELECTOR;

/**
 * Set the fontname of your regular font used within the application.
 **/
@property (nonatomic, strong) NSString *customRegularFontName UI_APPEARANCE_SELECTOR;

/**
 * Set the fontname of your medium font used within the application.
 **/
@property (nonatomic, strong) NSString *customMediumFontName UI_APPEARANCE_SELECTOR;

/**
 * Set the fontname of your bold font used within the application.
 **/
@property (nonatomic, strong) NSString *customBoldFontName UI_APPEARANCE_SELECTOR;

@end
