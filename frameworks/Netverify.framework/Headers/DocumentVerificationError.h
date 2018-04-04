//
//  DocumentVerificationError.h
//
//  Copyright © 2018 Jumio Corporation. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Netverify/NetverifyError.h>

__attribute__((visibility("default"))) @interface DocumentVerificationError : NSObject

@property (nonatomic, strong, readonly) NSString* code;
@property (nonatomic, strong, readonly) NSString* message;

@end
