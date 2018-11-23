![Document Verification](images/document_verification.png)

# Document Verification SDK for iOS
Document Verification is a powerful solution to enable scanning various types (Utility Bill, Bank statement and many others) of your customer's documents in your mobile application within seconds, also supporting data extraction on documents like Utility Bills and Bank Statements (see [Supported documents for data extraction](https://github.com/Jumio/implementation-guides/blob/master/netverify/document-verification.md#supported-documents))

## Table of Content

- [Release notes](#release-notes)
- [Setup](#setup)
- [Initialization](#initialization)
- [Configuration](#configuration)
- [Customization](#customization)
- [Delegation](#delegation)
- [Callback](#callback)

## Transition guide
For breaking technical changes, please read our [transition guide](transition-guide_document-verification.md).

## Setup
The [basic setup](../README.md#basic-setup) is required before continuing with the following setup for Document Verification.

## Initialization
Log into your Jumio Customer Portal and you can find your API token and API secret on the "Settings" page under "API credentials". We strongly recommend to store credentials outside your app. In case the token and secret are not set in the [`DocumentVerificationConfiguration`](http://jumio.github.io/mobile-sdk-ios/Netverify/Classes/DocumentVerificationConfiguration.html) object, an exception will be thrown. Please note that in Swift you need to catch the underlying exception and translate it into a `NSError` instance. Whenever an exception is thrown, the [`DocumentVerificationViewController`](http://jumio.github.io/mobile-sdk-ios/Netverify/Classes/DocumentVerificationViewController.html) instance will be nil and the SDK is not usable. Make sure that all necessary configuration is set before the `DocumentVerificationConfiguration` instance is passed to the initializer.

```
DocumentVerificationViewController *config = [DocumentVerificationViewController new];
config.merchantApiToken = @"YOURAPITOKEN";
config.merchantApiSecret = @"YOURAPISECRET";
config.dataCenter = JumioDataCenterEU; // Change this parameter if your account is in the EU data center. Default is US.
config.delegate = self;

DocumentVerificationViewController *documentVerificationViewController;
@try {
	documentVerificationViewController = [[DocumentVerificationViewController alloc] initWithConfiguration:config];
} @catch (NSException *exception) {
	// HANDLE EXCEPTION
}
```

It is possible to update parameters of the configuration in case a scan was finished with error and the user is required to perform another scan. This can only be used if the SDK is currently not presented.

```
[documentVerificationViewController updateConfiguration:config];
```

Make sure initialization and presentation are timely within one minute. On iPads, the presentation style _UIModalPresentationFormSheet_ is default and mandatory.

```
[self presentViewController: documentVerificationViewController animated: YES completion: nil];
```

### Jailbreak detection
We advice to prevent our SDK to be run on jailbroken device. Either use the method below or a self-devised check to prevent usage of SDK scanning functionality on jailbroken devices:
```
[JMDeviceInfo isJailbrokenDevice]
```

## Configuration

### Document type
Set the parameter `type` in the `DocumentVerificationConfiguration` object to pass the document type.
```
config.type = @"BC";
```

Possible types:

*  BS (Bank statement)
*  IC (Insurance card)
*  UB (Utility bill, front side)
*  CAAP (Cash advance application)
*  CRC (Corporate resolution certificate)
*  CCS (Credit card statement)
*  LAG (Lease agreement)
*  LOAP (Loan application)
*  MOAP (Mortgage application)
*  TR (Tax return)
*  VT (Vehicle title)
*  VC (Voided check)
*  STUC (Student card)
*  HCC (Health care card)
*  CB (Council bill)
*  SENC (Seniors card)
*  MEDC (Medicare card)
*  BC (Birth certificate)
*  WWCC (Working with children check)
*  SS (Superannuation statement)
*  TAC (Trade association card)
*  SEL (School enrolment letter)
*  PB (Phone bill)
*  SSC (Social security card)
*  CUSTOM (Custom document type)

#### Custom Document Type
Use the following method to pass your custom document code. Maintain your custom document code within your Jumio Customer Portal under "Settings" - "Document Verifications" -
"Custom".
```
config.customDocumentCode = @"YOURCUSTOMDOCUMENTCODE";
```

### Country

The country needs to be in format [ISO-3166-1 alpha 3](http://en.wikipedia.org/wiki/ISO_3166-1_alpha-3) or XKX for Kosovo.
```
config.country= @"USA";
```

### Transaction identifiers
Specify your reporting criteria to identify each scan attempt in your reports (max. 100 characters).
```
config.merchantReportingCriteria = @"YOURREPORTINGCRITERIA";
```

__Note:__ Must not contain sensitive data like PII (Personally Identifiable Information) or account login.

A callback URL can be specified for individual transactions, for constraints see chapter [Callback URL](https://github.com/Jumio/implementation-guides/blob/master/netverify/callback.md#callback-url). This setting overrides your Jumio merchant settings.
```
config.callbackUrl = @"YOURCALLBACKURL";
```

### Data Extraction

Data extraction is automatically enabled when it is activated for your account. Use the following setting to disable the extraction on a transaction level:

```
config.enableExtraction = false;
```

__Note:__ If you want to activate data extraction for your account in general, please contact your Account Manager, or reach out to Jumio Support.

### Miscellaneous
Use the following property to identify the scan in your reports (max. 100 characters) and set a customer identifier (max. 100 characters).
```
config.merchantScanReference = @"YOURSCANREFERENCE";
config.customerId = @"CUSTOMERID";
```
__Note:__ Must not contain sensitive data like PII (Personally Identifiable Information) or account login.

Use cameraPosition to configure the default camera (front or back).
```
config.cameraPosition = JumioCameraPositionFront;
```

The style of the status bar can be specified.
```
config.statusBarStyle = UIStatusBarStyleLightContent;
```

## Customization

The SDK can be customized to fit your application’s look and feel via the UIAppearance pattern. Check out our sample project on how to use it.
* Navigation bar: title image, title color, tint color and bar tint color
* General: disable blur, background color, foreground color, font
* Positive button (Submit): title color and background
* Negative button (Cancel): title color and background
* Camera and flash toggle button: title color and background

## Delegation
Implement the delegate methods of the [`DocumentVerificationViewControllerDelegate`](http://jumio.github.io/mobile-sdk-ios/Netverify/Protocols/DocumentVerificationViewControllerDelegate.html) protocol to be notified of successful initialisation, successful scans and error situations. Dismiss the SDK view in your app in case of success or error.

### Success
Upon success, the scan reference is returned.
```
- (void) documentVerificationViewController:(DocumentVerificationViewController*) documentVerificationViewController didFinishWithScanReference: (NSString*)scanReference  {
	// YOURCODE
}
```

### Error
This method is fired when the user presses the cancel button during the workflow or in an error situation. The parameter `error` contains an error code and a message.
```
- (void) documentVerificationViewController:(DocumentVerificationViewController*) documentVerificationViewController didFinishWithError:(DocumentVerificationError*) error {
	NSString* errorCode = error.code;
	NSString* errorMessage = error.message;
}
```

**_Error codes_** that are available via the `code` property of the DocumentVerificationError object:

| Code | Message | Description |
| :-------------: |:----------|:-------------|
| A10000 | We have encountered a network communication problem | Retry possible, user decided to cancel |
| B10000 | Authentication failed | Secure connection could not be established, retry impossible |
| C10401 | Authentication failed | API credentials invalid, retry impossible |
| D10403 | Authentication failed | Wrong API credentials used, retry impossible |
| E10000 | No Internet connection available | Retry possible, user decided to cancel |
| G00000 | Cancelled by end-user | No error occurred |
| H00000 | The camera is currently not available | Camera cannot be initialized, retry impossible |
| I00000 | Certificate not valid anymore. Please update your application | End-to-end encryption key not valid anymore, retry impossible |
| K10400 | Unsupported document code defined. Please contact Jumio support | An unsupported document code has been set, retry impossible |

## Callback
To get information about callbacks, Netverify Retrieval API, Netverify Delete API and Global Netverify settings and more, please read our [page with server related information](https://github.com/Jumio/implementation-guides/blob/master/netverify/callback.md).
