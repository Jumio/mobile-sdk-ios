//
//  JMOfflineTManager.h
//
//  Copyright © 2017 Jumio Corporation. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JMOfflineManager : NSObject

@property (nonatomic, strong) NSString* token;
@property (nonatomic, assign) BOOL tokenProvided;             // Just indicates if token was set
@property (nonatomic, assign) BOOL tokenVerified;             // Indicates if token signature was verified and json payload could be parsed
@property (nonatomic, assign) BOOL offlineModeActivated;      // True if offlineToken verification succeeded, expiry date not reached and bundle identifier matches
@property (nonatomic, assign) BOOL brandingEnabled;
@property (nonatomic, assign) BOOL expired;
@property (nonatomic, strong) NSDate* expirationDate;
@property (nonatomic, strong) NSString* bundleIdentifier;
@property (nonatomic, assign) BOOL bundleIdentifierInvalid;

- (void) reset;

- (NSDictionary*) dictionaryFromPayload: (NSString*) payload;

@end
