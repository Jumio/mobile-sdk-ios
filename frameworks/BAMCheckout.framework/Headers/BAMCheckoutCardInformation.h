//
//  BAMCheckoutCardInformation.h
//
//  Copyright © 2018 Jumio Corporation. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    BAMCheckoutCreditCardTypeAll               = 0,
    BAMCheckoutCreditCardTypeVisa              = 1 << 0,
    BAMCheckoutCreditCardTypeMasterCard        = 1 << 1,
    BAMCheckoutCreditCardTypeAmericanExpress   = 1 << 2,
    BAMCheckoutCreditCardTypeDiners            = 1 << 3,
    BAMCheckoutCreditCardTypeDiscover          = 1 << 4,
    BAMCheckoutCreditCardTypeJCB               = 1 << 5,
    BAMCheckoutCreditCardTypeChinaUnionPay     = 1 << 6,
    BAMCheckoutCreditCardTypeStarbucks         = 1 << 7
} BAMCheckoutCreditCardType;

typedef NSUInteger BAMCheckoutCreditCardTypes;
typedef NSUInteger BAMCheckoutUserInterfaceOrientations;

/**
 @class BAMCheckoutCardInformation
 @brief Contains card details returned by a BAMCheckout Scan.
 */
__attribute__((visibility("default"))) @interface BAMCheckoutCardInformation : NSObject {}

@property (nonatomic, assign) BAMCheckoutCreditCardType cardType;      // The card type

@property (nonatomic, strong, nonnull) NSMutableString *cardNumber;                 // The card number in the format 1234567812345678
@property (nonatomic, strong, nonnull) NSMutableString *cardNumberGrouped;          // The card number in grouped style (e.g. 1234 5678 1234 5678)
@property (nonatomic, strong, nonnull) NSMutableString *cardNumberMasked;           // The card number in masked style (e.g. 1234 56** **34 5678)

@property (nonatomic, strong, nullable) NSMutableString *cardExpiryDate;             // The expiry date of the card in the format 'MM/yy' (e.g. '01/12')
@property (nonatomic, strong, nullable) NSMutableString *cardExpiryMonth;            // The expiry month of the card in the format 'MM' (e.g. '01')
@property (nonatomic, strong, nullable) NSMutableString *cardExpiryYear;             // The expiry year of the card in the format 'MM' (e.g. '12')

@property (nonatomic, strong, nullable) NSMutableString *cardCVV;                    // The CVV code of the card

@property (nonatomic, strong, nullable) NSMutableString *cardHolderName;             // The name of the cardHolder
@property (nonatomic, strong, nullable) NSMutableString *cardAccountNumber;          // The UK account number
@property (nonatomic, strong, nullable) NSMutableString *cardSortCode;               // The UK sort code

@property (nonatomic, assign) BOOL cardSortCodeValid;                      // The card sort code is valid
@property (nonatomic, assign) BOOL cardAccountNumberValid;                 // The card account number is valid

/**
 Retrieve the value of a custom field by its field identifier.
 */
- (NSString* _Nullable) getCustomField: (NSString* _Nonnull) fieldId;

/**
 Clear all values to prevent sensitive data to be captured.
 */
- (void) clear;

@end
