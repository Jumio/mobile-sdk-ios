//
//  JMErrorView.h
//
//  Copyright © 2018 Jumio Corporation. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <JumioCore/JMBaseView.h>

@class JMAlertView;
@class JMThemeableButton;

@protocol JMAlertViewDelegate <NSObject>

@optional
- (void)alertViewDidConfirm:(JMAlertView*)alertView;
- (void)alertViewDidCancel:(JMAlertView*)alertView;
@end

__attribute__((visibility("default"))) @interface JMAlertView : JMBaseView  {
@protected
    UIView *_animationView;
    UIView *_contentView;
    UIView *_containerView;
}

@property (nonatomic, weak) id<JMAlertViewDelegate> delegate;
@property (nonatomic, readonly) JMThemeableButton *confirmButton;

- (instancetype)initWithTitle:(NSString *)title
                      message:(NSString *)message
            cancelButtonTitle:(NSString *)cancelButtonTitle
           confirmButtonTitle:(NSString *)confirmButtonTitle;


- (instancetype)initWithMessage:(NSString *)message
              cancelButtonTitle:(NSString *)cancelButtonTitle
             confirmButtonTitle:(NSString *)confirmButtonTitle;

- (UILabel*)createTitleLabel;
- (UILabel*)createMessageLabel;
- (JMThemeableButton*)createCancelButton;
- (JMThemeableButton*)createConfirmButton;

- (NSArray*)createPortraitConstraints;
- (NSArray*)createLandscapeConstraints;
- (void)updateViewForOrientation:(UIInterfaceOrientation)interfaceOrientation;

- (void)showAnimated:(BOOL)animated completion:(void (^)(BOOL finished))completion;
- (void)hideAnimated:(BOOL)animated completion:(void (^)(BOOL finished))completion;

@end
