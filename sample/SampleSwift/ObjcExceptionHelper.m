//
//  ObjcExceptionHelper.m
//
//  Copyright © 2019 Jumio Corporation. All rights reserved.
//

#import "ObjcExceptionHelper.h"

@implementation ObjcExceptionHelper

+ (BOOL)catchException:(void(^)(void))tryBlock error:(__autoreleasing NSError **)error {
    @try {
        tryBlock();
        return YES;
    }
    @catch (NSException *exception) {
        *error = [[NSError alloc] initWithDomain:exception.name code:0 userInfo:@{NSLocalizedFailureReasonErrorKey: exception.reason}];
        return NO;
    }
}

@end
