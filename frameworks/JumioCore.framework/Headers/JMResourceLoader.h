//
//  ResourceLoader.h
//
//  Copyright © 2018 Jumio Corporation. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <JumioCore/JMSDK.h>

#define SharedResourceLoader [JMResourceLoader sharedInstance]

__attribute__((visibility("default"))) @interface JMResourceLoader : NSObject

+ (JMResourceLoader *)sharedInstance;

- (UIImage*)getImageWithName:(NSString*)imageName bundle:(NSBundle*)bundleName;
- (NSData *)getFontWithName:(NSString *)name bundle:(NSBundle*)bundle;
- (NSString *)getOCRRootPathForBundle:(NSBundle*)bundle;
- (NSDictionary *) getPlistFromBundle:(NSBundle*)bundle;

+ (NSString*) suffixForImagesDependingOnDeviceScreenScale;

+ (UIImage*) imageResourceWithName: (NSString*) imageName;

@end
