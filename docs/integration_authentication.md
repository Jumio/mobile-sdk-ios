![Jumio Authentication](images/authentication.jpg)

# Authentication SDK for iOS
Biometric-based Jumio Authentication establishes the digital identities of your users through the simple act of taking a selfie. Advanced 3D face map technology quickly and securely authenticates users and unlocks their digital identities.

## Table of Content
- [Release note](#release-notes)
- [Setup](#setup)
- [Initialization](#initialization)
- [Configuration](#configuration)
- [Customization](#customization)
- [SDK Workflow](#sdk-workflow)
- [Custom UI](#custom-ui)
- [Callback](#callback)

## Release notes
Please refer to our [Change Log](changelog.md) for more information. Current SDK version: 3.7.1

For breaking technical changes, please read our [transition guide](transition-guide_authentication.md)

## Setup
The [basic setup](../README.md#basics) is required before continuing with the following setup for Authentication.

## Initialization
When logged into the Jumio Customer Portal, you will find your API token and API secret on the **Settings** page under **API credentials**. We strongly recommend that you store your credentials outside your app. If the token and secret are not set in the [`AuthenticationConfiguration`](https://jumio.github.io/mobile-sdk-ios/NetverifyFace/Classes/AuthenticationConfiguration.html) object, an exception will be thrown. Please note that in Swift you need to catch the underlying exception and translate it into a `NSError` instance.
Whenever an exception is thrown, the [`AuthenticationController`](https://jumio.github.io/mobile-sdk-ios/NetverifyFace/Classes/AuthenticationController.html) instance will be nil and the SDK is not usable. Make sure that all necessary configuration is set before the `AuthenticationConfiguration` instance is passed to the initializer.
```objectivec
AuthenticationConfiguration *config = [AuthenticationConfiguration new];
config.apiToken = @"YOURAPITOKEN";
config.apiSecret = @"YOURAPISECRET";
config.dataCenter = JumioDataCenterUS; // Set this parameter to match the data center where your account is registered.
config.delegate = self;

AuthenticationController *authenticationController;
@try {
	authenticationController = [[AuthenticationController alloc] initWithConfiguration:config];
} @catch (NSException *exception) {
	// HANDLE EXCEPTION
}
```

The default data center is `JumioDataCenterUS`. If your customer account is in the EU data center, use `JumioDataCenterEU` instead. Alternatively, use `JumioDataCenterSG` for Singapore.

### Jailbreak detection
We advice to prevent our SDK to be run on jailbroken devices. Either use the method below or a self-devised check to prevent usage of SDK scanning functionality on jailbroken devices:
```objectivec
[JumioDeviceInfo isJailbrokenDevice]
```

## Configuration
### Transaction reference

In order to connect the Authentication transaction to a specific ID Verification transaction the parameter [`enrollmentTransactionReference`](https://jumio.github.io/mobile-sdk-ios/NetverifyFace/Classes/AuthenticationConfiguration.html#/c:objc(cs)AuthenticationConfiguration(py)enrollmentTransactionReference) must be set.
```objectivec
config.enrollmentTransactionReference = @"ENROLLMENTTRANSACTIONREFERENCE";
```
In case an Authentication transaction has been created via the facemap server to server API [`authenticationTransactionReference`](https://jumio.github.io/mobile-sdk-ios/NetverifyFace/Classes/AuthenticationConfiguration.html#/c:objc(cs)AuthenticationConfiguration(py)authenticationTransactionReference) should be used. Therefore `enrollmentTransactionReference` should not be set.
```objectivec
config.authenticationTransactionReference = @"AUTHENTICATIONTRANSACTIONREFERENCE";
```

__Note:__ If the enrollment or authentication transaction reference is not eligible to be used (e.g. reference does not exist in the system, mandatory user data has been deleted) an error is returned when the SDK is initialized.

### Transaction identifiers

In order to connect the Authentication transaction to a specific user identity a user reference (max. 100 characters) must be set.

```objectivec
config.userReference = @"USERREFERENCE";
```

__Note:__ Transaction identifiers must not contain sensitive data like PII (Personally Identifiable Information) or account login.


### Callback
In addition to the on-device result of the transaction, it is possible to define a callbackUrl (see [Callback for Authentication](https://github.com/Jumio/implementation-guides/blob/master/netverify/callback.md#callback-for-netverify)). A callback URL can be specified for individual transactions (for constraints see chapter [Callback URL](https://github.com/Jumio/implementation-guides/blob/master/netverify/portal-settings.md#callback-url)). This setting overrides any callback URL you have set in the Jumio Customer Portal.

```objectivec
config.callbackUrl = @"YOURCALLBACKURL";
```
__Note:__ The callback URL must not contain sensitive data like PII (Personally Identifiable Information) or account login.


### Analytics service
Use the following setting to explicitly send debug information to Jumio.
```objectivec
config.sendDebugInfoToJumio = YES;
```
__Note:__ Only set this property to true if you are asked by Jumio Support.

When `sendDebugInfoToJumio` is enabled, you receive a list of the current DebugSessionID by using `debugID`. This method should be called either shortly after initializing or before dismissing the SDK.
```objectivec
NSUUID *debugSessionID = self.netverifyViewController.debugID;
```

## Customization

### Customize look and feel
Customizable aspects include:
- General: disable blur, blur style, background color, foreground color, font
- Navigation bar: title image, title color, tint color and bar tint color
- Scan overlay: oval color, progress color, feedback text color, feedback background color
- Positive button (Submit): title color and background
- Negative button (Cancel): title color and background

__Note:__ Customizations should be applied before the SDK is initialized.

## SDK Worfklow
Implement the delegate methods of the [`AuthenticationControllerDelegate`](https://jumio.github.io/mobile-sdk-ios/NetverifyFace/Protocols/AuthenticationControllerDelegate.html) protocol to be notified of successful initialization, successful scans, and error situations. Dismiss the `AuthenticationController` instance in your app in case of success or error.

### Initialization
When this method is fired, the SDK has finished initializing and loading tasks and is ready to use. The UIViewController object should be used to modally present the authentication scan view controller.
```objectivec
- (void) authenticationController: (AuthenticationController*) authenticationController didFinishInitializingScanViewController: (UIViewController*) scanViewController {
    [self presentViewController: scanViewController animated:YES completion:nil];
}
```

### Success
Upon success, the authentication outcome is returned,  including its transaction reference.
```objectivec
- (void) authenticationController: (AuthenticationController*) authenticationController didFinishWithAuthenticationResult:(AuthenticationResult)authenticationResult transactionReference: (NSString*) transactionReference  {
	// YOURCODE
}
```

### Error
This method is fired when the user presses the cancel button during the workflow or in an error situation. The parameter `error` contains an error code and a message. The corresponding transaction reference is also available.
```objectivec
- (void) authenticationController: (AuthenticationController*) authenticationController didFinishWithError: (AuthenticationError*) error transactionReference: (NSString* _Nullable) transactionReference {
	NSString* errorCode = error.code;
	NSString* errorMessage = error.message
}
```

### Cleanup
After the SDK is dismissed, and especially if you want to create a new instance of AuthenticationController, make sure to call [`destroy`](https://jumio.github.io/mobile-sdk-ios/NetverifyFace/Classes/AuthenticationController.html#/c:objc(cs)AuthenticationController(im)destroy) to ensure proper cleanup of the SDK.
```objectivec
[self.authenticationController destroy];
self.authenticationController = nil;
```
__Note:__ Only call `destroy` after `authenticationController:didFinishWithAuthenticationResult:transactionReference:` or `authenticationController:didFinishWithError:transactionReference:` was called to ensure that Authentication SDK is in a final state. Setting `AuthenticationController` to nil is essential to free memory as soon as possible.

### Retrieving information
The following tables give information on the specification of all transaction data parameters and errors.

#### Authentication result
| Parameter | Type | Max. length | Description  |
|:-------------------|:----------- 	|:-------------|:-----------------|
| authenticationResult | AuthenticationResult | | SUCCESS, FAILED |

#### Error codes
List of all **_error codes_** that are available via the `code` property of the AuthenticationError object. The first letter (A-M) represents the error case. The remaining characters are represented by numbers that contain information helping us understand the problem situation ([x][yyyy]).

| Code | Message  | Description |
| :----------------------------: |:-------------|:-----------------|
| A[x][yyyy]| We have encountered a network communication problem | Retry possible, user decided to cancel |
| B[x][yyyy]| Authentication failed | Secure connection could not be established, retry impossible |
| C[x]0401 | Authentication failed | API credentials invalid, retry impossible |
| E[x]0000 | No Internet connection available | Retry possible, user decided to cancel |
| F00000 | Scanning not available at this time, please contact the app vendor | Resources cannot be loaded, retry impossible |
| G00000 | Cancelled by end-user | No error occurred |
| H00000 | The camera is currently not available | Camera cannot be initialized, retry impossible |
| I00000 | Certificate not valid anymore. Please update your application | End-to-end encryption key not valid anymore, retry impossible |
| J00000 | Transaction already finished | User did not complete SDK journey within session lifetime |
| L00000 | Enrollment transaction reference invalid | The provided enrollment transaction reference can not be used for an authentication |
| M00000 | The scan could not be processed | An error happened during the processing. The SDK needs to be started again |

__Note:__ Please always include the whole code when filing an error related issue to our support team.

## Custom UI
The Custom UI functionality of the Authentication SDK enables you to handle as much UI activity as possible by yourself, e.g. loading, help or error screens. Make use of it by implementing the [`AuthenticationScanViewControllerDelegate`](https://jumio.github.io/mobile-sdk-ios/NetverifyFace/Protocols/AuthenticationScanViewControllerDelegate.html). Initialize the SDK by creating a [`AuthenticationController`](https://jumio.github.io/mobile-sdk-ios/NetverifyFace/Classes/AuthenticationController.html) by passing your customised `AuthenticationConfiguration` object to its constructor.

__Note:__ In addition to the `delegate` property, `authenticationScanViewControllerDelegate` has to be set in the configuration object.

```objectivec
AuthenticationConfiguration *config = [AuthenticationConfiguration new];
config.apiToken = @"YOURAPITOKEN";
config.apiSecret = @"YOURAPISECRET";
config.dataCenter = JumioDataCenterEU; // Change this parameter if your account is in the EU data center. Default is US.
config.delegate = self;
config.authenticationScanViewControllerDelegate = self;

AuthenticationController *authenticationController;
@try {
	authenticationController = [[AuthenticationController alloc] initWithConfiguration:config];
} @catch (NSException *exception) {
	// HANDLE EXCEPTION
}
```

### Start scanning
After initialisation is finished, the SDK is ready for scanning and the following delegate method is called returning a [`AuthenticationScanViewController`](https://jumio.github.io/mobile-sdk-ios/NetverifyFace/Classes/AuthenticationScanViewController.html) instance to present. Use its `customOverlayLayer` property to add subviews on top.

```objectivec
- (void) authenticationController: (AuthenticationController*) authenticationController didFinishInitializingScanViewController:(AuthenticationScanViewController*)scanViewController {
	[self presentViewController:scanViewController animated:YES completion:^{
		//display your UI elements to the `scanViewController.customOverlayLayer` here, e.g. add a close button

	}];
}
```

As soon as scanViewController is presented you can add your own UI elements to the `customOverlayLayer`. Make sure that you only add subviews to the `customOverlayLayer` view, and ensure that your UI elements don't overlap with the scanning UI to get the best user experience and a positive result.

The method `authenticationScanViewController:shouldRequireUserConsentWithURL:` in [`AuthenticationScanViewControllerDelegate`](https://jumio.github.io/mobile-sdk-ios/NetverifyFace/Protocols/AuthenticationScanViewControllerDelegate.html) is invoked when the end-user’s consent to Jumio’s privacy policy is legally required. [`userConsentGiven:`](https://jumio.github.io/mobile-sdk-ios/NetverifyFace/Classes/AuthenticationScanViewController.html#/c:objc(cs)AuthenticationScanViewController(im)userConsentGiven:) needs to be called after the end-user has accepted.

### Handle scanning workflow
For handling of the scanning workflow, a few additional delegates need to be implemented and handled. When the user has finished the scanning process and biometric data is being analysed, `authenticationScanViewControllerDidStartBiometricAnalysis:` is fired. We recommend to display a loading activity info to the user that should not last longer than a few seconds. When successful, scanning is being finalized (see paragraph below).

In case of an unsuccessful result, the delegate `authenticationScanViewController:shouldDisplayHelpWithText:animationView:forReason:` is called. A help text and animated view is provided based on the problem the user was facing. It is important to display the help animation and text in order to assist the user in finishing the scanning workflow successfully. To let the user confirm the information and retry in the workflow, simply call `retryScan` on the `authenticationScanViewController` parameter provided in the delegate.

It is possible to determince if an error situation is recoverable (e.g. network tasks) via the delegate `authenticationScanViewController:didDetermineRecoverableError:`. In this case, you can display the error message to the user and call `retryAfterError` on the `authenticationScanViewController` on user confirmation.

### Finalizing Scanning
Final states are handled with the existing delegates for [Success](#success) and [Error](#error).

## Callback
To get information about callbacks, please refer to our [page with server related information](https://github.com/Jumio/implementation-guides/blob/master/netverify/callback.md#callback-for-authentication).
