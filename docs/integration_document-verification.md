![Document Verification](images/document_verification.jpg)

# Document Verification SDK for iOS
Document Verification is a powerful solution to enable scanning various types (Utility Bill, Bank statement and many others) of your customer's documents in your mobile application within seconds, also supporting data extraction on documents like Utility Bills and Bank Statements (see [Supported documents for data extraction](https://github.com/Jumio/implementation-guides/blob/master/netverify/document-verification.md#supported-documents))

## Table of Contents
- [Release Notes](#release-notes)
- [Setup](#setup)
- [Initialization](#initialization)
- [Configuration](#configuration)
- [Customization](#customization)
- [SDK Workflow](#delegation)
- [Callback](#callback)
- [Code Documentation](https://jumio.github.io/mobile-sdk-ios/DocumentVerification/)

## Transition Guide
Please refer to our [Change Log](changelog.md) for more information. Current SDK version: 3.9.1

For breaking technical changes, please read our [transition guide](transition-guide_document-verification.md).

## Setup
The [basic setup](../README.md#basics) is required before continuing with the following setup for Document Verification.

## Initialization
Log into your Jumio customer portal. You can find your customer API token and API secret on the __Settings__ page under __API credentials__ tab.

If the token and secret are not set in the [`DocumentVerificationConfiguration`](https://jumio.github.io/mobile-sdk-ios/DocumentVerification/Classes/DocumentVerificationConfiguration.html) object, an exception will be thrown. Please note that in Swift you need to catch the underlying exception and translate it into a `NSError` instance. Whenever an exception is thrown, the [`DocumentVerificationViewController`](https://jumio.github.io/mobile-sdk-ios/DocumentVerification/Classes/DocumentVerificationViewController.html) instance will be nil and the SDK is not usable. Make sure that all necessary configuration is set before the `DocumentVerificationConfiguration` instance is passed to the initializer.
```swift
let config:DocumentVerificationConfiguration = DocumentVerificationConfiguration()
config.apiToken = "YOUR_DOCUMENTVERIFICATION_APITOKEN"
config.apiSecret = "YOUR_DOCUMENTVERIFICATION_APISECRET"
config.dataCenter = JumioDataCenterUS
config.delegate = self
```

[__Swift__](../sample/SampleSwift/DocumentVerificationStartViewController.swift#L20-L30)
[__Objective C__](../sample/SampleObjC/DocumentVerificationStartViewController.m#L24-L34)

The default data center is `JumioDataCenterUS`. If your customer account is in the EU data center, use `JumioDataCenterEU` instead. Alternatively, use `JumioDataCenterSG` for Singapore.

__Note:__ We strongly recommend storing all credentials outside of your app!

Make sure initialization and presentation are timely within one minute. On iPads, the presentation style `UIModalPresentationFormSheet` is default and mandatory.
```swift
 self.present(documentVC, animated: true, completion: nil)
 ```

[__Swift__](../sample/SampleSwift/DocumentVerificationStartViewController.swift#L91-L95)
[__Objective C__](../sample/SampleObjC/DocumentVerificationStartViewController.m#L71-L77)

### Jailbreak Detection
We advice to prevent our SDK to be run on jailbroken devices. Either use the method below or a self-devised check to prevent usage of SDK scanning functionality on jailbroken devices:
```swift
JMDeviceInfo.isJailbrokenDevice()
```

[__Swift__](../sample/SampleSwift/DocumentVerificationStartViewController.swift#L15-L18)
[__Objective C__](../sample/SampleObjC/DocumentVerificationStartViewController.m#L19-L22)

## Configuration

### Document type
Set the parameter `type` in the `DocumentVerificationConfiguration` object to pass the document type.
```swift
config.type = "BC"
```

[__Swift__](../sample/SampleSwift/DocumentVerificationStartViewController.swift#L35-L37)
[__Objective C__](../sample/SampleObjC/DocumentVerificationStartViewController.m#L39-L41)

Possible types:

*  BC (Birth certificate)
*  BS (Bank statement)
*  CAAP (Cash advance application)
*  CB (Council bill)
*  CC (Credit card)
*  CCS (Credit card statement)
*  CRC (Corporate resolution certificate)
*  HCC (Health care card)
*  IC (Insurance card)
*  LAG (Lease agreement)
*  LOAP (Loan application)
*  MEDC (Medicare card)
*  MOAP (Mortgage application)
*  PB (Phone bill)
*  SEL (School enrolment letter)
*  SENC (Seniors card)
*  SS (Superannuation statement)
*  SSC (Social security card)
*  STUC (Student card)
*  TAC (Trade association card)
*  TR (Tax return)
*  UB (Utility bill)
*  VC (Voided check)
*  VT (Vehicle title)
*  WWCC (Working with children check)
*  CUSTOM (Custom document type)

#### Custom Document Type
Use the following method to pass your custom document code. Maintain your custom document code within your Jumio customer portal under the tab __Settings__ --> __Document Verification__ --> __Custom__.
```swift
config.customDocumentCode = "YOURCUSTOMDOCUMENTCODE"
```

[__Swift__](../sample/SampleSwift/DocumentVerificationStartViewController.swift#L57-L58)
[__Objective C__](../sample/SampleObjC/DocumentVerificationStartViewController.m#L61-L62)

### Country Selection
You can specify issuing country  using [ISO 3166-1 alpha-3](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-3) country codes. In the example down below the United States ("USA") have been preselected. Use "XKX" for Kosovo.
```swift
config.country = "AUT"
```

[__Swift__](../sample/SampleSwift/DocumentVerificationStartViewController.swift#L32-L33)
[__Objective C__](../sample/SampleObjC/DocumentVerificationStartViewController.m#L36-L37)

### Transaction Identifiers
Specify your reporting criteria to identify each scan attempt in your reports (max. 100 characters).
```swift
config.reportingCriteria = "YOURREPORTINGCRITERIA"
```

Use the following property to identify the scan in your reports (max. 100 characters) and set a customer identifier (max. 100 characters).
```swift
 config.customerInternalReference = "YOURSCANREFERENCE"
 config.userReference = "CUSTOMERID"
```

[__Swift__](../sample/SampleSwift/DocumentVerificationStartViewController.swift#L39-L49)
[__Objective C__](../sample/SampleObjC/DocumentVerificationStartViewController.m#L43-L53)

__Note:__ Transaction identifiers must not contain sensitive data like PII (Personally Identifiable Information) or account login.

### Callback
A callback URL can be specified for individual transactions, for constraints see chapter [Callback URL](https://github.com/Jumio/implementation-guides/blob/master/netverify/callback.md#callback-url). This setting overrides your Jumio customer settings.
```swift
config.callbackUrl = "YOURCALLBACKURL"
```
__Note:__ The callback URL must not contain sensitive data like PII (Personally Identifiable Information) or account login.


### Data Extraction
Data extraction is automatically enabled when it is activated for your account. Use the following setting to disable the extraction on a transaction level:
```swift
config.enableExtraction = true
```

[__Swift__](../sample/SampleSwift/DocumentVerificationStartViewController.swift#L63-L64)
[__Objective C__](../sample/SampleObjC/DocumentVerificationStartViewController.m#L67-L68)

__Note:__ If you would like to enable extraction for your account in general, please contact your Account Manager, or reach out to Jumio Support at support@jumio.com or [online](https://support.jumio.com).

### Camera Handling
Use cameraPosition to configure the default camera (front or back).
```swift
config.cameraPosition = JumioCameraPositionFront
```

[__Swift__](../sample/SampleSwift/DocumentVerificationStartViewController.swift#L51-L52)
[__Objective C__](../sample/SampleObjC/DocumentVerificationStartViewController.m#L55-L56)

### Misc
The style of the status bar can be specified.
```swift
config.statusBarStyle = UIStatusBarStyle.lightContent
```

Use setDocumentName to override the document label on Help screen.
```swift
config.documentName = "YOURDOCUMENTNAME"
```

[__Swift__](../sample/SampleSwift/DocumentVerificationStartViewController.swift#L54-L61)
[__Objective C__](../sample/SampleObjC/DocumentVerificationStartViewController.m#L58-L65)

## Customization

### Customize Look and Feel
Customizable aspects include:
- General: disable blur, blur style, background color, foreground color, font
- Navigation bar: title image, title color, tint color and bar tint color
- Positive button (Submit): title color and background
- Negative button (Cancel): title color and background
- Camera and flash toggle button: title color and background

__Note:__ Customizations should be applied before the SDK is initialized.

## SDK Workflow
Implement the delegate methods of the [`DocumentVerificationViewControllerDelegate`](https://jumio.github.io/mobile-sdk-ios/DocumentVerification/Protocols/DocumentVerificationViewControllerDelegate.html) protocol to be notified of successfully initializing, successful scans and error situations. Dismiss the SDK view in your app in case of success or error.

### Success
Upon success, the scan reference is returned.
```swift
func documentVerificationViewController(_ documentVerificationViewController: DocumentVerificationViewController, didFinishWithScanReference scanReference: String?) {}
```

[__Swift__](../sample/SampleSwift/DocumentVerificationStartViewController.swift#L104-L112)
[__Objective C__](../sample/SampleObjC/DocumentVerificationStartViewController.m#L106-L114)

### Error
This method is fired when the user presses the cancel button during the workflow or in an error situation. The parameter `error` contains an error code and a message.
```swift
func documentVerificationViewController(_ documentVerificationViewController: DocumentVerificationViewController, didFinishWithError error: DocumentVerificationError) {}
```

[__Swift__](../sample/SampleSwift/DocumentVerificationStartViewController.swift#L119-L124)
[__Objective C__](../sample/SampleObjC/DocumentVerificationStartViewController.m#L121-125)

#### Error Codes
List of all **_error codes_** that are available via the `code` property of the DocumentVerificationError object. The first letter (A-K) represents the error case. The remaining characters are represented by numbers that contain information helping us understand the problem situation ([x][yyyy]).

| Code | Message | Description |
| :-------------: |:----------|:-------------|
| A[x][yyyy]| We have encountered a network communication problem | Retry possible, user decided to cancel |
| B[x][yyyy]| Authentication failed | Secure connection could not be established, retry impossible |
| C[x]0401 | Authentication failed | API credentials invalid, retry impossible |
| E[x]0000 | No Internet connection available | Retry possible, user decided to cancel |
| G00000 | Cancelled by end-user | No error occurred |
| H00000 | The camera is currently not available | Camera cannot be initialized, retry impossible |
| I00000 | Certificate not valid anymore. Please update your application | End-to-end encryption key not valid anymore, retry impossible |
| K10400 | Unsupported document code defined. Please contact Jumio support | An unsupported document code has been set, retry impossible |

__Note:__ Please always include the whole code when filing an error related issue to our support team.

## Callback
To get information about callbacks, __Netverify Retrieval API,__ __Netverify Delete API,__ Global ID Verification settings, and more, please refer to our [page with server related information](https://github.com/Jumio/implementation-guides/blob/master/netverify/callback.md).
