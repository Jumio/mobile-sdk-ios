//
//  JMSDK.h
//
//  Copyright © 2016 Jumio Corporation All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    JumioDataCenterUS,
    JumioDataCenterEU
} JumioDataCenter;

typedef enum {
    JumioCameraPositionBack,
    JumioCameraPositionFront,
} JumioCameraPosition;

extern NSString * const kJMSDKBundleShortVersionKey;
extern NSString * const kJMSDKBundleVersionKey;

@interface JMSDK : NSObject

@property (nonatomic, strong) NSBundle * bundle;
@property (nonatomic, strong, readonly) NSDictionary * plistDictionary;

- (NSDictionary *) mobileDeviceDetails;

- (NSString*)shortVersionString;

- (NSString*)versionString;

- (NSString*)sdkVersionString;

- (NSString*)sdkVersionStringFull;

- (NSString*)bundleValueForKey:(NSString* const)key;


@end
