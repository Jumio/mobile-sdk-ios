//
//  JMFontUtilities.h
//
//  Copyright © 2016 Jumio Corporation All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JMFontUtilities : NSObject

+ (UIFont*)lightFontWithSize:(float)size ;
+ (UIFont*)regularFontWithSize:(float)size;
+ (UIFont*)mediumFontWithSize:(float)size;
+ (UIFont*)boldFontWithSize:(float)size;
+ (UIFont*)italicFontWithSize:(float)size;

@end
