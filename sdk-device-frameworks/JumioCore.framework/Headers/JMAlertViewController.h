//
//  JMAlertViewController.h
//  AlertViewTest
//
//  Copyright © 2016 Jumio Corporation All rights reserved.
//
#import <UIKit/UIKit.h>

@class  JMAlertView;
@class  JMAlertViewController;

@protocol JMAlertViewControllerDelegate <NSObject>

@optional
- (void)alertViewControllerDidCancel:(JMAlertViewController*)alertViewController;
- (void)alertViewControllerDidConfirm:(JMAlertViewController*)alertViewController;

@end

@interface JMAlertViewController : UIViewController {
    @protected
    JMAlertView *_alertView;
}

@property (nonatomic, assign) UIModalPresentationStyle presentingControllerModalPresentationStyle;
@property (nonatomic, assign) UIModalPresentationStyle presentingControllerModalPresentationCapturesStatusBarAppearance;

- (instancetype)initWithTitle:(NSString *)title
                      message:(NSString *)message
            cancelButtonTitle:(NSString *)cancelButtonTitle
           confirmButtonTitle:(NSString *)confirmButtonTitle;

- (instancetype)initWithMessage:(NSString *)message
              cancelButtonTitle:(NSString *)cancelButtonTitle
             confirmButtonTitle:(NSString *)confirmButtonTitle;

@property (nonatomic, weak) id<JMAlertViewControllerDelegate> delegate;


//Subclass these classes for custom actions for the cancel and confirm buttons
- (void)confirmButtonTouchUpInsideAction;
- (void)cancelButtonTouchUpInsideAction;

/**
 @brief Presents the alertViewController over the presentingViewController. 
 @discussion Use ONLY this method for the presentation of the JMAlertViewController, presenting it manually
 will not work and cause undefined behaviour in iOS 8 lower versions.
 
 @param alertViewController View controller that will be presented. Must not be nil, otherwise the method will do nothing.
 @param presentingViewController View controller from which the alertViewController will be presented from.
 @param completion The block to execute after the presentation finishes. This block has no return value and takes no parameters. You may specify nil for this parameter.
 @warning To dismiss the alertViewController always use, DO NOT attempt to dismiss it manually
 @code + (void)dismissAlertViewController:(JMAlertViewController *)alertViewController fromViewController:(UIViewController *)presentingViewController completion:(void (^)(void))completion;
 */
+ (void)presentAlertViewController:(JMAlertViewController *)alertViewController fromViewController:(UIViewController *)presentingViewController completion:(void (^)(void))completion;

/**
 @brief Dismisses the alertViewController from the presentingViewController.
 @discussion Use ONLY this method for the dismissal of any JMAlertViewController, dismissing it manually
 will result in undefined behavior of the presentingViewController
 
 @param alertViewController View controller that will be dismissed. Must not be nil, otherwise the method will do nothing.
 @param presentingViewController View controller from which the alertViewController will be dismissed from. Must not be nil, otherwise the method will do nothing.
 @param completion The block to execute after the dismiss finishes. This block has no return value and takes no parameters. You may specify nil for this parameter.
 @warning Only alertViewControllers, presented with the method below, should be dismissed with this method. DO NOT use it to dismiss different type of view controllers.
 @code + (void)presentAlertViewController:(JMAlertViewController *)alertViewController fromViewController:(UIViewController *)presentingViewController completion:(void (^)(void))completion;
 */
+ (void)dismissAlertViewController:(JMAlertViewController *)alertViewController fromViewController:(UIViewController *)presentingViewController completion:(void (^)(void))completion;
@end
