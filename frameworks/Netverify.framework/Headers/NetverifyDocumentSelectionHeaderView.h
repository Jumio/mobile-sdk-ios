//
//  NetverifyDocumentSelectionHeaderView.h
//
//  Copyright © 2018 Jumio Corporation. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "NetverifyViewController.h"

__attribute__((visibility("default"))) @interface NetverifyDocumentSelectionHeaderView : UIView <NetverifyAppearance>

@property (nonatomic, strong) UIColor* iconColor  UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) UIColor* titleColor  UI_APPEARANCE_SELECTOR;

@end
