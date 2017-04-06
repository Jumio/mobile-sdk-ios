//
//  JMState.h
//
//  Copyright © 2016 Jumio Corporation All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JMBaseState.h"


@class JMStateTransition;
@class JMStateMachine;
@class JMStateTransitionEvent;

@interface JMState : JMBaseState <NSCopying>

@property (nonatomic, assign, getter=isRequired) BOOL required;

- (void)addTransition:(JMStateTransition*)transition;
- (void)addTransitionToTarget:(JMBaseState*)targetState withName:(NSString*)name forEvent:(JMStateTransitionEvent*)event;
- (void)removeTransition:(JMStateTransition*)transition;

- (NSSet* const)transitionsSet;

+ (instancetype)stateWithName:(NSString*) name;


@end
