//
//  JMTextUtilities.h
//
//  Copyright © 2018 Jumio Corporation. All rights reserved.
//

#import <Foundation/Foundation.h>

#define NSStringFromBOOL(boolValue) boolValue? @"YES" : @"NO"

__attribute__((visibility("default"))) @interface JMStringUtilities : NSObject

+ (NSDictionary *)stringAttributesDictionaryWithFont:(UIFont * const)font fontColor:(UIColor * const)fontColor shadow:(NSShadow * const)shadow alignment:(NSTextAlignment) alignment;
+ (NSDictionary *)stringAttributesDictionaryWithFont:(UIFont * const)font fontColor:(UIColor * const)fontColor alignment:(NSTextAlignment) alignment;

+ (NSString *) formatString:(NSString *)string forMaximumLength:(NSUInteger)maxLength regex:(NSString *)regex;
+ (NSString *) trimLeadingTrailingWhiteSpaceFromString:(NSString*)string;
+ (NSString *) formatStringByTrimmingLeadingAndTrailingWhiteSpace:(NSString *)string forMaximumLength:(NSUInteger)maxLength;
+ (NSString *) formatStringByTrimmingLeadingAndTrailingWhiteSpace:(NSString *)string forMaximumLength:(NSUInteger)maxLength withRegex:(NSString*)regex;

+ (NSString *) trimString:(NSString*)string toMaximumLength: (NSUInteger) maxLength;
+ (NSString *) secureSubstringFromIndex:(NSUInteger)index inString:(NSString*)string;
+ (NSUInteger) indexOf:(NSString *)text inString:(NSString*)string;

+ (BOOL)isNumericString:(NSString*)string;
@end
