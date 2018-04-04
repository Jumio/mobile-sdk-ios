//
//  NetverifyMrzData.h
//
//  Copyright © 2018 Jumio Corporation. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef enum {
    NetverifyMRZFormatUnknown = 0,
    NetverifyMRZFormatMRP,
    NetverifyMRZFormatMRVA,
    NetverifyMRZFormatMRVB,
    NetverifyMRZFormatTD1,
    NetverifyMRZFormatTD2,
    NetverifyMRZFormatCNIS
} NetverifyMRZFormat;

__attribute__((visibility("default"))) @interface NetverifyMrzData : NSObject

@property (nonatomic, strong) NSString *line1;
@property (nonatomic, strong) NSString *line2;
@property (nonatomic, strong) NSString *line3;
@property (nonatomic, assign) NetverifyMRZFormat format;

- (BOOL) idNumberValid;
- (BOOL) dobValid;
- (BOOL) expiryDateValid;
- (BOOL) personalNumberValid;
- (BOOL) compositeValid;

@end
