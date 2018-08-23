//
//  JMBaseState.h
//
//  Copyright © 2018 Jumio Corporation. All rights reserved.
//

#import <Foundation/Foundation.h>

@class JMStateMachine;
@class JMStateTransition;

__attribute__((visibility("default"))) @interface JMBaseState : NSObject <NSCopying>

@property (nonatomic, strong, readonly) NSString*       name;
@property (nonatomic, weak)             JMStateMachine* stateMachine;

@property (nonatomic, strong) void (^willEnterStateBlock)(JMStateTransition *);
@property (nonatomic, strong) void (^didEnterStateBlock)(JMStateTransition *);
@property (nonatomic, strong) void (^willExitStateBlock)(JMStateTransition *);
@property (nonatomic, strong) void (^didExitStateBlock)(JMStateTransition *);

- (instancetype)initWithName:(NSString*)name;

- (void) cleanUp;

@end
