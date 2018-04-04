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
- [Custom UI](#custom-ui)
- [Callback](#callback)

## Release notes
For technical changes, please read our [transition guide](transition-guide_netverify-fastfill.md)  SDK version: 2.11.0.

## Setup
The [basic setup](../README.md#basic-setup) is required before continuing with the following setup for Netverify.

## Initialization
Log into the Jumio Customer Portal. You will find your API token and API secret on the "Settings" page under "API credentials". We strongly recommend that you store your credentials outside your app. If the token and secret are not set in the `NetverifyConfiguration` object, an exception will be thrown. Please note that in Swift you need to catch the underlying exception and translate it into a `NSError` instance.
Whenever an exception is thrown, the `NetverifyViewController` instance will be nil and the SDK is not usable. Make sure that all necessary configuration is set before the `NetverifyConfiguration` instance is passed to the initializer.

```
NetverifyConfiguration *config = [NetverifyConfiguration new];
config.merchantApiToken = @"YOURAPITOKEN";
config.merchantApiSecret = @"YOURAPISECRET";
config.dataCenter = JumioDataCenterEU; // Change this parameter if your account is in the EU data center. Default is US.
config.delegate = self;

NetverifyViewController *netverifyViewController;
@try {
	netverifyViewController = [[NetverifyViewController alloc] initWithConfiguration:config];
} @catch (NSException *exception) {
	// HANDLE EXCEPTION
}
```

It is possible to update parameters of the configuration when a scan is finished with an error and the user is required to perform another scan. This can only be used if the SDK is currently not presented.
```
[netverifyViewController updateConfiguration:config];
```

Make sure initialization and presentation are timely within one minute. On iPads, the presentation style `UIModalPresentationFormSheet` is default and mandatory.
```
[self presentViewController: netverifyViewController animated: YES completion: nil];
```

## Configuration

### ID verification
The SDK defaults to Fastfill mode, which performs data extraction only. No ID verification occurs in the default mode.

Enable ID verification to receive a verification status and verified data positions (see [Callback for Netverify](https://github.com/Jumio/implementation-guides/blob/master/netverify/callback.md#callback-for-netverify)). Ensure that your customer account is allowed to use this feature.
A callback URL can be specified for individual transactions (for constraints see chapter [Callback URL](https://github.com/Jumio/implementation-guides/blob/master/netverify/portal-settings.md#callback-url)). This setting overrides any callback URL you have set in the Jumio Customer Portal.

__Note:__ Not available for accounts configured as Fastfill only.
```
config.requireVerification = YES;
config.callbackUrl = @"YOURCALLBACKURL";
```

You can enable Identity Verification if it is enabled for your account. Make sure to link the UMoove framework to your app project.

__Note:__ Identity Verification requires portrait orientation in your app.
```
config.requireFaceMatch = YES;
```

### Preselection
You can specify issuing country ([ISO 3166-1 alpha-3](http://en.wikipedia.org/wiki/ISO_3166-1_alpha-3) country code), ID type, and/or document variant. When all three parameters are preselected, the document selection screen in the SDK can be skipped entirely.

__Note:__ Fastfill does not support paper IDs, except German ID cards.
```
config.preselectedCountry = @"AUT";
config.preselectedDocumentTypes = NetverifyDocumentTypePassport | NetverifyDocumentTypeVisa;
config.preselectedDocumentVariant = NetverifyDocumentVariantPlastic;
```

### Transaction identifiers
The merchant scan reference allows you to specify your own unique identifier for the scan (max. 100 characters).

__Note:__ Must not contain sensitive data like PII (Personally Identifiable Information) or account
login.
```
config.merchantScanReference = @"YOURSCANREFERENCE";
```
Use the following property to identify the scan in your reports (max. 100 characters).
```
config.merchantReportingCriteria = @"YOURREPORTINGCRITERIA";
```
You can also set a unique identifier for each of your customers (max. 100 characters).

__Note:__ Must not contain sensitive data like PII (Personally Identifiable Information) or account
login.
```
config.customerId = @"CUSTOMERID";
```

To send some additional information use the property `additionalInformation`.

__Note:__ Must not contain sensitive data like PII (Personally Identifiable Information) or account
login.
```
config.additionalInformation = @"ADDITONAL INFORMATION";
```

### Analytics Service
Use the following setting to explicitly send debug information to Jumio.
```
config.sendDebugInfoToJumio = YES;
```
__Note:__ Only set this property to true if you are asked by Jumio Support.

When `sendDebugInfoToJumio` is enabled, get `debugID` shortly before dismissing the SDK to receive the current debug session ID.
```
NSUUID *debugSessionID = self.netverifyViewController.debugID;
```

### Offline scanning

If you want to use the SDK in offline mode please contact Jumio Support at support@jumio.com or https://support.jumio.com. Once this feature is enabled for your account, you can find your offline token in your Jumio customer portal on the "Settings" page in the "API credentials" section.

```
config.offlineToken = @"YOUROFFLINETOKEN";
```

An exception will be thrown at initialization time and the `NetverifyViewController` instance will be nil if:
- the bundle identifier of your app does not match with the token
- the token is expired
- the wrong product is used
- the token itself is invalid

### Miscellaneous

When using Fastfill (requireVerification=NO), you can limit data extraction to be done on the device only by enabling `dataExtractionOnMobileOnly`.
```
config.dataExtractionOnMobileOnly = YES;
```

Use `cameraPosition` to set the default camera (front or back).
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
[Jumio Surface](https://jumio.github.io/surface-ios) is a web tool that allows you to apply and visualize, in real-time, all available customization options. It also provides an export feature to save your applied changes, so you can import them directly into your codebase.

## Delegation
Implement the delegate methods of the `NetverifyViewControllerDelegate` protocol to be notified of successful initialization, successful scans, and error situations. Dismiss the `NetverifyViewController` instance in your app in case of success or error.

### Initialization
When this method is fired, the SDK has finished initialization and loading tasks, and is ready to use. The error object is only set when an error has occurred (e.g. wrong credentials are set or a network error occurred).
```
- (void) netverifyViewController: (NetverifyViewController*) netverifyViewController didFinishInitializingWithError:(NetverifyError*) error {
	if (error) {
		NSString* errorCode = error.code;
		NSString* errorMessage = error.message
	}
}
```

### Success
Upon success, the extracted document data is returned, including its scan reference. Call clear on the document data object after processing the card information to make sure no sensitive data remains in the device's memory.
```
- (void) netverifyViewController: (NetverifyViewController*) netverifyViewController didFinishWithDocumentData: (NetverifyDocumentData*) documentData scanReference: (NSString*) scanReference  {
	// YOURCODE
}
```

### Error
This method is fired when the user presses the cancel button during the workflow or in an error situation. The parameter `error` contains an error code and a message. The corresponding scan reference is also available.
```
- (void) netverifyViewController: (NetverifyViewController*) netverifyViewController didCancelWithError: (NetverifyError*) error scanReference: (NSString*) scanReference {
	NSString* errorCode = error.code;
	NSString* errorMessage = error.message
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
| issuingCountry | NSString | 3 | Country of issue as [ISO 3166-1 alpha-3](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-3) country code |
| lastName | NSString | 100 | Last name of the customer|
| firstName | NSString | 100 | First name of the customer|
| middleName | NSString | 100 | Middle name of the customer |
| dob | NSDate | | Date of birth |
| gender | NetverifyGender | | Gender M, F, or X |
| originatingCountry | NSString | 3|Country of origin as [ISO 3166-1 alpha-3](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-3) country code |
| addressLine | NSString | 64 | Street name	|
| city | NSString | 64 | City |
| subdivision | NSString | 3 | Last three characters of [ISO 3166-2:US](http://en.wikipedia.org/wiki/ISO_3166-2:US) state code	|
| postCode | NSString | 15 | Postal code |
| mrzData |  NetverifyMrzData | | MRZ data, see table below |
| optionalData1 | NSString | 50 | Optional field of MRZ line 1 |
| optionalData2 | NSString | 50 | Optional field of MRZ line 2 |
| placeOfBirth | NSString | 255 | Place of birth |
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
| expiryDateValid | BOOL| | True if date of expiry check digit is valid or not available, otherwise false|
| personalNumberValid | BOOL | | True if personal number check digit is valid or not available, otherwise false |
| compositeValid | BOOL | | True if composite check digit is valid, otherwise false |

**_Error codes_** that are available via the `code` property of the NetverifyError object:

| Code | Message  | Description |
| :----------------------------: |:-------------|:-----------------|
| A10000 | We have encountered a network communication problem | Retry possible, user decided to cancel |
| B10000 | Authentication failed | Secure connection could not be established, retry impossible |
| C10401 | Authentication failed | API credentials invalid, retry impossible |
| D10403 | Authentication failed | Wrong API credentials used, retry impossible |
| E20000 | No Internet connection available | Retry possible, user decided to cancel |
| F00000 | Scanning not available this time, please contact the app vendor | Resources cannot be loaded, retry impossible |
| G00000 | Cancelled by end-user | No error occurred |
| H00000 | The camera is currently not available | Camera cannot be initialized, retry impossible |
| I00000 | Certificate not valid anymore. Please update your application | End-to-end encryption key not valid anymore, retry impossible |
| J00000 | Transaction already finished | User did not complete SDK journey within token lifetime |
| Y00000 | The barcode of your document didn´t contain your address, turn your document and scan the front. | **Only Custom UI:** Scanned Barcode (e.g. US Driver License) does not contain address information. Show hint and/or call `retryAfterError` |
| Z00000 | You recently scanned the front of your document. Please flip your document and scan the back. | **Only Custom UI:** Backside of the document was scanned but most likely the frontside of the document was detected. Show hint and/or call `retryAfterError` |

The first letter (A-J) represents the error case. The remaining characters are represented by numbers that contain information helping us understand the problem situation. Please always include the whole code when filing an error related issue to our support team.


## Custom UI

Netverify can also be implemented as a custom scan view. This means that only the scan view controllers (including the scan overlays) are provided by the SDK.
The handling of the lifecycle, document selection, readability confirmation, error handling, and all other steps necessary to complete a scan have to be handled by the client application that implements the SDK.

To use the custom UI with a plain scanning user interface, specify an instance of your class which implements the `NetverifyUIControllerDelegate`. Initialize the SDK by creating a NetverifyUIController with the neccessary NetverifyConfiguration. Please note that instead of delegate property, customUIDelegate has to be set in the configuration object.

```
NetverifyConfiguration *config = [NetverifyConfiguration new];
config.merchantApiToken = @"YOURAPITOKEN";
config.merchantApiSecret = @"YOURAPISECRET";
config.dataCenter = JumioDataCenterEU; // Change this parameter if your account is in the EU data center. Default is US.
config.customUIDelegate = self;

NetverifyUIController *netverifyUIController;
@try {
	NetverifyUIController = [[NetverifyUIController alloc] initWithConfiguration:config];
} @catch (NSException *exception) {
	// HANDLE EXCEPTION
}
```

After initializing, the SDK is set up and loads all necessary resources for scanning. As soon as setup is complete and the required information is loaded, the following delegate method is called and returns the available countries and documentTypes. Only the NetverifyCountries and NetverifyDocuments which validate with the settings used in the NetverifyConfiguration will be returned here. This method is only called when there is more than one option available to select.

```
- (void) netverifyUIController: (NetverifyUIController* _Nonnull) netverifyUIController didDetermineAvailableCountries:(NSArray * _Nonnull)countries suggestedCountry:(NetverifyCountry * _Nullable)country {
	//display your UI elements here
}
```

**NetverifyCountry** contains the following information:
```
@property (strong, nonatomic, readonly) NSString* _Nonnull code; //The ISO 3166-1 Alpha 3 code
@property (strong, nonatomic, readonly) NSString* _Nonnull name; //The localized country name according to the locale of the device
@property (nonnull, strong, nonatomic, readonly) NSArray<NetverifyDocument*>* documents; //List of pre-filtered NetverifyDocuments available of this country.
```
**NetverifyDocument** contains the following information:
```
@property (strong, nonatomic, readonly) NSString* _Nonnull code; //The ISO 3166-1 Alpha 3 code
@property (nonatomic, assign, readonly) NetverifyDocumentType type; //The type of the document
@property (nonatomic, assign) NetverifyDocumentVariant selectedVariant; //This property has to be set before calling setupWithDocument:
```

### Start scanning

Use this method to set up the NetverifyUIController correctly before any scan view can be displayed. Provide one NetverifyDocument via `setupWithDocument:` delegate method. Please note that when a paper-format document is used, selectedVariant has to be set in advance by calling the following method:

```
- (void) setupWithDocument:(NetverifyDocument* _Nonnull)document;
```

After `setupWithDocument:` is called on NetverifyUIController, the necessary scan view controllers are determined. While the order of the scan view controllers (Front, Back, Face) is predefined, only the required ones will be returned in this method. The `NetverifyCustomScanViewController` instance is to be presented and dismissed by the client application. Modal presentation style should be used.
```
- (void) netverifyUIController: (NetverifyUIController* _Nonnull) netverifyUIController didDetermineNextScanViewController:(NetverifyCustomScanViewController* _Nonnull)scanViewController isFallback:(BOOL)isFallback {

	scanViewController.customScanViewControllerDelegate = self;

	//present scanViewController modally
	[self presentViewController:scanViewController animated:YES completion:^{
		//add your own elements on scanViewController.customOverlayLayer
	}];
}
```

As soon as netverifyScanViewController is presented you can add your own UI elements to the `customOverlayLayer`. Make sure that you only add subviews to the `customOverlayLayer` view, which is drawn fullscreen over the cameraPreview and overlays necessary for scanning (e.g. passport MRZ Overlay). Please use `overlayFrame` which returns a CGRect and indicates at what area the preview must be visible.

#### Handling Camera Session

When displaying fullscreen help, the capturing process can be paused via `pauseScan` and restarted via `retryScan`. Please note that only the detection is paused. The camera preview continues to display the current camera feed.

Each `NetverifyCustomScanViewController` returns a scan mode, which indicates what type of scanView is displayed.

**NetverifyScanMode** values: `MRZ`, `Barcode`, `Face`, `Manual`, `OCR`, `OCR_Template`

Please note that when a _manual_ scan view is displayed, a shutter button also has to be displayed. Use `isImagePicker` to check if a button needs to be displayed, and call `takeImage` as target action when the shutter button is tapped.

Use `hasFlash`, `isFlashOn`, `canToggleFlash`, and `toggleFlash` to handle the flash mode.
Use `hasMultipleCameras`, `currentCameraPosition`, `canSwitchCamera`, and `switchCamera` to determine and change camera position.

For scan mode `Face`, only front facing camera can be used.

#### End-user help

The `NetverifyCustomScanViewController` can also be used to receive the suggested help texts.
Via `localizedShortHelpText` and `localizedLongHelpText` variations of the help texts can be received.
`currentStep` returns the running number of scan view controllers, and, in combination with `totalSteps`, it can be used to display the progress in the workflow.

In some rare cases, scanning might not be possible for the end-user (e.g. their driver license has no barcode on the back).
Therefore we suggest displaying a button in case `isFallbackAvailable` is true. Call `switchToFallback` after the user has pressed it.
When calling, a new scan view controller will be returned scanning the same scan side of the document.

**NetverifyScanSide** values: `Front`, `Back`, `Face`

Please see the sample implementation in our sample project.

#### Custom Scan View Delegate

Make sure to also implement the `NetverifyCustomScanViewControllerDelegate` protocol and set the `customScanViewControllerDelegate` to the received scanViewController before presenting.

For some countries, end-users need to be informed about some legal constraints before scanning. In this case `netverifyCustomScanViewController:shouldDisplayLegalAdvice:completion:` is called. Make sure to display the message provided via this call.

After a successful scan, it makes sense to present the captured image and ask to finally confirm that the image should be used. In this case `netverifyCustomScanViewController:shouldDisplayConfirmationWithImageView:text:confirmation:retake:` is called. Simply add this view as subview and it will draw itself accordingly. We suggest asking the user if the image is readable and properly aligned to prevent bad quality images. Continue with calling one of the two provided blocks.

### Finalizing Scanning

When all necessary parts are captured `netverifyUIControllerDidCaptureAllParts:` is called. Be aware that network tasks are still ongoing. We advise showing a loading animation, as in case of a network error further action is required (retry or cancel).

### Retrieving information in the Custom UI

#### Result and Error handling

Upon `netverifyUIController:didDetermineError:retryPossible:` every error that leaves the SDK in a pending state is forwarded.
By calling `retryAfterError`, the process that leads to the error can be retried. With `cancel`, the whole SDK workflow is canceled. Please see how this is handled in the the sample implementation for more information.

The delegate method `netverifyUIController:didFinishWithDocumentData:canReference:` for successful SDK workflows and `netverifyUIController:didCancelWithError:scanReference:` for aborted SDK workflows must be implemented to handle final result data.

Please find the section [Retrieving information](#retrieving-information) to see more about returning extracted data.

#### Clean up
After handling the result, please clean up the SDK by setting your property that holds the Netverify SDK to nil.


## Callback
To get information about callbacks, Netverify Retrieval API, Netverify Delete API, Global Netverify settings, and more, please read our [page with server related information](https://github.com/Jumio/implementation-guides/blob/master/netverify/callback.md).
