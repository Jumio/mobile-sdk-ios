//
//  NetverifyDocumentSelectionHeaderView.h
//
//  Copyright © 2018 Jumio Corporation. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "NetverifyViewController.h"

/**
 * UIView that implements NetverifyAppearance protocol. HeaderView that is used on DocumentSelection screen.
 * Please check out our Surface Tool https://jumio.github.io/surface-ios/ to see what customization options are supported.
 **/
__attribute__((visibility("default"))) @interface NetverifyDocumentSelectionHeaderView : UIView <NetverifyAppearance>

/**
 * Set the tint color of icons
 **/
@property (nonatomic, strong) UIColor* iconColor  UI_APPEARANCE_SELECTOR;
/**
 * Set the text color within the header views
 **/
@property (nonatomic, strong) UIColor* titleColor  UI_APPEARANCE_SELECTOR;

@end
