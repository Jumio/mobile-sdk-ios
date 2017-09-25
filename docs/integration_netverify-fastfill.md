![Fastfill & Netverify](images/netverify.png)

# Fastfill & Netverify SDK for iOS
Netverify SDK offers scanning and authentication of government issued IDs.

## Table of Content

- [Release notes](#release-notes)
- [Setup](#setup)
- [Initialization](#initialization)
- [Configuration](#configuration)
- [Customization](#customization)
- [Delegation](#delegation)
- [Callback](#callback)

## Release notes
For changes in the technical area, please read our [transition guide](transition-guide_netverify-fastfill.md).

#### Additions
* iOS 11 support

## Setup
The [basic setup](../README.md#basic-setup) is required before continuing with the following setup for Netverify.

## Initialization
Log into your Jumio merchant backend, and you can find your merchant API token and API secret on the "Settings" page under "API credentials". We strongly recommend to store credentials outside your app. In case the token and secret are not set in the `NetverifyConfiguration` object, an exception will be thrown. Whenever a exception is thrown, the `NetverifyViewController` instance will be nil and the SDK is not usable. Make sure that all necessary configuration is set before the `NetverifyConfiguration` instance is passed to the initializer.

```
NetverifyConfiguration *config = [NetverifyConfiguration new];
config.merchantApiToken = @"YOURAPITOKEN";
config.merchantApiSecret = @"YOURAPISECRET";
config.dataCenter = JumioDataCenterEU; // Change this parameter if your merchant account is in the EU data center. Default is US.
config.delegate = self;

NetverifyViewController *netverifyViewController;
@try {
	netverifyViewController = [[NetverifyViewController alloc] initWithConfiguration:config];
} @catch (NSException *exception) {
	// HANDLE EXCEPTION
}
```

It is possible to update parameters of the configuration in case a scan was finished with error and the user is required to perform another scan. This can only be used if the SDK is currently not presented.
```
[netverifyViewController updateConfiguration:config];
```

Make sure initialization and presentation are timely within one minute. On iPads, the presentation style `UIModalPresentationFormSheet` is default and mandatory.
```
[self presentViewController: netverifyViewController animated: YES completion: nil];
```

## Configuration

### ID verification
By default, the SDK is used in Fastfill mode which means it is limited to data extraction only. No verification of the ID is performed.

Enable ID verification to receive a verification status and verified data positions (see [Callback for Netverify](https://github.com/Jumio/implementation-guides/blob/master/netverify/callback.md#callback-for-netverify)). Ensure that your merchant account is allowed to use this feature.
A callback URL can be specified for individual transactions (constraints see chapter [Callback URL](https://github.com/Jumio/implementation-guides/blob/master/netverify/callback.md#callback-url)). This setting overrides your Jumio merchant settings.

__Note:__ Not available for accounts configured as Fastfill only.
```
config.requireVerification = YES;
config.callbackUrl = @"YOURCALLBACKURL";
```

You can enable face match during the ID verification for a specific transaction (if it is enabled for your account). Make sure to link the UMoove framework to make use of the liveness capability in your app.

__Note:__ Face match requires Portrait orientation in your app.
```
config.requireFaceMatch = YES;
```

### Preselection
You can specify issuing country ([ISO 3166-1 alpha-3](http://en.wikipedia.org/wiki/ISO_3166-1_alpha-3) country code), ID type and/or document variant to skip their selection during the scanning process.

__Note:__ Fastfill does not support paper IDs, except German ID cards.
```
config.preselectedCountry = @"AUT";
config.preselectedDocumentTypes = NetverifyDocumentTypePassport | NetverifyDocumentTypeVisa;
config.preselectedDocumentVariant = NetverifyDocumentVariantPlastic;
```

### Transaction identifiers
The merchant scan reference allows you to identify the scan (max. 100 characters).

__Note:__ Must not contain sensitive data like PII (Personally Identifiable Information) or account
login.
```
config.merchantScanReference = @"YOURSCANREFERENCE";
```
Use the following property to identify the scan in your reports (max. 100 characters).
```
config.merchantReportingCriteria = @"YOURREPORTINGCRITERIA";
```
You can also set a customer identifier (max. 100 characters).

__Note:__ The customer ID should not contain sensitive data like PII (Personally Identifiable Information) or account login.
```
config.customerId = @"CUSTOMERID";
```

To send some additional information use the property additionalInformation.

__Note:__ Additional information for this scan should not contain sensitive data like PII (Personally Identifiable Information) or account login.
```
config.additionalInformation = @"ADDITONAL INFORMATION";
```

### Analytics Service
Use the following setting to explicitly send debug information to Jumio.
```
config.sendDebugInfoToJumio = YES;
```
__Note:__ Only set this property to true if you are asked by Jumio Customer Service.

You receive the current debug session ID in the parameter `debugID`. This method can be called either
after initializing or before dismissing the SDK.
```
NSUUID *debugSessionID = self.netverifyViewController.debugID;
```

### Miscellaneous

In case Fastfill is used (requireVerification=NO), data extraction can be limited to be done on device only by enabling `dataExtractionOnMobileOnly`.
```
config.dataExtractionOnMobileOnly = YES;
```

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
- General: disable blur, background color, foreground color, font
- Navigation bar: title image, title color, tint color and bar tint color
- Positive button (Submit): title color and background
- Negative button (Cancel): title color and background
- Fallback button (Detection not working): title color and background
- Scan Options button: title color and background
- Camera and flash toggle button: title color and background
- Scan overlay: standard color, valid color and invalid color

### Customization tool
[Jumio Surface](https://jumio.github.io/surface-ios) is a web tool that offers the possibility to apply and visualize, in real-time, all available customization options as well as an export feature to import the applied changes straight into the your codebase.

## Delegation
Implement the delegate methods of the `NetverifyViewControllerDelegate` protocol to be notified of successful initialisation, successful scans and error situations. Dismiss the SDK view in your app in case or success or error.

### Initialization
When this method is fired, the SDK finished initialization as well as loading tasks and is ready to use. The error object is only set in case an error occurred (e.g. wrong credentials are set).
```
- (void) netverifyViewController: (NetverifyViewController*) netverifyViewController didFinishInitializingWithError:(NSError*)error {
	// YOURCODE
}
```

### Success
Upon success, the extracted document data is returned including its scan reference. Call clear on the document data object after processing the card information to make sure no sensitive data remains in the device's memory.
```
- (void) netverifyViewController: (NetverifyViewController *) netverifyViewController didFinishWithDocumentData: (NetverifyDocumentData *) documentData scanReference: (NSString *) scanReference  {
	// YOURCODE
}
```

### Error
This method is fired when the user presses the cancel button upon an error situation. The parameter `error` contains an error code and a message, also the corresponding scan reference is available.
```
- (void) netverifyViewController: (NetverifyViewController *) netverifyViewController didCancelWithError: (NSError *) error scanReference: (NSString *) scanReference {
	// YOURCODE
}
```

### Retrieving information
The following tables give information on the specification of all document data parameters and errors.

Class **_NetverifyDocumentData:_**

| Parameter | Type | Max. length | Description  |
|:-------------------|:----------- 	|:-------------|:-----------------|
| selectedCountry | NSString| 3| [ISO 3166-1 alpha-3](http://en.wikipedia.org/wiki/ISO_3166-1_alpha-3) country code as provided or selected |
| selectedDocumentType | NetverifyDocumentType | | Passport, DriverLicense, IdentityCard and Visa |
| idNumber | NSString | 100 | Identification number of the document |
| personalNumber | NSString | 14| Personal number of the document|
| issuingDate | NSDate | | Date of issue |
| expiryDate | NSDate | | Date of expiry |
| issuingCountry | NSString | 3 | Country of issue as ([ISO 3166-1 alpha-3](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-3) country code |
| lastName | NSString | 100 | Last name of the customer|
| firstName | NSString | 100 | First name of the customer|
| middleName | NSString | 100 | Middle name of the customer |
| dob | NSDate | | Date of birth |
| gender | NetverifyGender | | Gender M or F |
| originatingCountry | NSString | 3|Country of origin as ([ISO 3166-1 alpha-3](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-3) country code |
| addressLine | NSString | 64 | Street name	|
| city | NSString | 64 | City |
| subdivision | NSString | 3 | Last three characters of [ISO 3166-2:US](http://en.wikipedia.org/wiki/ISO_3166-2:US) state code	|
| postCode | NSString | 15 | Postal code |
| mrzData |  NetverifyMrzData | | MRZ data, see table below |
| optionalData1 | NSString | 50 | Optional field of MRZ line 1 |
| optionalData2 | NSString | 50 | Optional field of MRZ line 2 |
| placeOfBirth | NSString | 255 | Place of Birth |
| extractionMethod | NetverifyExtractionMethod | | Extraction method used during scanning (MRZ, OCR, BARCODE, BARCODE_OCR or NONE) |

Class **_NetverifyMrzData_**

| Parameter |Type | Max. length | Description |
|:---------------|:------------- |:-------------|:-----------------|
| format | NetverifyMRZFormat | |
| line1 | NSString | 50 | MRZ line 1 |
| line2 | NSString | 50 | MRZ line 2 |
| line3 | NSString | 50| MRZ line 3 |
| idNumberValid | BOOL| | True if ID number check digit is valid, otherwise false |
| dobValid | BOOL | | True if date of birth check digit is valid, otherwise false |
| expiryDateValid |	BOOL| |	True if date of expiry check digit is valid or not available, otherwise false|
| personalNumberValid | BOOL | | True if personal number check digit is valid or not available, otherwise false |
| compositeValid | BOOL | | True if composite check digit is valid, otherwise false |

**_Error codes_** that are available via the `code` property of the NSError object:

| Code | Message  | Description |
| :----------------------------: |:-------------|:-----------------|
| 100<br/>110<br/>130<br/>140<br/>150<br/>160 | We have encountered a network communication problem | Retry possible, user decided to cancel |
| 200<br/>210<br/>220 | Authentication failed | API credentials invalid, retry impossible |
| 230 | No Internet connection available | Retry possible, user decided to cancel |
| 240 | Scanning not available this time, please contact the app vendor | Resources cannot be loaded, retry impossible |
| 250 | Cancelled by end-user | No error occurred |
| 260 | The camera is currently not available | Camera cannot be initialized, retry impossible |
| 280 | Certificate not valid anymore. Please update your application | End-to-end encryption key not valid anymore, retry impossible |
| 290 | Transaction already finished | User did not complete SDK journey within token lifetime|

## Callback
To get information about callbacks, Netverify Retrieval API, Netverify Delete API and Global Netverify settings and more, please read our [page with server related information](https://github.com/Jumio/implementation-guides/blob/master/netverify/callback.md).
