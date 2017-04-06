//
//  JMString.h
//
//  Copyright © 2016 Jumio Corporation All rights reserved.
//

#import <Foundation/Foundation.h>

#define kJMContentVoidingForStringsNotification @"JMContentVoidingForStringsNotification"

@interface JMString : NSObject

@property (nonatomic, strong) NSMutableString* mutableString;

- (id) initWithString:(NSString *)aString;
- (id) init;

- (void) appendString:(NSString *)aString;
- (void)deleteCharactersInRange:(NSRange)aRange;
- (void)insertString:(NSString *)aString atIndex:(NSUInteger)anIndex;
- (void)replaceCharactersInRange:(NSRange)aRange withString:(NSString *)aString;
- (NSUInteger)replaceOccurrencesOfString:(NSString *)target withString:(NSString *)replacement options:(NSStringCompareOptions)opts range:(NSRange)searchRange;
- (void)setString:(NSString *)aString;

@end
