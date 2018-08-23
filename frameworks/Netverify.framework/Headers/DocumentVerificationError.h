//
//  DocumentVerificationError.h
//
//  Copyright © 2018 Jumio Corporation. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Netverify/NetverifyError.h>

/**
 * Model class that describes an error situation with a code and a message. Please always include the whole code when filing an error related issue to our support team.  Please find more information in our Mobile SDK Github Guides at https://github.com/Jumio/mobile-sdk-ios/blob/master/docs/integration_document-verification.md#error .
 **/
__attribute__((visibility("default"))) @interface DocumentVerificationError : NSObject

/**
 * A 6-digit alpha-numeric code. The first letter (A-Z) represents the error case. The remaining characters are represented by numbers that contain information helping us understand the problem situation.
 **/
@property (nonatomic, strong, readonly) NSString* code;

/**
 * The human readable localized description. Localization can be adapted in our Localizable-Netverify.strings and it's translations.
 **/
@property (nonatomic, strong, readonly) NSString* message;

@end
