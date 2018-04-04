//
//  JMFontUtilities.h
//
//  Copyright © 2018 Jumio Corporation. All rights reserved.
//

#import <Foundation/Foundation.h>

__attribute__((visibility("default"))) @interface JMFontUtilities : NSObject

+ (UIFont*)lightFontWithSize:(float)size ;
+ (UIFont*)regularFontWithSize:(float)size;
+ (UIFont*)mediumFontWithSize:(float)size;
+ (UIFont*)boldFontWithSize:(float)size;
+ (UIFont*)italicFontWithSize:(float)size;

@end
