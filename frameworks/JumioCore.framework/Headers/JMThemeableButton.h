//
//  JMThemeableButton.h
//
//  Copyright © 2018 Jumio Corporation. All rights reserved.
//

#import <UIKit/UIKit.h>

__attribute__((visibility("default"))) @interface JMThemeableButton : UIButton

@property (nonatomic, assign) CGFloat cornerRadius;

- (instancetype)initWithSize:(CGSize)size;

- (void)setBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state UI_APPEARANCE_SELECTOR;
- (UIColor *)backgroundColorForState:(UIControlState)state UI_APPEARANCE_SELECTOR;


- (void)setTitle:(NSString *)title;

- (void)setDefaultValues;

@end





