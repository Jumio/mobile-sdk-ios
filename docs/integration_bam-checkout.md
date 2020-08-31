![BAM Checkout](images/bam_checkout.jpg)

# BAM Checkout SDK for iOS
BAM Checkout is a powerful, cutting-edge solution to extract data from your customer´s credit card and / or ID in your mobile application within seconds, including home address. It fits perfectly, and fully automates, every checkout flow to avoid manual input at all which leads to an increased conversion rate.

## Table of Content

- [Release notes](#release-notes)
- [Setup](#setup)
- [Initialization](#initialization)
- [Configuration](#configuration)
- [Localization](#localization)
- [Customization](#customization)
- [SDK Workflow](#sdk-workflow)
- [Card retrieval API](#card-retrieval-api)

## Release notes
Please refer to our [Change Log](changelog.md) for more information. Current SDK version: 3.7.1

For breaking technical changes, please read our [transition guide](transition-guide_bam-checkout.md).

## Setup
The [basic setup](../README.md#basics) is required before continuing with the following setup for BAM Checkout.

## Initialization
Log into your Jumio Customer Portal and you can find your API token and API secret on the "Settings" page under "API credentials". We strongly recommend to store credentials outside your app. In case the token and secret are not set in the [`BAMCheckoutConfiguration`](https://jumio.github.io/mobile-sdk-ios/BAMCheckout/Classes/BAMCheckoutConfiguration.html) object, an exception will be thrown. Please note that in Swift you need to catch the underlying exception and translate it into a `NSError` instance. Whenever an exception is thrown, the [`BAMCheckoutViewController`](https://jumio.github.io/mobile-sdk-ios/BAMCheckout/Classes/BAMCheckoutViewController.html) instance will be nil and the SDK is not usable. Make sure that all necessary configuration is set before the `BAMCheckoutConfiguration` instance is passed to the initializer.
```swift
let config:BAMCheckoutConfiguration = BAMCheckoutConfiguration()
config.merchantApiToken = "YOUR_BAMCHECKOUT_APITOKEN"
config.merchantApiSecret = "YOUR_BAMCHECKOUT_APISECRET"
config.dataCenter = JumioDataCenterUS
config.delegate = self;
```

[__Swift__](../sample/SampleSwift/BAMCheckoutStartViewController.swift#L9-L97)
[__Objective C__](../sample/SampleObjC/BAMCheckoutStartViewController.m#L18-L90)

The default data center is `JumioDataCenterUS`. If your customer account is in the EU data center, use `JumioDataCenterEU` instead. Alternatively, use `JumioDataCenterSG` for Singapore.

Make sure initialization and presentation are timely within one minute. On iPads, the presentation style `UIModalPresentationFormSheet` is default and mandatory.
```swift
 self.present(bamCheckoutVC, animated: true, completion: nil)
 ```

[__Swift__](../sample/SampleSwift/BAMCheckoutStartViewController.swift#L172-L176)
[__Objective C__](../sample/SampleObjC/BAMCheckoutStartViewController.m#L173-L179)

### Jailbreak detection
We advice to prevent our SDK to be run on jailbroken devices. Either use the method below or a self-devised check to prevent usage of SDK scanning functionality on jailbroken devices:
```swift
JMDeviceInfo.isJailbrokenDevice()
```

[__Swift__](../sample/SampleSwift/BAMCheckoutStartViewController.swift#L15-L18)
[__Objective C__](../sample/SampleObjC/BAMCheckoutStartViewController.m#L20-L23)

## Configuration

### Card details
BAM Checkout supports Visa, MasterCard, American Express, JCB, China UnionPay, Discover and Diners. To restrict supported card types, set a bitmask of [`BAMCheckoutCreditCardTypes`](https://jumio.github.io/mobile-sdk-ios/BAMCheckout/BAMCheckout%20Type%20Definition.html#/c:BAMCheckoutCardInformation.h@T@BAMCheckoutCreditCardTypes) to the property `supportedCreditCardTypes`.
```swift
let cardTypes:BAMCheckoutCreditCardTypes = BAMCheckoutCreditCardTypes(BAMCheckoutCreditCardType.all.rawValue)
config.supportedCreditCardTypes = cardTypes
```

[__Swift__](../sample/SampleSwift/BAMCheckoutStartViewController.swift#L39-L42)
[__Objective C__](../sample/SampleObjC/BAMCheckoutStartViewController.m#L44-L47)

The recognition of card holder name, expiry recognition and CVV entry is enabled by default and can be disabled. You can also enable recognition of sort code and account number for credit cards of the UK. In case the user is supposed to edit expiry date or card holder name in a step after the scan, set the appropriate properties for editing.
```swift
config.cvvRequired = self.switchCvvRequired.isOn
config.expiryRequired = false
config.cardHolderNameRequired = false
config.sortCodeAndAccountNumberRequired = true
config.cardNumberMaskingEnabled = false
config.expiryEditable = true
config.cardHolderNameEditable = true
```

[__Swift__](../sample/SampleSwift/BAMCheckoutStartViewController.swift#L44-L79)
[__Objective C__](../sample/SampleObjC/BAMCheckoutStartViewController.m#L49-L84)

### Transaction identifiers
Specify your reporting criteria to identify each scan attempt in your reports (max. 100 characters).

```swift
config.merchantReportingCriteria = "YOURREPORTINGCRITERIA"
```

[__Swift__](../sample/SampleSwift/BAMCheckoutStartViewController.swift#L36-L37)
[__Objective C__](../sample/SampleObjC/BAMCheckoutStartViewController.m#L41-L42)

__Note:__ Transaction identifiers must not contain sensitive data like PII (Personally Identifiable Information) or account login.

### Offline scanning
If you want to use the SDK in offline mode, please contact Jumio Support at support@jumio.com or https://support.jumio.com. Once this feature is enabled for your account, you can find your offline token in your Jumio customer portal on the __Settings__ page in the __API credentials__ tab.
```swift
config.offlineToken = "YOUROFFLINETOKEN"
```

[__Swift__](../sample/SampleSwift/BAMCheckoutStartViewController.swift#L33-L34)
[__Objective C__](../sample/SampleObjC/BAMCheckoutStartViewController.m#L38-L39)

__Note:__ In case the bundle identifier of your app does not match with the token, if the expiration date of the token is reached or if the value of the token itself is invalid, an exception will be thrown at initialization time and `bamCheckoutViewController` will be nil.

### Miscellaneous
You can set a short vibration (only on iPhone) and sound effect to notify the user that the card has been detected.
```swift
config.vibrationEffectEnabled = true
config.soundEffect = "YOURSOUNDFILE.aif"
```

Use `cameraPosition` to configure the default camera (front or back).
```swift
config.cameraPosition = JumioCameraPositionFront
```

To enable flashlight after SDK is started, use the following method.
```swift
config.enableFlashOnScanStart = true
```

To show the unmasked card number during the user journey, disable the following setting.
```swift
config.cardNumberMaskingEnabled = false
```

You can add custom fields to "Additional info" view (text input field or selection list).
```swift
config.addCustomField("idZipCode", title: "Zip code", keyboardType: UIKeyboardType.numberPad, regularExpression: "[0-9]{5,}")
```

The style of the status bar can be specified.
```swift
config.statusBarStyle = UIStatusBarStyle.lightContent
```

[__Swift__](../sample/SampleSwift/BAMCheckoutStartViewController.swift#L60-L79)
[__Objective C__](../sample/SampleObjC/BAMCheckoutStartViewController.m#L65-L84)

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

To get started, subclass [`BAMCheckoutCustomScanOverlayViewController`](https://jumio.github.io/mobile-sdk-ios/BAMCheckout/Classes/BAMCheckoutCustomScanOverlayViewController.html) and see the protocol [`BAMCheckoutCustomScanOverlayViewControllerDelegate`](https://jumio.github.io/mobile-sdk-ios/BAMCheckout/Protocols/BAMCheckoutCustomScanOverlayViewControllerDelegate.html). Once the native method `viewDidAppear` is called in your subclass, the actions and events are available.
```swift
  let customOverlay:CustomScanOverlayViewController = CustomScanOverlayViewController(nibName: "CustomScanOverlayViewControllerSwift", bundle: nil)
  config.customOverlay = customOverlay
 ```

[__Swift__](../sample/SampleSwift/BAMCheckoutStartViewController.swift#L151-L163)
[__Objective C__](../sample/SampleObjC/BAMCheckoutStartViewController.m#L159-L180)

For more detailed information about how to use the custom scan view, please check out our [sample project](../sample).

## Customization

### Customize look and feel
The SDK can be customized to fit your application’s look and feel via the UIAppearance pattern. Check out our [sample project]((https://github.com/Jumio/mobile-sdk-ios/tree/master/sample) on how to use it.
* General: disable blur, background color, foreground color, font
* Navigation bar: title image, title color, tint color and bar tint color
* Positive button (Submit): title color and background
* Negative button (Cancel): title color and background
* Scan overlay: border color, text color

__Note:__ Customizations should be applied before the SDK is initialized.

## SDK Workflow
Implement the delegate methods of the [`BAMCheckoutViewControllerDelegate`](https://jumio.github.io/mobile-sdk-ios/BAMCheckout/Protocols/BAMCheckoutViewControllerDelegate.html) protocol to be notified of scan attempts, successful scans and error situations. Dismiss the `BAMCheckoutViewController` instance in your app in case of success or error.

### Scan attempt
You receive a Jumio scan reference for each attempt, if the Internet connection is available. For offline scans the parameter scanReference will be nil.
```swift
func bamCheckoutViewController(_ controller: BAMCheckoutViewController, didStartScanAttemptWithScanReference scanReference: String) {}
```

[__Swift__](../sample/SampleSwift/BAMCheckoutStartViewController.swift#L184-L186)
[__Objective C__](../sample/SampleObjC/BAMCheckoutStartViewController.m#L205-207)

### Success
Upon success, the parameter `cardInformation` will be returned. Call clear after processing the card information to make sure no sensitive data remains in the device's memory.
```swift
 func bamCheckoutViewController(_ controller: BAMCheckoutViewController, didFinishScanWith cardInformation: BAMCheckoutCardInformation, scanReference: String) {}
```

[__Swift__](../sample/SampleSwift/BAMCheckoutStartViewController.swift#L194-L232)
[__Objective C__](../sample/SampleObjC/BAMCheckoutStartViewController.m#L215-L260)

### Error
This method is fired when the user presses the cancel button during the workflow or in an error situation. The parameter `error` contains an error code, a message and a detailed error code, also the corresponding scan reference is available.

```swift
 func bamCheckoutViewController(_ controller: BAMCheckoutViewController, didCancelWithError error: Error?, scanReference: String?) {}
```

[__Swift__](../sample/SampleSwift/BAMCheckoutStartViewController.swift#L239-L244)
[__Objective C__](../sample/SampleObjC/BAMCheckoutStartViewController.m#L268-L275)

__Note:__ The error codes are described [here](#error-codes)

### Class ___BAMCheckoutCardInformation___

|Parameter | Type | Max. length | Description |
|:---------------------------- 	|:-------------|:-----------------|:-------------|
| cardType | BAMCheckoutCreditCardType |  |  BAMCheckoutCreditCardTypeAmericanExpress, BAMCheckoutCreditCardTypeChinaUnionPay, BAMCheckoutCreditCardTypeDiners, BAMCheckoutCreditCardTypeDiscover, BAMCheckoutCreditCardTypeJCB, BAMCheckoutCreditCardTypeMasterCard or BAMCheckoutCreditCardTypeVisa |
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

### Error codes
List of all **_error codes_** that are available via the `code` property of the NSError object.

| Code | Message | Description |
| :---------------: |:----------|:----------------|
| 200<br/>210<br/>220 | Authentication failed | API credentials invalid, retry impossible |
| 240 | Scanning not available at this time, please contact the app vendor | Resources cannot be loaded, retry impossible |
| 250 | Canceled by end-user | No error occurred |
| 260 | The camera is currently not available |  __Only Custom UI:__ Camera cannot be initialized, retry impossible |
| 280 | Certificate not valid anymore. Please update your application | End-to-end encryption key not valid anymore, retry impossible |
| 300 | Your card type is not accepted | Retry possible |
| 310 | Background execution is not supported |  __Only Custom UI:__ Cancellation triggered automatically |
| 320 | Your card is expired | Retry possible |

__Note:__ Please always include the whole code when filing an error related issue to our support team.

## Card retrieval API
You can implement RESTful HTTP GET APIs to retrieve credit card image and data for a specific scan. Please refer to our [implementation guide](http://www.jumio.com/implementation-guides/credit-card-retrieval-api/) for more information.
