//
//  NetverifyDocument.h
//
//  Copyright © 2018 Jumio Corporation. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NetverifyDocumentData.h"

/**
 * @class NetverifyDocument
 * @brief Holds the specific information about a document. 
 **/
__attribute__((visibility("default"))) @interface NetverifyDocument : NSObject

/**
 * The ISO 3166-1 Alpha 3 code
 **/
@property (nonatomic, strong, readonly) NSString *countryCode;

/**
 * The type of the document
 **/
@property (nonatomic, assign, readonly) NetverifyDocumentType type;

/**
 * A NetverifyDocument can have two variants. Set the selectedVariant to the one you'd like to use for scanning. Via supportsPaperVariant you can check if paperVariant is available for this document. Default: NetverifyDocumentVariantPlastic
 **/
@property (nonatomic, assign) NetverifyDocumentVariant selectedVariant;

/**
 * @returns if this document can scan a paper like document.
 **/
- (BOOL) supportsPaperVariant;

/**
 * @returns if this document can scan a plastic document.
 **/
- (BOOL) supportsPlasticVariant;

/**
 * @returns if this document has more than one variant.
 **/
- (BOOL) hasMultipleVariants;

@end
