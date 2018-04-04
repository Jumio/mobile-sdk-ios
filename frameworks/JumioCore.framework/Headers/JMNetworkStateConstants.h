//
//  JMNetworkStateConstants.h
//
//  Copyright © 2018 Jumio Corporation. All rights reserved.
//

#import <Foundation/Foundation.h>

//State Constant(s)
extern __attribute__((visibility("default"))) NSString* const kJMNetworkStateIdleState;
extern __attribute__((visibility("default"))) NSString* const kJMNetworkStatePendingState;
extern __attribute__((visibility("default"))) NSString* const kJMNetworkStateErrorState;
extern __attribute__((visibility("default"))) NSString* const kJMNetworkStateSuccessState;

//Transition Constant(s)
extern __attribute__((visibility("default"))) NSString* const kJMNetworkStateTransitionPending;
extern __attribute__((visibility("default"))) NSString* const kJMNetworkStateTransitionError;
extern __attribute__((visibility("default"))) NSString* const kJMNetworkStateTransitionSuccess;

//Transition Event Constant(s)
extern __attribute__((visibility("default"))) NSString* const kJMNetworkStateTransitionEventToPending;
extern __attribute__((visibility("default"))) NSString* const kJMNetworkStateTransitionEventToError;
extern __attribute__((visibility("default"))) NSString* const kJMNetworkStateTransitionEventToSuccess;
