//
//  JMRoi.h
//
//  Copyright © 2018 Jumio Corporation. All rights reserved.
//

#import "JMBaseView.h"


__attribute__((visibility("default"))) @interface JMRoi : JMBaseView {
@protected
    UIRectCorner    _roundCorners;
    CGFloat         _roundCornersRadius;
    CGFloat         _contentInset;
}

@property (nonatomic, assign, readonly) UIRectCorner roundCorners;
@property (nonatomic, assign, readonly) CGFloat roundCornersRadius;
@property (nonatomic, assign, readonly) CGFloat contentInset;
@property (nonatomic, assign)           CGFloat borderWidth;
@property (nonatomic, strong)           UIColor* borderColor;

- (CGSize)cornerRadii;
- (CGRect)cropRect;
- (UIBezierPath *)cropBezierPathFromCropRect:(CGRect)cropRect;


@end
