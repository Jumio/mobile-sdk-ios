//
//  JMSystemInfo.h
//
//  Copyright © 2016 Jumio Corporation All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JMSystemInfo : NSObject

+ (NSString*)systemVersionString;
+ (float)systemVersionNumber;
+ (BOOL)isSystemVersionAtLeastOS9;

@end
