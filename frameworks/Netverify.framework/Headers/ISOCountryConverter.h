//
//  ISOCountryConverter.h
//
//  Copyright © 2018 Jumio Corporation. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 @class ISOCountryConverter
 @brief Convert ISO 3166-1 alpha-3 into alpha-2 country codes and vice versa.
 */
__attribute__((visibility("default"))) @interface ISOCountryConverter : NSObject

/**
 Use the following method to convert ISO 3166-1 alpha-3 into alpha-2 country code
 @param alpha3 ISO 3166-1 alpha-3 code
 @return ISO 3166-1 alpha-2 code
 */
+ (NSString*) convertToAlpha2: (NSString*) alpha3;

/**
 Use the following method to convert ISO 3166-1 alpha-2 into alpha-3 country code
 @param alpha2 ISO 3166-1 alpha-2 code
 @return ISO 3166-1 alpha-3 code
 */
+ (NSString*) convertToAlpha3: (NSString*) alpha2;

@end
