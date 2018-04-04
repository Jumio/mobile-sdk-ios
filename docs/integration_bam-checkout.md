![BAM Checkout](images/bam_checkout.png)

# BAM Checkout SDK for iOS
BAM Checkout is a powerful, cutting-edge solution to extract data from your customer´s credit card and / or ID in your mobile application within seconds, including home address. It fits perfectly, and fully automates, every checkout flow to avoid manual input at all which leads to an increased conversion rate.

## Table of Content

- [Release notes](#release-notes)
- [Initialization](#initialization)
- [Configuration](#configuration)
- [Localization](#localization)
- [Customization](#customization)
- [Delegation](#delegation)

## Release notes
For technical changes, please read our [transition guide](transition-guide_bam-checkout.md) SDK version: 2.11.0.

## Setup
The [basic setup](../README.md#basic-setup) is required before continuing with the following setup for BAM Checkout.

## Initialization
Log into your Jumio Customer Portal and you can find your API token and API secret on the "Settings" page under "API credentials". We strongly recommend to store credentials outside your app. In case the token and secret are not set in the `BAMCheckoutConfiguration` object, an exception will be thrown. Please note that in Swift you need to catch the underlying exception and translate it into a `NSError` instance. Whenever an exception is thrown, the `BAMCheckoutViewController` instance will be nil and the SDK is not usable. Make sure that all necessary configuration is set before the `BAMCheckoutConfiguration` instance is passed to the initializer.

```
BAMCheckoutConfiguration *config = [BAMCheckoutConfiguration new];
config.merchantApiToken = @"YOURAPITOKEN";
config.merchantApiSecret = @"YOURAPISECRET";
config.dataCenter = JumioDataCenterEU; // Change this parameter if your account is in the EU data center. Default is US.
config.delegate = self;

BAMCheckoutViewController *bamCheckoutViewController;
@try {
	bamCheckoutViewController = [[BAMCheckoutViewController alloc] initWithConfiguration:config];
} @catch (NSException *exception) {
	// HANDLE EXCEPTION
}
```

It is possible to update parameters of the configuration in case a scan was finished with error and the user is required to perform another scan. This can only be used if the SDK is currently not presented.
```
[bamCheckoutViewController updateConfiguration:config];
```

Make sure initialization and presentation are timely within one minute. On iPads, the presentation style `UIModalPresentationFormSheet` is default and mandatory.
```
[self presentViewController: bamCheckoutViewController animated: YES completion: nil];
```

## Configuration

### Card details

BAM Checkout supports Visa, MasterCard, American Express, JCB, China UnionPay, Discover, Diners and Starbucks. To restrict supported card types, set a bitmask of `BAMCheckoutCreditCardTypes` to the property `supportedCreditCardTypes`.
```
BAMCheckoutCreditCardTypes cardTypes = BAMCheckoutCreditCardTypeAmericanExpress |
BAMCheckoutCreditCardTypeMasterCard | BAMCheckoutCreditCardTypeVisa;
config.supportedCreditCardTypes = cardTypes;
```

The recognition of card holder name, expiry recognition and CVV entry is enabled by default and can be disabled. You can also enable recognition of sort code and account number for credit cards of the UK. In case the user is supposed to edit expiry date or card holder name in a step after the scan, set the appropriate properties for editing.
```
config.cardHolderNameRequired = NO;
config.sortCodeAndAccountNumberRequired = YES;
config.expiryRequired = NO;
config.cvvRequired = NO;
config.expiryEditable = YES;
config.cardHolderNameEditable = YES;
```

### Transaction identifiers
Specify your reporting criteria to identify each scan attempt in your reports (max. 100 characters).

__Note:__  This is not used for offline scanning.
```
config.merchantReportingCriteria = @"YOURREPORTINGCRITERIA";

```

### Offline scanning
In your Jumio Customer Portal on the "Settings" page under "API credentials" you can find your Offline token.
```
config.offlineToken = @"YOUROFFLINETOKEN";
```

In case the bundle identifier of your app does not match with the token, the expiration date of the token is reached or if the token itself is invalid value an exception will be thrown at initialization time and `bamCheckoutViewController` will be nil.

### Miscellaneous
You can set a short vibration (only on iPhone) and sound effect to notify the user that the card has been detected.
```
config.vibrationEffectEnabled = YES;
config.soundEffect = @"YOURSOUNDFILE.aif";
```

Use `cameraPosition` to configure the default camera (front or back).
```
config.cameraPosition = JumioCameraPositionFront;
```

To enable flashlight after SDK is started, use the following method.
```
config.enableFlashOnScanStart = YES;
```

To show the unmasked card number during the user journey, disable the following setting.
```
config.cardNumberMaskingEnabled = NO;
```

You can add custom fields to "Additional info" view (text input field or selection list).
```
[config addCustomField: @"idZipCode" title: @"Zip code" keyboardType: UIKeyboardTypeNumberPad regularExpression: @"[0-9]{5}"];
[config addCustomField: @"idState" title: @"State" values: yourArray required: NO resetValueText: @"-- no value --"];
```

The style of the status bar can be specified.
```
config.statusBarStyle = UIStatusBarStyleLightContent;
```

### Custom scan view
The BAM Checkout SDK gives the opportunity to use a completely customized scan view, that is created by you and just uses a protocol to control the scanning process as well as get informed about certain events. The following actions and events are offered.
* Get location and dimension of card frame
* Check if front and back camera available
* Get camera position (front or back)
* Switch between front and back camera
* Check if flash available
* Check if flash enabled
* Switch flash mode (on or off)
* Restart card scanning if retry possible upon error
* Stop card scanning

To get started, subclass `BAMCheckoutCustomScanOverlayViewController` and see the protocol `BAMCheckoutCustomScanOverlayViewControllerDelegate`. Once the native method `viewDidAppear` is called in your subclass, the actions and events are available.

```
config.customOverlay = yourCustomScanOverlayViewController;
```

For more detailed information about how to use the custom scan view, please check out our sample project.

## Customization
The SDK can be customized to fit your application’s look and feel via the UIAppearance pattern. Check out our sample project on how to use it.
* General: disable blur, background color, foreground color, font
* Navigation bar: title image, title color, tint color and bar tint color
* Positive button (Submit): title color and background
* Negative button (Cancel): title color and background
* Scan overlay: border color, text color

## Delegation
Implement the delegate methods of the `BAMCheckoutViewControllerDelegate` protocol to be notified of scan attempts, successful scans and error situations. Dismiss the `BAMCheckoutViewController` instance in your app in case of success or error.

#### Scan attempt
You receive a Jumio scan reference for each attempt, if the Internet connection is available. For offline scans the parameter scanReference will be nil.
```
- (void) bamCheckoutViewController: (BAMCheckoutViewController *) controller didStartScanAttemptWithScanReference: (NSString *) scanReference {
	// YOURCODE
}
```

#### Success
Upon success, the parameter `cardInformation` will be returned. Call clear after processing the card information to make sure no sensitive data remains in the device's memory.
```
- (void) bamCheckoutViewController: (BAMCheckoutViewController *) controller didFinishScanWithCardInformation: (BAMCheckoutCardInformation *) cardInformation scanReference: (NSString *) scanReference {
	// YOURCODE
	[cardInformation clear];
}
```

#### Error
This method is fired when the user presses the cancel button during the workflow or in an error situation. The parameter `error` contains an error code, a message and a detailed error code, also the corresponding scan reference is available.

__Note:__  The error codes 200, 210, 220, 240, 250, 260 and 310 will be returned. Using the custom scan view, the error codes 260 and 310 will be returned.
```
- (void) bamCheckoutViewController: (BAMCheckoutViewController *) controller didCancelWithError: (NSError*) error scanReference:(NSString *)scanReference {
	NSInteger errorCode = error.code;
	NSString* errorMessage = error.localizedDescription;
	NSInteger detailedErrorCode = [error.userInfo[@"detailedErrorCode"] integerValue];
}
```

Class **_BAMCheckoutCardInformation_**

|Parameter | Type | Max. length | Description |
|:---------------------------- 	|:-------------|:-----------------|:-------------|
| cardType | BAMCheckoutCreditCardType |  |  BAMCheckoutCreditCardTypeAmericanExpress, BAMCheckoutCreditCardTypeChinaUnionPay, BAMCheckoutCreditCardTypeDiners, BAMCheckoutCreditCardTypeDiscover, BAMCheckoutCreditCardTypeJCB, BAMCheckoutCreditCardTypeMasterCard, BAMCheckoutCreditCardTypeVisa or BAMCheckoutCreditCardTypeStarbucks  |
| cardNumber | NSMutableString | 16 | Full credit card number |
| cardNumberGrouped | NSMutableString | 19 | Grouped credit card number |
| cardNumberMasked | NSMutableString | 19 | First 6 and last 4 digits of the grouped credit card number, other digits are masked with "X" |
| cardExpiryMonth | NSMutableString | 2 | Month card expires if enabled and readable |
| CardExpiryYear | NSMutableString | 2 | Year card expires if enabled and readable |
| cardExpiryDate | NSMutableString | 5 | Date card expires in the format MM/yy if enabled and readable |
| cardCVV | NSMutableString | 4 | Entered CVV if enabled |
| cardHolderName | NSMutableString | 100 | Name of the card holder in capital letters if enabled and readable, or as entered if editable |
| cardSortCode | NSMutableString | 8 | Sort code in the format xx-xx-xx or xxxxxx if enabled, available and readable |
| cardAccountNumber | NSMutableString | 8 | Account number if enabled, available and readable |
| cardSortCodeValid | BOOL |  | True if sort code valid, otherwise false |
| cardAccountNumberValid | BOOL |  | True if account number code valid, otherwise false |

| Method | Parameter type | Return type | Description |
| --------------------|:-------|:-------|:-------------|
| clear | | | Clear card information |
| getCustomField | NSString | NSString | Get entered value for added custom field |

**_Error codes_** that are available via the `code` property of the NSError object:

| Code | Message | Description |
| :---------------: |:----------|:----------------|
| 200<br/>210<br/>220 | Authentication failed | API credentials invalid, retry impossible |
| 240 | Scanning not available at this time, please contact the app vendor | Resources cannot be loaded, retry impossible |
| 250 | Canceled by end-user | No error occurred |
| 260 | The camera is currently not available | Camera cannot be initialized, retry impossible |
| 280 | Certificate not valid anymore. Please update your application | End-to-end encryption key not valid anymore, retry impossible |
| 300 | Your card type is not accepted | Retry possible |
| 310 | Background execution is not supported | Cancellation triggered automatically |
| 320 | Your card is expired | Retry possible |

## Card retrieval API
You can implement RESTful HTTP GET APIs to retrieve credit card image and data for a specific scan. Find the Implementation Guide at the link below.

http://www.jumio.com/implementation-guides/credit-card-retrieval-api/
