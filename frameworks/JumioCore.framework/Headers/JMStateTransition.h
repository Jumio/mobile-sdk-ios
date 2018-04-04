//
//  JMStateTransition.h
//
//  Copyright © 2018 Jumio Corporation. All rights reserved.
//

#import <Foundation/Foundation.h>

@class JMBaseState;
@class JMStateTransitionEvent;

__attribute__((visibility("default"))) @interface JMStateTransition : NSObject <NSCopying>
@property (nonatomic, strong, readonly) NSString*               name;
@property (nonatomic, strong, readonly) JMBaseState*            targetState;
@property (nonatomic, strong, readonly) JMBaseState*            sourceState;
@property (nonatomic, strong, readonly) JMStateTransitionEvent* event;

+ (instancetype)transitionWithName:(NSString*)name sourceState:(JMBaseState*)sourceState targetState:(JMBaseState*)targetState event:(JMStateTransitionEvent*)event;
+ (instancetype)resetTransitionFromSourceState:(JMBaseState*)sourceState targetState:(JMBaseState*)targetState;

- (BOOL)isResetTransition;

@end
