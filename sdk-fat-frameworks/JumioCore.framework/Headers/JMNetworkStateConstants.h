//
//  JMNetworkStateConstants.h
//
//  Copyright © 2016 Jumio Corporation All rights reserved.
//

#import <Foundation/Foundation.h>

//State Constant(s)
extern NSString* const kJMNetworkStateIdleState;
extern NSString* const kJMNetworkStatePendingState;
extern NSString* const kJMNetworkStateErrorState;
extern NSString* const kJMNetworkStateSuccessState;

//Transition Constant(s)
extern NSString* const kJMNetworkStateTransitionPending;
extern NSString* const kJMNetworkStateTransitionError;
extern NSString* const kJMNetworkStateTransitionSuccess;

//Transition Event Constant(s)
extern NSString* const kJMNetworkStateTransitionEventToPending;
extern NSString* const kJMNetworkStateTransitionEventToError;
extern NSString* const kJMNetworkStateTransitionEventToSuccess;
