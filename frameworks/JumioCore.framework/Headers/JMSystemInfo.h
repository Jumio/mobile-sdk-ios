//
//  JMSystemInfo.h
//
//  Copyright © 2018 Jumio Corporation. All rights reserved.
//

#import <Foundation/Foundation.h>

__attribute__((visibility("default"))) @interface JMSystemInfo : NSObject

+ (NSString*)systemVersionString;
+ (float)systemVersionNumber;
+ (BOOL)isSystemVersionAtLeastOS9;
+ (BOOL)isSystemVersionAtLeastOS10;
+ (BOOL)isSystemVersionAtLeastOS11;

@end
