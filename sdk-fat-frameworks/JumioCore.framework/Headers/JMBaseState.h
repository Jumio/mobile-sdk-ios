//
//  JMBaseState.h
//
//  Copyright © 2016 Jumio Corporation All rights reserved.
//

#import <Foundation/Foundation.h>

@class JMStateMachine;
@class JMStateTransition;

@interface JMBaseState : NSObject <NSCopying>

@property (nonatomic, strong, readonly) NSString*       name;
@property (nonatomic, weak)             JMStateMachine* stateMachine;

@property (nonatomic, copy) void (^willEnterStateBlock)(JMStateTransition *);
@property (nonatomic, copy) void (^didEnterStateBlock)(JMStateTransition *);
@property (nonatomic, copy) void (^willExitStateBlock)(JMStateTransition *);
@property (nonatomic, copy) void (^didExitStateBlock)(JMStateTransition *);


- (instancetype)initWithName:(NSString*)name;

@end
