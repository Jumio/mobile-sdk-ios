//
//  JMNetworkState.h
//
//  Copyright © 2016 Jumio Corporation All rights reserved.
//

#import "JMState.h"


@protocol JMNetworkStateImplementation <NSObject>

@required
- (void) willEnterStatePendingBlockImplementation;
- (void) didEnterStateErrorBlock;
- (void) didEnterStateSucessBlock;

@end


@interface JMNetworkState : JMState <NSCopying>

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
