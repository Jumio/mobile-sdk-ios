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

@property (nonatomic, strong) NSString *selectedCountry;
@property (nonatomic, assign) NetverifyDocumentType selectedDocumentType;

//ID
@property (nonatomic, strong) NSString *idNumber;
@property (nonatomic, strong) NSString *personalNumber;
@property (nonatomic, strong) NSDate *issuingDate;
@property (nonatomic, strong) NSDate *expiryDate;
@property (nonatomic, strong) NSString *issuingCountry;
@property (nonatomic, strong) NSString *optionalData1;
@property (nonatomic, strong) NSString *optionalData2;

//Person
@property (nonatomic, strong) NSString *lastName;
@property (nonatomic, strong) NSString *firstName;
@property (nonatomic, strong) NSString *middleName;
@property (nonatomic, strong) NSDate *dob;
@property (nonatomic, assign) NetverifyGender gender;
@property (nonatomic, strong) NSString *originatingCountry;

//Address
@property (nonatomic, strong) NSString *addressLine;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *subdivision;
@property (nonatomic, strong) NSString *postCode;

@property (nonatomic, assign) NetverifyExtractionMethod extractionMethod;

// Raw MRZ data
@property (nonatomic, strong) NetverifyMrzData *mrzData;

@end
