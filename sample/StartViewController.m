//
//  ViewController.m
//
//  Copyright © 2018 Jumio Corporation All rights reserved.
//

#import "StartViewController.h"


@interface StartViewController ()
@end

@implementation StartViewController

#pragma mark - Rotation handling
- (BOOL) shouldAutorotate {
    return YES;
}
- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
        return UIInterfaceOrientationMaskAll;
}

#pragma mark - Status bar handling

- (UIStatusBarStyle) preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

#pragma mark - Helper
- (void) showAlertWithTitle:(NSString *)title message:(NSString *)message {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title
                                                                             message:message
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction = [UIAlertAction
                               actionWithTitle:@"OK"
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction *action)
                               {
                                   
                               }];
    
    [alertController addAction:okAction];
    
    [self presentViewController:alertController
                       animated:YES
                     completion:nil];

}

@end
