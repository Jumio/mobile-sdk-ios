//
//  JMRequestLogInfo.h
//
//  Copyright © 2018 Jumio Corporation. All rights reserved.
//

#import <Foundation/Foundation.h>

__attribute__((visibility("default"))) @interface JMServerTaskLogInfo : NSObject

@property (nonatomic, strong) Class     taskClass;
@property (nonatomic,   copy) NSString* httpBody;
@property (nonatomic, strong) NSData*   data;
@property (nonatomic, assign) long      executionTime;
@property (nonatomic, assign) NSInteger statusCode;
@property (nonatomic, strong) NSError*  error;

- (void)reset;

@end
