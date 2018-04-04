//
//  NetverifyCountry.h
//
//  Copyright © 2018 Jumio Corporation. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NetverifyDocument;

/**
 * @class NetverifyCountry
 * @brief Object that holds the country information and the available NetverifyDocuments for this country. It will only contain the countries with at least one available document. If a country is preselected in NetverifyConfiguration only one NetverifyCountry will be returned via netverifyUIController:didDetermineAvailableCountries:suggestedCountry:.
 **/
__attribute__((visibility("default"))) @interface NetverifyCountry : NSObject

/**
 * The ISO 3166-1 Alpha 3 code
 **/
@property (strong, nonatomic, readonly) NSString* _Nonnull code;

/**
 * The localized country name according to the locale of the device.
 **/
@property (strong, nonatomic, readonly) NSString* _Nonnull name;

/**
 * Array contains NetverifyDocument ojects. Use this to display the available documents for this country.
 * It will only contain the documents valid with the preselection in NetverifyConfiguration.
 **/
@property (nonnull, strong, nonatomic, readonly) NSArray<NetverifyDocument*>* documents;

@end
