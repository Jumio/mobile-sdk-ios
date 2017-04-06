//
//  JMDeviceOrientationChangeNotifier.h
//
//  Copyright © 2016 Jumio Corporation All rights reserved.
//

#import <Foundation/Foundation.h>

@class JMDeviceOrientationChangeNotifier;

@protocol JMDeviceOrientationChangeNotifierDelegate <NSObject>

- (void)deviceDidRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation fromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation;
@end

@interface JMDeviceOrientationChangeNotifier : NSObject

@property (nonatomic, weak) id<JMDeviceOrientationChangeNotifierDelegate> delegate;
@property (nonatomic, assign) UIInterfaceOrientationMask supportedInterfaceOrientations;

- (void)beginGeneratingDeviceOrientationChangeNotifications;
- (void)endGeneratingDeviceOrientationChangeNotifications;

@end
