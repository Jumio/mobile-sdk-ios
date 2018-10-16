//
//  NetverifyDocumentData.h
//
//  Copyright © 2018 Jumio Corporation. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Netverify/NetverifyMrzData.h>

/**
 * Document Type used for preselection and extraction
 **/
typedef NS_OPTIONS(NSUInteger, NetverifyDocumentType) {
    /** All documents should be used */
    NetverifyDocumentTypeAll                = 0,
    /** Passport */
    NetverifyDocumentTypePassport           = 1 << 0,
    /** Driver License */
    NetverifyDocumentTypeDriverLicense      = 1 << 1,
    /** Identiy Card */
    NetverifyDocumentTypeIdentityCard       = 1 << 2,
    /** Visa */
    NetverifyDocumentTypeVisa               = 1 << 3
};

/**
 * Extracted gender information
 **/
typedef NS_ENUM(NSUInteger, NetverifyGender) {
    /** Gender was not extracted */
    NetverifyGenderUnknown,
    /** Gender male */
    NetverifyGenderM,
    /** Gender female */
    NetverifyGenderF,
    /** Gender unspecified */
    NetverifyGenderX
};

/**
 * Defines if plastic or paper document
 **/
typedef NS_ENUM(NSUInteger, NetverifyDocumentVariant) {
    /** Undefined document style */
    NetverifyDocumentVariantUnknown = 0,
    /** Paper style document */
    NetverifyDocumentVariantPaper,
    /** Plastic style document */
    NetverifyDocumentVariantPlastic
};

/**
 * Extraction method used to extract data
 **/
typedef NS_ENUM(NSUInteger, NetverifyExtractionMethod) {
    /** MRZ extraction method */
    NetverifyExtractionMethodMRZ,
    /** OCR extraction method */
    NetverifyExtractionMethodOCR,
    /** Barcode extraction method */
    NetverifyExtractionMethodBarcode,
    /** Barcode and OCR extraction method */
    NetverifyExtractionMethodBarcodeOCR,
    /** No extraction method is specified */
    NetverifyExtractionMethodNone,
};


/**
 * Result object that is returned in case of a successful scan that holds information that was extracted during scanning.
 **/
__attribute__((visibility("default"))) @interface NetverifyDocumentData : NSObject {
    
}

/**
 * ISO 3166-1 alpha-3 country code as provided or selected during the scanning process.
 * Attention: this can differ from the issuingContry as the country of the document and the country selected during the ui process don't need to be the same.
 **/
@property (nonatomic, strong, nonnull) NSString *selectedCountry;

/**
 * Enum that defines the selected document type during the scanning process. Can be Passport, DriverLicense, IdentityCard and Visa
 **/
@property (nonatomic, assign) NetverifyDocumentType selectedDocumentType;

/**
 * Identification number of the document
 **/
@property (nonatomic, strong, nullable) NSString *idNumber;

/**
 * Personal number of the document
 **/
@property (nonatomic, strong, nullable) NSString *personalNumber;

/**
 * Date of issue of the document that was extracted during scanning
 **/
@property (nonatomic, strong, nullable) NSDate *issuingDate;

/**
 * Date of expiry of the document that was extracted during scanning
 **/
@property (nonatomic, strong, nullable) NSDate *expiryDate;

/**
 * ISO 3166-1 alpha-3 country code of the issuing country of the document that was extracted during scanning.
 * Attention: this can differ from the selectedCountry as the country of the document and the country selected during the ui process don't need to be the same.
 **/
@property (nonatomic, strong, nullable) NSString *issuingCountry;

/**
 * Optional field of MRZ line 1
 **/
@property (nonatomic, strong, nullable) NSString *optionalData1;

/**
 * Optional field of MRZ line 2
 **/
@property (nonatomic, strong, nullable) NSString *optionalData2;

//Person
/**
 * Last name extracted from the document.
 **/
@property (nonatomic, strong, nullable) NSString *lastName;

/**
 * First name extracted from the document.
 **/
@property (nonatomic, strong, nullable) NSString *firstName;

/**
 * Date of birth extracted from the document.
 **/
@property (nonatomic, strong, nullable) NSDate *dob;

/**
 * Enum of gender extracted from the document. Gender M, F, or X
 **/
@property (nonatomic, assign) NetverifyGender gender;

/**
 * ISO 3166-1 alpha-3 country code of origin.
 **/
@property (nonatomic, strong, nullable) NSString *originatingCountry;

//Address
/**
 * Street name extracted from the document.
 **/
@property (nonatomic, strong, nullable) NSString *addressLine;

/**
 * City extracted from the document.
 **/
@property (nonatomic, strong, nullable) NSString *city;

/**
 * Last three characters of ISO 3166-2:US or ISO 3166-2:CA subdivision code
 **/
@property (nonatomic, strong, nullable) NSString *subdivision;

/**
 * Postal code extracted from the document.
 **/
@property (nonatomic, strong, nullable) NSString *postCode;

/**
 * Extraction method used during scanning (MRZ, OCR, BARCODE, BARCODE_OCR or NONE)
 **/
@property (nonatomic, assign) NetverifyExtractionMethod extractionMethod;

// Raw MRZ data
/**
 * Object further describing information about the MRZ Code extracted from the document.
 **/
@property (nonatomic, strong, nullable) NetverifyMrzData *mrzData;

/**
 * Frontside image of the scanned document. Only will be retrieved when offline token is set and server cannot be reached.
 **/
@property (nonatomic, strong, nullable) UIImage* frontImage;

/**
 * Backside image of the scanned document. Only will be retrieved when offline token is set and server cannot be reached.
 **/
@property (nonatomic, strong, nullable) UIImage* backImage;

/**
 * Face image only will be retrieved when offline token is set and server cannot be reached.
 **/
@property (nonatomic, strong, nullable) UIImage* faceImage;

@end
