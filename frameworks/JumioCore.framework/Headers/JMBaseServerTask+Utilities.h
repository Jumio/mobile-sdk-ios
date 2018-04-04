//
//  NMBaseServerTask+Utilities.h
//
//  Copyright © 2018 Jumio Corporation. All rights reserved.
//

#import "JMBaseServerTask.h"

__attribute__((visibility("default"))) @interface JMBaseServerTask (Utilities)

- (NSString *)stringFromHTTPMethod:(HTTPMethod)method;
- (NSString *)contentTypeString:(ContentType)contentType;
- (NSString *)stringFromContentType:(ContentType)accept;

- (void)addObject:(id)aObject forKey:(id<NSCopying>)aKey toDictionary:(NSMutableDictionary*)aDictionary;
- (NSArray*)createURLQueryFromParameters:(NSDictionary*)parameters;
- (NSURL *)createURLwithBaseURL:(NSString*)baseURL URLPath:(NSString*)urlPath parameters:(NSDictionary*)parameters;
- (NSString *) formatString: (NSString *) string forMaximumLength: (NSUInteger) maxLength;


@end
