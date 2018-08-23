//
//  NetverifyMrzData.h
//
//  Copyright © 2018 Jumio Corporation. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 * Defines the format of the MRZ Code
 **/
typedef NS_ENUM(NSUInteger, NetverifyMRZFormat) {
    /** Unknown MRZ format */
    NetverifyMRZFormatUnknown = 0,
    /** MRP format */
    NetverifyMRZFormatMRP,
    /** MRVA format */
    NetverifyMRZFormatMRVA,
    /** MRVB format */
    NetverifyMRZFormatMRVB,
    /** TD1 format */
    NetverifyMRZFormatTD1,
    /** TD2 format */
    NetverifyMRZFormatTD2,
    /** CNIS format */
    NetverifyMRZFormatCNIS
};

/**
 * Result object that is returned in case of a successful scan within NetverifyDocumentData that holds more detailed information about the MRZ document.
 **/
__attribute__((visibility("default"))) @interface NetverifyMrzData : NSObject

/**
 * MRZ line 1 (max. length 50)
 **/
@property (nonatomic, strong) NSString *line1;

/**
 * MRZ line 2 (max. length 50)
 **/
@property (nonatomic, strong) NSString *line2;

/**
 * MRZ line 3 (max. length 50)
 **/
@property (nonatomic, strong) NSString *line3;

/**
 * Format of the MRZ Document
 **/
@property (nonatomic, assign) NetverifyMRZFormat format;

/**
 * Method to retrieve information if ID number check digit is valid
 * @return True if valid, otherwise false
 **/
- (BOOL) idNumberValid;

/**
 * Method to retrieve information if date of birth check digit is valid
 * @return True if valid, otherwise false
 **/
- (BOOL) dobValid;

/**
 * Method to retrieve information if expiry date check digit is valid
 * @return True if valid, otherwise false
 **/
- (BOOL) expiryDateValid;

/**
 * Method to retrieve information if personal number check digit is valid
 * @return True if valid, otherwise false
 **/
- (BOOL) personalNumberValid;

/**
 * Method to retrieve information if compositer check digit is valid
 * @return True if valid, otherwise false
 **/
- (BOOL) compositeValid;

@end
