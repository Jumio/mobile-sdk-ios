//
//  JMEndpoint.h
//
//  Copyright © 2018 Jumio Corporation. All rights reserved.
//

#import <Foundation/Foundation.h>

__attribute__((visibility("default"))) @interface JMEndpoint : NSObject <NSCopying>

@property (nonatomic, strong) NSString* name;
@property (nonatomic, strong) NSString* url;
@property (nonatomic, strong) NSString* apiToken;
@property (nonatomic, strong) NSString* apiSecret;
@property (nonatomic, strong) NSString* publicKeyALE;
@property (nonatomic, strong) NSString* publicKeyIdALE;
@property (nonatomic, assign, getter=isProduction) BOOL production;
@property (nonatomic, assign, getter=isHardcoded) BOOL hardcoded;
@property (nonatomic, assign) BOOL selected;
@property (nonatomic, assign) JumioDataCenter dataCenter;
@property (nonatomic, strong, readonly) NSString* hostname;


- (instancetype)initWithDataCenter:(JumioDataCenter)dataCenter;

- (NSDictionary *) endpointDescription;

- (NSString *)nameForDataCenter:(JumioDataCenter)dataCenter;
- (NSString*)URLForDataCenter:(JumioDataCenter)dataCenter;
- (NSString*)publicKeyIdForDataCenter:(JumioDataCenter)dataCenter;
- (NSString*)publicKeyForDataCenter:(JumioDataCenter)dataCenter;


@end
