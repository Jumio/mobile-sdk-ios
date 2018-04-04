//
//  UIAlertController+JMPresenting.h
//
//  Copyright © 2018 Jumio Corporation. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIAlertController (JMPresenting)

+ (void) presentAlertViewWithTitle: (NSString*) title message: (NSString*) message cancelButtonTitle: (NSString*) cancelButtonTitle additionalActions: (NSArray*) additionalActions completion: (void(^)(void))completion;
+ (void) presentAlertViewWithTitle: (NSString*) title message: (NSString*) message cancelButtonTitle: (NSString*) cancelButtonTitle completion: (void(^)(void))completion;

@end
