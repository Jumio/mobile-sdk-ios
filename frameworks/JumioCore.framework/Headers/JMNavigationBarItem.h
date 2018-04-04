//
//  JMNavigationBarItem.h
//
//  Copyright © 2018 Jumio Corporation. All rights reserved.
//

#import <UIKit/UIKit.h>

__attribute__((visibility("default"))) @interface JMNavigationBarItem : UIButton

- (id)initWithSize:(CGSize)size;

- (void)setBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state UI_APPEARANCE_SELECTOR;

@end
