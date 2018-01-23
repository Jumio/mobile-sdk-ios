//
//  ObjcExceptionHelper.h
//
//  Copyright © 2017 Jumio Corporation. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ObjcExceptionHelper: NSObject

+ (BOOL)catchException:(void(^)(void))tryBlock error:(__autoreleasing NSError **)error;

@end
