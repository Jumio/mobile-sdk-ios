//
//  NetverifyDocumentData.h
//
//  Copyright © 2016 Jumio Corporation All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Netverify/NetverifyMrzData.h>

typedef enum {
    NetverifyDocumentTypeAll                = 0,
    NetverifyDocumentTypePassport           = 1 << 0,
    NetverifyDocumentTypeDriverLicense      = 1 << 1,
    NetverifyDocumentTypeIdentityCard       = 1 << 2,
    NetverifyDocumentTypeVisa               = 1 << 3
} NetverifyDocumentType;

typedef enum {
    NetverifyGenderUnknown,
    NetverifyGenderM,
    NetverifyGenderF
} NetverifyGender;

typedef enum {
    NetverifyDocumentVariantUnknown = 0,
    NetverifyDocumentVariantPaper,
    NetverifyDocumentVariantPlastic
} NetverifyDocumentVariant;

typedef enum {
    NetverifyExtractionMethodMRZ,
    NetverifyExtractionMethodOCR,
    NetverifyExtractionMethodBarcode,
    NetverifyExtractionMethodBarcodeOCR,
    NetverifyExtractionMethodNone,
} NetverifyExtractionMethod;

@interface NetverifyDocumentData : NSObject {
    
}

@property (nonatomic, strong, nonnull) NSString *selectedCountry;
@property (nonatomic, assign) NetverifyDocumentType selectedDocumentType;

//ID
@property (nonatomic, strong, nullable) NSString *idNumber;
@property (nonatomic, strong, nullable) NSString *personalNumber;
@property (nonatomic, strong, nullable) NSDate *issuingDate;
@property (nonatomic, strong, nullable) NSDate *expiryDate;
@property (nonatomic, strong, nullable) NSString *issuingCountry;
@property (nonatomic, strong, nullable) NSString *optionalData1;
@property (nonatomic, strong, nullable) NSString *optionalData2;

//Person
@property (nonatomic, strong, nullable) NSString *lastName;
@property (nonatomic, strong, nullable) NSString *firstName;
@property (nonatomic, strong, nullable) NSString *middleName;
@property (nonatomic, strong, nullable) NSDate *dob;
@property (nonatomic, assign) NetverifyGender gender;
@property (nonatomic, strong, nullable) NSString *originatingCountry;

//Address
@property (nonatomic, strong, nullable) NSString *addressLine;
@property (nonatomic, strong, nullable) NSString *city;
@property (nonatomic, strong, nullable) NSString *subdivision;
@property (nonatomic, strong, nullable) NSString *postCode;

@property (nonatomic, assign) NetverifyExtractionMethod extractionMethod;

// Raw MRZ data
@property (nonatomic, strong, nullable) NetverifyMrzData *mrzData;

@property (nonatomic, strong, nullable) UIImage* frontImage;
@property (nonatomic, strong, nullable) UIImage* backImage;
@property (nonatomic, strong, nullable) UIImage* faceImage;

@end
