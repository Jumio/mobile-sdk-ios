//
//  ObjcExceptionHelper.h
//
//  Copyright © 2018 Jumio Corporation. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ObjcExceptionHelper: NSObject

+ (BOOL)catchException:(void(^)(void))tryBlock error:(__autoreleasing NSError **)error;

@end
