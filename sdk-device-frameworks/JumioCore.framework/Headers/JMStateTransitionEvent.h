//
//  JMStateTransitionEvent.h
//
//  Copyright © 2016 Jumio Corporation All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JMStateTransitionEvent : NSObject <NSCopying>
@property (nonatomic, strong, readonly) NSString* name;

+ (instancetype)transitionEventWithName:(NSString*)name;

@end
