//
//  BAMCheckoutCardInformation.h
//
//  Copyright © 2018 Jumio Corporation. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * Defines which creditcard was scanned
 **/
typedef NS_ENUM(NSUInteger, BAMCheckoutCreditCardType) {
    /** All CreditCard Types */
    BAMCheckoutCreditCardTypeAll               = 0,
    /** Visa Credit Card */
    BAMCheckoutCreditCardTypeVisa              = 1 << 0,
    /** MasterCard Credit Card */
    BAMCheckoutCreditCardTypeMasterCard        = 1 << 1,
    /** AmericanExpress Credit Card */
    BAMCheckoutCreditCardTypeAmericanExpress   = 1 << 2,
    /** Diners Credit Card */
    BAMCheckoutCreditCardTypeDiners            = 1 << 3,
    /** Discover Credit Card */
    BAMCheckoutCreditCardTypeDiscover          = 1 << 4,
    /** JCB Credit Card */
    BAMCheckoutCreditCardTypeJCB               = 1 << 5,
    /** ChinaUnionPay Credit Card */
    BAMCheckoutCreditCardTypeChinaUnionPay     = 1 << 6
};


/**
 * Defines which credit cards are supported
 **/
typedef NSUInteger BAMCheckoutCreditCardTypes;

/**
 * Contains card details returned by a BAMCheckout Scan.
 */
__attribute__((visibility("default"))) @interface BAMCheckoutCardInformation : NSObject {}

/**
 * The card type
 **/
@property (nonatomic, assign) BAMCheckoutCreditCardType cardType;

/**
 * The card number in the format 1234567812345678
 **/
@property (nonatomic, strong, nonnull) NSMutableString *cardNumber;

/**
 * The card number in grouped style (e.g. 1234 5678 1234 5678)
 **/
@property (nonatomic, strong, nonnull) NSMutableString *cardNumberGrouped;

/**
 * The card number in masked style (e.g. 1234 56** **34 5678)
 **/
@property (nonatomic, strong, nonnull) NSMutableString *cardNumberMasked;

/**
 *  The expiry date of the card in the format 'MM/yy' (e.g. '01/12')
 **/
@property (nonatomic, strong, nullable) NSMutableString *cardExpiryDate;

/**
 * The expiry month of the card in the format 'MM' (e.g. '01')
 **/
@property (nonatomic, strong, nullable) NSMutableString *cardExpiryMonth;

/**
 *  The expiry year of the card in the format 'MM' (e.g. '12')
 **/
@property (nonatomic, strong, nullable) NSMutableString *cardExpiryYear;

/**
 * The CVV code of the card
 **/
@property (nonatomic, strong, nullable) NSMutableString *cardCVV;

/**
 * The name of the cardHolder
 **/
@property (nonatomic, strong, nullable) NSMutableString *cardHolderName;

/**
 * The UK account number
 **/
@property (nonatomic, strong, nullable) NSMutableString *cardAccountNumber;

/**
 * The UK sort code
 **/
@property (nonatomic, strong, nullable) NSMutableString *cardSortCode;

/**
 * Gives information if the card sort code is valid
 **/
@property (nonatomic, assign) BOOL cardSortCodeValid;

/**
 * Gives information if the card account number is valid
 **/
@property (nonatomic, assign) BOOL cardAccountNumberValid;

/**
 Retrieve the value of a custom field by its field identifier.
 */
- (NSString* _Nullable) getCustomField: (NSString* _Nonnull) fieldId;

/**
 Clear all values to prevent sensitive data to be captured.
 */
- (void) clear;

@end
