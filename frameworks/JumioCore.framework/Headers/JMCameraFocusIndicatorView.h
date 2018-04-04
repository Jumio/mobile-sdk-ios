//
//  JMCameraFocusIndicatorView.h
//
//  Copyright © 2018 Jumio Corporation. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JMBaseView.h"

extern const CGFloat kCameraFocusIndicatorViewWidth;
extern const CGFloat kCameraFocusIndicatorViewHeight;

__attribute__((visibility("default"))) @interface JMCameraFocusIndicatorView : JMBaseView

- (id)initWithCenter:(CGPoint)centerPos;

@property(nonatomic, strong) UIColor * color;


- (void)setBlinking:(BOOL)isBlinkingOn completion:(void (^)(void))completion;

@end
