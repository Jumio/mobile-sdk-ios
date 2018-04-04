//
//  JMNetworkState.h
//
//  Copyright © 2018 Jumio Corporation. All rights reserved.
//

#import "JMState.h"


__attribute__((visibility("default"))) @protocol JMNetworkStateImplementation <NSObject>

@required
- (void) willEnterStatePendingBlockImplementation;
- (void) didEnterStateErrorBlock;
- (void) didEnterStateSucessBlock;

@end


__attribute__((visibility("default"))) @interface JMNetworkState : JMState <NSCopying>

@property (nonatomic, assign, readonly) BOOL isCanceled;

- (void)executeTask;

- (void)didFailTask;

- (void)cancel;
- (void)reset;

- (void) initStateMachine;

- (NSString *) baseURL;
- (NSString *) merchantApiToken;
- (NSString *) merchantApiSecret;

- (BOOL) isCurrentStatusSuccess;
- (BOOL) isCurrentStatusError;
- (BOOL) isExecutable;

@end
