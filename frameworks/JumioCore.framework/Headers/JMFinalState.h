//
//  JMFinalState.h
//
//  Copyright © 2018 Jumio Corporation. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JMState.h"

__attribute__((visibility("default"))) @interface JMFinalState : JMState

+ (instancetype)finalStateWithName:(NSString*)name;

@end
