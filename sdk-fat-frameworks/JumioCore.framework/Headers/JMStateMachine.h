//
//  JMStateMachine.h
//
//  Copyright © 2016 Jumio Corporation All rights reserved.
//

#import <Foundation/Foundation.h>

@class JMState;
@class JMBaseState;
@class JMStateTransition;
@class JMStateTransitionEvent;

@interface JMStateMachine : NSObject

@property (nonatomic, strong, readonly) JMBaseState*        initialState;
@property (nonatomic, strong)           JMBaseState*        currentState;
@property (nonatomic, assign, readonly) BOOL                isActive;
@property (nonatomic, strong, readonly) NSRecursiveLock*    fireEventLock;

+ (instancetype)stateMachine;

- (BOOL)canFireEventWithName:(NSString*)eventName;
- (BOOL)fireEventWithName:(NSString*)eventName;

- (void)addState:(JMBaseState*)state;
- (void)removeState:(JMBaseState*)state;

- (void)activate;
- (void)reset;
- (void)cleanUp;
- (void)resetToStateWithName:(NSString*)stateName;

- (JMStateTransition*)transitionWithEventName:(NSString*)name;

- (BOOL) isCurrentStateName:(NSString *)name;
- (JMState *)stateWithName:(NSString *)name;
- (NSSet*)allStates;

@end
