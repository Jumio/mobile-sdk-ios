![ID Verification](images/jumio_feature_graphic.jpg)

# Integration Guide for iOS SDK
Jumio’s products allow businesses to establish the genuine identity of their users by verifying government-issued IDs in real-time. ID Verification, Identity Verification and other services are used by financial service organizations and other leading brands to create trust for safe onboarding, money transfers, and user authentication.

## Table of Contents
- [Release Notes](#release-notes)
- [Setup](#setup)
- [Dependencies](#dependencies)
  - [Cocoapods](#via-cocoapods)
  - [Carthage](#via-carthage)
  - [Manual](#manually)
- [Initialization](#initialization)
- [Configuration](#configuration)
- [Customization](#customization)
- [SDK Workflow](#sdk-workflow)
- [Custom UI](#custom-ui)
  - [Instant Feedback](#instant-feedback)
- [Callback](#callback)
- [Code Documentation](https://jumio.github.io/mobile-sdk-ios/Jumio/)

## Release Notes
Please refer to our [Change Log](changelog.md) for more information. Current SDK version: __4.3.1__

For breaking technical changes, please read our [Transition Guide](transition_guide.md).

## Setup
The [basic setup](../README.md#basics) is required before continuing with the following setup for the Jumio SDK. If you are updating your SDK to a newer version, please also refer to:

:arrow_right:&nbsp;&nbsp;[Changelog](docs/changelog.md)    
:arrow_right:&nbsp;&nbsp;[Transition Guide](docs/transition_guide.md)

### NFC Setup
To make our SDK capable of reading NFC chips you will need to set the following settings:

Add the Near Field Communication Tag Reading capability to your project, App ID and provisioning profiles in [Apple Developer portal](https://developer.apple.com).
Add `NFCReaderUsageDescription` to your __info.plist__ file with a proper description of why you are using this feature. You will also need to add the following key and value to your plist file to be able to read NFC chips from passports:
```
<key>com.apple.developer.nfc.readersession.iso7816.select-identifiers</key>
<array>
    <string>A0000002471001</string>
</array>
```

#### SDK Version Check
Use [`Jumio.SDK.version`][sdkVersion] to check which SDK version is being used.


### Jailbreak Detection
For security reasons, applications implementing the SDK should not run on jailbroken devices. Use either the below method [`isJailbroken`][isJailbroken] or a self-devised check to prevent usage of SDK scanning functionality on jailbroken devices.
```
Jumio.SDK.isJailbroken
```

⚠️&nbsp;&nbsp;__Note:__ Please be aware that the JumioSDK jailbreak check uses various mechanisms for detection, but doesn't guarantee to detect 100% of all jailbroken devices.

### Build Settings
For security reasons, you should set the following build settings:
To generate a position independent executable, the build settings "Generate Position-Dependent Executable" and "Generate Position-Dependent Code" should both be set to "No".
For Objective-C projects, you should enable stack canaries by adding "-fstack-protector-all" to "Other C Flags".
For Objective-C projects, you should set "Objective-C Automatic Reference Counting" to "Yes".

# Dependencies

### Via Cocoapods
Jumio supports CocoaPods as dependency management tool for easy integration of the SDK. You are required to use **Cocoapods 1.11.0** or newer.

If you are not yet using Cocoapods in your project, first run:
```
sudo gem install cocoapods
pod init
```
Then update your local clone of the specs repo in Terminal to ensure that you are using the latest podspec files using:
```
pod repo update
```
Adapt your Podfile and add the pods according to the product(s) you want use. Check the following example how a Podfile could look like, with a list of all available Jumio pods:

⚠️⚠️&nbsp;&nbsp;__Note:__ Please do not include everything! Make sure to __only__ use pods that provide to the services you need!
```
source 'https://github.com/CocoaPods/Specs.git'

platform :ios, '11.0'
use_frameworks! # Required for proper framework handling

pod 'Jumio/Slim', '~>4.3.1' # Manual Capture functionality
pod 'Jumio/LineFinder', '~>4.3.1' # Manual Capture and Linefinder functionality
pod 'Jumio/MRZ', '~>4.3.1' # Manual Capture and MRZ functionality
pod 'Jumio/Barcode', '~>4.3.1' # Manual Capture and Barcode functionality
pod 'Jumio/NFC', '~>4.3.1' # Manual Capture, Linefinder, MRZ and NFC functionality

pod 'Jumio/Jumio', '~>4.3.1' # Use JumioSDK with all available scanning methods

pod 'Jumio/SlimLiveness', '~>4.3.1' # Manual Capture and Liveness functionality
pod 'Jumio/LineFinderLiveness', '~>4.3.1' # Manual Capture, Linefinder and Liveness functionality
pod 'Jumio/MRZLiveness', '~>4.3.1' # Manual Capture, MRZ and Liveness functionality
pod 'Jumio/BarcodeLiveness', '~>4.3.1' # Manual Capture, Barcode and Liveness functionality
pod 'Jumio/NFCLiveness', '~>4.3.1' # Manual Capture, Linefinder, MRZ, NFC and Liveness functionality

pod 'Jumio/Liveness', '~>4.3.1' # All available scanning methods and Liveness functionality

pod 'Jumio/DocFinder', '~>4.3.1' # Autocapture functionality

pod 'Jumio/DeviceRisk', '~>4.3.1' # Device fingerprinting functionality (optional)
pod 'Jumio/Datadog', '~>4.3.1' # Analytics functionality (optional)
```

#### Certified Face Liveness
Jumio uses Certified Liveness technology to determine liveness.
Please make sure to add the following post-install hook to your Podfile if you are using Jumio's liveness provider iProov:

```
pod 'Jumio/xxxLiveness'

# mandatory for all functionalities that include liveness (iProov)
post_install do |installer|
  installer.pods_project.targets.each do |target|
    if ['iProov', 'Socket.IO-Client-Swift', 'Starscream'].include? target.name
      target.build_configurations.each do |config|
          config.build_settings['BUILD_LIBRARY_FOR_DISTRIBUTION'] = 'YES'
      end
    end
  end
end
```

Install the pods to your project via Terminal:
```
pod install
```

#### Datadog
If you are using Datadog analytics, please also include `'DatadogSDK'` in your target names of your post-install hook.
For more details, please refer to section [Analytics With Datadog](../README.md#analytics-with-datadog).

```
# mandatory for all functionalities that include liveness (iProov)
post_install do |installer|
  installer.pods_project.targets.each do |target|
    if ['iProov', 'Socket.IO-Client-Swift', 'Starscream', 'DatadogSDK'].include? target.name
      target.build_configurations.each do |config|
          config.build_settings['BUILD_LIBRARY_FOR_DISTRIBUTION'] = 'YES'
      end
    end
  end
end
```

### Via Carthage

##### ⚠️&nbsp;&nbsp;__Note:__ Please be aware that Carthage integration is not yet supported for SDK 4.3.1, but will be available for upcoming releases.  

Jumio supports Carthage as dependency management tool for easy integration of the SDK.

Adapt you Cartfile and add the JumioMobileSDK dependency. Check the following example how a Cartfile could look like:

```
binary "https://raw.githubusercontent.com/Jumio/mobile-sdk-ios/master/Carthage/JumioMobileSDK.json" == 3.9.4
```

Update you Carthage dependencies via Terminal:
```
carthage update
```

### Manually
Download our frameworks manually via [ios-jumio-mobile-sdk-4.3.1.zip](https://repo.mobile.jumio.ai/com/jumio/ios/jumio-mobile-sdk/4.3.1/ios-jumio-mobile-sdk-4.3.1.zip).

__Using iProov (manually):__
* iProov.xcframework
* Starscream.framework (iProov dependency)
* SocketIO.framework (iProov dependency)

ℹ️&nbsp;&nbsp;__Note:__ Our sample project on GitHub contains the sample implementation without our frameworks. The project file contains a “Run Script Phase” which downloads our frameworks automatically during build time. In case your application uses ZoOm as a liveness vendor, please contact [Jumio support](https://support.jumio.com) or your account manager directly.

The Jumio Mobile SDK consists of several dynamic frameworks. Depending on which product you use, you'll have to add the right frameworks to your project.

Please see [Strip unused frameworks](docs/integration_faq.md#strip-unused-frameworks) for more information.

The framework binaries are available with support for device and simulator architecture. Make sure to remove the simulator architecture from our frameworks for app submissions to the AppStore. If this step is not performed, your submission will be rejected by Apple. Add the following code snippet as run script build phase to your app project and ensure that it is executed after the frameworks are embedded. Please see the required setup in our sample project.

ℹ️&nbsp;&nbsp;__Note:__ The simulator architecture is automatically removed if using Cocoapods via "[CP] Embed Pods Frameworks" build phase.

```shell
if [[ "$CONFIGURATION" == "Release" ]]; then
  $PROJECT_DIR/remove-simulator-architecture.sh
fi
```
Code snippet source: https://stackoverflow.com/questions/30547283/submit-to-app-store-issues-unsupported-architecture-x86

Add the following linker flags to your Xcode Build Settings:  
ℹ️&nbsp;&nbsp;__Note:__ Added automatically if using CocoaPods.
- "-lc++"
- "-ObjC" (recommended) or -all_load

Make sure that the following Xcode build settings in your app are set accordingly:

| Setting | Value |
| :--- | :---: |
| Link Frameworks Automatically | YES |

## Initialization
Your OAuth2 credentials are constructed using your previous API token as the Client ID and your previous API secret as the Client secret. You can view and manage your Client ID and secret in the Customer Portal under:
* __Settings > API credentials > OAuth2 Clients__

Client ID and Client secret are used to generate an OAuth2 access token. OAuth2 has to be activated for your account. Contact your Jumio Account Manager for activation. Send a workflow request using the acquired OAuth2 access token to receive the SDK token necessary to initialize the Jumio SDK. For more details, please refer to [Authentication and Encryption](../README.md#authentication-and-encryption).

```
sdk = Jumio.SDK()
sdk.token = "YOUR_SDK_TOKEN"
sdk.dataCenter = jumioDataCenter
```

Make sure that your SDK token is correct. If it isn't, an exception will be thrown. Then provide a reference to identify the scans in your reports (max. 100 characters or `null`). Data center is set to `JumioDataCenter.US` by default. If your customer account is in the EU data center, use `JumioDataCenter.EU` instead. Alternatively, use `JumioDataCenter.SG` for Singapore.

⚠️&nbsp;&nbsp;__Note:__ We strongly recommend storing all credentials outside of your app! We suggest loading them during runtime from your server-side implementation.

Make sure initialization and presentation are timely within one minute. On iPads, the presentation style `UIModalPresentationFormSheet` is default and mandatory.
```
self.present(netverifyVC, animated: true, completion: nil)
```

## Configuration
Every Jumio SDK instance is initialized using a specific [`sdk.token`][token]. This token contains information about the workflow, credentials, transaction identifiers and other parameters. Configuration of this token allows you to provide your own internal tracking information for the user and their transaction, specify what user information is captured and by which method, as well as preset options to enhance the user journey. Values configured within the [`sdk.token`][token] during your API request will override any corresponding settings configured in the Customer Portal.

### Workflow Selection
Use ID verification callback to receive a verification status and verified data positions (see [API v3 Callback section](https://jumio.github.io/kyx/integration-guide.html#callback)). Make sure that your customer account is enabled to use this feature. A callback URL can be specified for individual transactions (for URL constraints see chapter [Callback URL](https://jumio.github.io/kyx/integration-guide.html#jumio-callback-ip-addresses)). This setting overrides any callback URL you have set in the Jumio Customer Portal. Your callback URL must not contain sensitive data like PII (Personally Identifiable Information) or account login. Set your callback URL using the `callbackUrl` parameter.

Use the correct [workflow definition key](https://jumio.github.io/kyx/integration-guide.html#workflow-definition-keys) in order to request a specific workflow. Set your key using the `workflowDefinition.key` parameter. For example: Use workflow [2 "ID Verification"](https://github.com/Jumio/implementation-guides/blob/master/api-guide/workflow_descriptions.md#workflow-2-id-verification) to verify an ID document and extract data from that document. Use [workflow 3 "ID and Identity Verification"](https://github.com/Jumio/implementation-guides/blob/master/api-guide/workflow_descriptions.md#workflow-3-id-and-identity-verification) to verify a photo ID document and extract data from that document, as well as compare the user's face with the photo on the ID and perform a liveness check to ensure the person is physically present.

```
'{
  "customerInternalReference": "CUSTOMER_REFERENCE",
  "workflowDefinition": {
    "key": X,
  },
  "callbackUrl": "YOUR_CALLBACK_URL"
}'
```

For more details, please refer to our [Workflow Description Guide](https://support.jumio.com/hc/en-us/articles/4408958923803-KYX-Workflows-User-Guide).

Identity Verification has to be activated for your account. If you use Identity Verification, make sure the necessary frameworks are linked to your app project:
* `iProov.framework`
* `Starscream.framework` (iProov dependency)
* `SocketIO.framework` (iProov dependency)

ℹ️&nbsp;&nbsp;__Note:__ Identity Verification requires portrait orientation in your app.

### Transaction Identifiers
There are several options in order to uniquely identify specific transactions. `customerInternalReference` allows you to specify your own unique identifier for a certain scan (max. 100 characters). Use `reportingCriteria`, to identify the scan in your reports (max. 100 characters). You can also set a unique identifier for each user using `userReference` (max. 100 characters).

For more details, please refer to our [API Guide](https://jumio.github.io/kyx/integration-guide.html#request-body).

```
'{
  "customerInternalReference": "CUSTOMER_REFERENCE",
  "workflowDefinition": {
    "key": X,
  },
  "reportingCriteria": "YOUR_REPORTING_CRITERIA",
  "userReference": "YOUR_USER_REFERENCE"
}'
```

⚠️&nbsp;&nbsp;__Note:__ Transaction identifiers must not contain sensitive data like PII (Personally Identifiable Information) or account login.

### Preselection
You can specify issuing country using [ISO 3166-1 alpha-3](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-3) country codes, as well as ID types to skip selection during the scanning process. In the example down below, Austria ("AUT") and the USA ("USA") have been preselected. PASSPORT and DRIVER_LICENSE have been chosen as preselected document types. If all parameters are preselected and valid and there is only one given combination (one country and one document type), the document selection screen in the SDK can be skipped entirely.

For more details, please refer to our [API Guide](https://jumio.github.io/kyx/integration-guide.html#request-body).

```
'{
  "customerInternalReference": "CUSTOMER_REFERENCE",
  "workflowDefinition": {
    "key": X,
    "credentials": [
      {
        "category": "ID",
        "type": {
          "values": ["DRIVING_LICENSE", "PASSPORT"]
        },
        "country": {
          "values": ["AUT", "USA"]
        }
      }
    ]
  }
}'
```

### Camera Handling
Use [`cameraFacing`][cameraFacing] attribute of [`Jumio.Scan.View`][jumioScanView] to configure the default camera and set it to `front` or `back`.
```
scanView.cameraFacing = .front
```
Use boolean [`hasFlash`][hasFlash] of [`Jumio.Scan.View`][jumioScanView] to see if flash is available for the current device camera. Use boolean [`flash`][flash] to toggle the camera flash.

## Customization

You can customize Jumio SDK UI. By using [`Jumio.Theme`][jumioTheme] class you can create your own theme and set it to your Jumio instance. You can use ['our sample app'](../sample/SampleApp/DefaultUI+Customization.swift) as guide to create your theme.

### Dark Mode
[`Jumio.Theme`][jumioTheme] attributes can also be customized for dark mode. For each [`Jumio.Theme.Value`][jumioThemeValue] you can initiate with either only one color or with `light and dark`. If `light and dark` colors have been specified, they will be applied to the modes respectively.
Dark mode will be applied when darkmode is enabled in system settings.

## SDK Workflow
Implement the delegate methods of the [`DefaultUIDelegate`]() protocol to be notified of successful initialization, successful scans, and errors. Dismiss the [`Jumio.ViewController`][jumioViewController] instance in your app in case of success or error.

### Initialization
When this method is fired, the SDK has finished initialization and loading tasks, and is ready to use. The error object is only set when an error has occurred (e.g. wrong credentials are set or a network error occurred).
```
sdk.startDefaultUI()
```

### Success
Upon success, the extracted document data is returned within a [`Jumio.Result`][jumioResult] object that includes `workflowExecutionId` and `accountId`. The parameter [`isSuccess`][isSuccess] will be `true`.
```
func jumio(sdk: Jumio.SDK, finished result: Jumio.Result) {
        delegate?.defaultUIDidFinish(with: result)
}
```

### Error
A workflow will result in an error when the user presses the cancel button during the workflow or in an error situation. [`Jumio.Result`][jumioResult] returns `workflowExecutionId` and `accountId`. It will also return a [`Jumio.Error`][jumioError] object, which contains an error code and error message. The parameter [`isSuccess`][isSuccess] will be `false`.
```
func jumio(sdk: Jumio.SDK, finished result: Jumio.Result) {
        delegate?.defaultUIDidFinish(with: result)
}
```

### Retrieving information
The following tables give information on the specification of all data parameters and errors:
* [`Jumio.IDResult`][jumioIDResult]
* [`Jumio.FaceResult`][jumioFaceResult]
* [`Jumio.RejectReason`][jumioRejectReason]
* [`Jumio.Error`][jumioError]

#### Class ___Jumio.IDResult___
| Parameter          | Type  	    | Max. length  | Description      |
|:-------------------|:-----------|:-------------|:-----------------|
| issuingCountry     | String     |	3            | Country of issue as [ISO 3166-1 alpha-3](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-3) country code |
| idType             | String     |              | PASSPORT, DRIVER_LICENSE, IDENTITY_CARD or VISA as provided or selected |
| firstName          | String     |	100	         | First name of the customer |
| lastName           | String     |	100	         | Last name of the customer |
| dateOfBirth        | String     |		           | Date of birth |
| issuingDate        | String     |	             | Date of issue |
| expiryDate         | String     |	             | Date of expiry |
| documentNumber     | String     |	100	         | Identification number of the document |
| personalNumber     | String     |	14           | Personal number of the document |
| gender             | String     |		           | Gender M, F or X |
| nationality        | String     |              | Nationality of the customer |
| placeOfBirth       | String     |	255	         | Place of birth	|
| country            | String     |              | Country of residence |
| address            | String     |	64	         | Street name of residence |
| city               | String     |	64	         | City of residence |
| subdivision        | String     |	3            | Last three characters of [ISO 3166-2:US](https://en.wikipedia.org/wiki/ISO_3166-2:US) or [ISO 3166-2:CA](https://en.wikipedia.org/wiki/ISO_3166-2:CA) subdivision code	|
| postalCode         | String     |	15           | Postal code of residence |
| mrzLine1           | String     |	50           | MRZ line 1	|
| mrzLine2           | String     | 50           | MRZ line 2	|
| mrzLine3           | String     |	50           | MRZ line 3	|
| rawBarcodeData     | String     |	50           | Extracted barcode data	|
| extractionMethod   | Jumio.Scan.Mode  |          | Extraction method used during scanning (linefinder, manual, faceIProov, faceManual, barcode, mrz, nfc, deviceRisk) |
| imageData          | Jumio.ImageData |          | Wrapper class for accessing image data of all credential parts from an ID verification session. This feature has to be enabled by your account manager. |

#### Class ___Jumio.FaceResult___
|Parameter  |Type 	  | Max. length | Description      |
|:----------|:--------|:------------|:-----------------|
| passed    |	Boolean |	          	|
| extractionMethod | Jumio.Scan.Mode  | | Extraction method used during scanning (faceManual, faceIProov) |
| imageData | Jumio.ImageData | | Wrapper class for accessing image data of all credential parts from an ID verification session. This feature has to be enabled by your account manager. |

#### Class ___Jumio.RejectReason___
List of all possible reject reasons returned if Instant Feedback is used:   

| Code          | Message  | Description      | Check enabled server-side (2022-05-12) |
|:--------------|:---------|:-----------------|:--------------:|
| 102  | BLACK_WHITE_COPY | Document appears to be a black and white photocopy | x |
| 103  | COLOR_PHOTOCOPY  | Document appears to be a colored photocopy | |
| 104  | DIGITAL_COPY     | Document appears to be a digital copy | x |
| 200  | NOT_READABLE     | Document is not readable | |
| 201  | NO_DOC           | No document could be detected | x |
| 206  | MISSING_BACK     | Backside of the document is missing | x |
| 214  | MISSING_FRONT    | Frontside of the document is missing | x |
| 2001 | BLURRY           | Document image is unusable because it is blurry | x |
| 2003 | MISSING_PART_DOC | Part of the document is missing | x |
| 2005 | DAMAGED_DOCUMENT | Document appears to be damaged | |
| 2004 | HIDDEN_PART_DOC  | Part of the document is hidden | |
| 2006 | GLARE            | Document image is unusable because of glare | x |

#### Error Codes
List of all **_error codes_** that are available via the `code` and `message` property of the [`Jumio.Error`][jumioError] object. The first letter (A-Z) represents the error case. The remaining characters are represented by numbers that contain information helping us understand the problem situation ([x][yyyy]).

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
| N00000 | Scanning not available at this time, please contact the app vendor | Required images are missing to finalize the acquisition |
| Y00000 | The barcode of your document didn't contain your address, turn your document and scan the front. | __Only Custom UI:__ Scanned Barcode (e.g. US Driver License) does not contain address information. Show hint and/or call `retryAfterError` |
| Z00000 | You recently scanned the front of your document. Please flip your document and scan the back. | __Only Custom UI:__ Backside of the document was scanned but most likely the frontside of the document was detected. Show hint and/or call `retryAfterError` |

⚠️&nbsp;&nbsp;__Note:__ Please always include the whole error code when filing an error related issue to our support team.

## Custom UI
ID Verification can also be implemented as a __custom scan view.__ This means that only the scan view controllers (including the scan overlays) are provided by the SDK.
The handling of the lifecycle, document selection, readability confirmation, error handling, and all other steps necessary to complete a scan have to be handled by the client application that implements the SDK.

The following sequence diagram outlines components, callbacks and functions for a basic ID Verification workflow:

![Custom UI Happy Path Diagram](images/happy_paths/custom_ui_happy_path_diagram.png)

Custom UI enables you to create and use a custom scan view with a plain scanning user interface. In order to do that, initialize the SDK instance by setting [`sdk.token`][token] and [`sdk.dataCenter`][dataCenter]. Specify a `delegate` instance which creates a [`Jumio.Controller`][jumioController].

⚠️&nbsp;&nbsp;__Note:__ Instead of the `delegate` property, `customUIDelegate` has to be set in the configuration object.

```
sdk = Jumio.SDK()
sdk?.token = "YOUR_SDK_TOKEN"
sdk?.dataCenter = jumioDataCenter
```

* [`JumioDataCenter`][dataCenter] values: `US`, `EU`, `SG`

Create a [`Jumio.Controller`][jumioController] instance and start the SDK by passing it to the controller:

```
var controller = Jumio.Controller?
controller = sdk?.start(sdk: sdk)
```

### Controller Handling
Once the controller is initialized, the following delegate methods will be available to handle [`Jumio.Controller`][jumioController]:

```
func jumio(controller: Jumio.Controller, didInitializeWith credentialInformations: [Jumio.Credential.Info], policyUrl: String?)

// result handling
func jumio(controller: Jumio.Controller, finished result: Jumio.Result)
func jumio(controller: Jumio.Controller, error: Jumio.Error)
func jumio(controller: Jumio.Controller, logicalError: Jumio.LogicalError)
```

If a user’s consent is required, the parameter `policyUrl` will provide a valid URL that will redirect the user to Jumio’s consent details. User can open and continue to this link if they choose to do so. If the user consents to the Jumio policy, [`controllerHandling?.userConsented()`][userConsented] is required to be called internally before any credential can be initialized and the user journey can continue. If no consent is required, the parameter `policyUrl` will be null.

⚠️&nbsp;&nbsp;__Note:__ Please be aware that in cases where `policyUrl` is not null, the user is __legally required__ to __actually consent__ to Jumio's policy. Do not accept automatically without showing the user any terms.

### Credential Handling
[`Jumio.Credential`][jumioCredential] will contain all necessary information about the scanning process. For ID verification you will receive an [`IDCredential`][jumioIDCredential], for Identity Verification a [`FaceCredential`][jumioFaceCredential], and so on. Initialize the credential and check if it is already preconfigured. If this is the case, the parameter [`isConfigured`][isConfigured] will be `true` and the credential can be started right away.

 ```
var currentCredential: Jumio.Credential?
currentCredential = controller?.start(credentialInfo: currentCredentialInfo)

if currentCredential?.isConfigured {
    scanSides = currentCredential?.scanSides
    // start next scan part
}
```

If the credential is not yet configured, configuration needs to be set before scanning can be initialized for available countries. In case of ID verification, all available countries for a specific [`IDCredential`][jumioIDCredential] are returned in [`countries`][countries] parameter of the individual credential. Use [`isSupportedConfiguration()`][isSupportedConfiguration] function to check if a certain configuration (e.g. a specific combination of country and documents) is supported for a certain ID credential. Use [`setConfiguration()`][setConfiguration] to set a valid country / document combination:

```
currentCredential.isSupportedConfiguration(country: country, document: document) else { return }
currentCredential.setConfiguration(country: country, document: document)
```

#### Jumio ID Credential
In case of [`Jumio.IDCredential`][jumioIDCredential], query the available country and document combinations by checking the countries map provided by the credential. After that, specify country and document details by setting the credential configuration to receive all relevant scan parts for your chosen document.

Set a valid country / document combination from that list:
```
guard let idCredential = credential as? Jumio.IDCredential,
    idCredential.setConfiguration(country: country, document: document)
```

* [`Jumio.Credential.Category`][credentialCategory] values = `id`, `face`, `document`

* [`Jumio.Document`][jumioDocument] values: `Jumio.DocumentType`, `Jumio.DocumentVariant`

* [`Jumio.DocumentType`][jumioDocumentType] values: `passport`, `visa`, `drivingLicense`, `identityCard`

* [`Jumio.DocumentVariant`][jumioDocumentVariant] values: `paper`, `plastic`

Retrieve the first credential part of the credential to start the scanning process by calling:
```
var credentialParts: [Jumio.Credential.Part]?
credentialParts = currentCredential?parts
```

Check if current [`Credential.Part`][jumioCredentialPart] is the first one:
```
var index = credentialParts?.firstIndex { $0 == previousCredentialPart } ?? 0
index += previousCredentialPart != nil ? 1 : 0
guard credentialParts?.count ?? 0 > index,
              let credentialPart = credentialParts?[index] else { return }
```

#### Jumio Face Credential
In case of [`Jumio.FaceCredential`][jumioFaceCredential], depending of the configuration the SDK uses the Certified Liveness technology from iProov to determine liveness or the manual face detection. The mode can be detected by checking the [`Jumio.Scan.Mode`][jumioScanMode] of the [`Jumio.Scan.Part`][jumioScanPart]. Make sure to also implement `faceManual` as a fallback, in case `faceIProov` is not available.

Retrieve the credential part of the credential to start the scanning process by calling:
```
var credentialPart = [Jumio.Credential.Part]?
var scanPart = credential?.initScanPart(credentialPart, scanPartDelegate: self)
```

#### Jumio Document Credential
In case of [`Jumio.DocumentCredential`][jumioDocumentCredential], there is the option to either acquire the image using the camera or selecting a file from the device. Call `setConfiguration` with a [`Jumio.Acquire.Mode`][acquireMode] to select the preferred mode as described in the code documentation.

* [`Jumio.Acquire.Mode`][acquireMode] values: `camera`, `file`

```
func select(acquireMode: Jumio.Acquire.Mode?) {
        guard let documentCredential = credential as? Jumio.DocumentCredential,
              let acquireMode = acquireMode,
              documentCredential.isSupportedConfiguration(acquireMode: acquireMode) else {
            delegate?.configurationNotSupported()
            return
        }
        documentCredential.setConfiguration(acquireMode: acquireMode)
        delegate?.loaded(scanSides: createViewModels(from: documentCredential.parts))
    }
```
Retrieve the credential part of the credential to start the scanning process by calling:
```
func initScanPart(with credentialPart: Jumio.Credential.Part) {
        guard let scanPart = createScanPart(credentialPart: credentialPart) else { return }
        activeCredentialPart = credentialPart
        self.scanPart = scanPart
        isScanPartFinishable = false
}

```
If [`Jumio.Acquire.Mode`][acquireMode] `file` is used, the [`JumioFileAttacher`][jumioFileAttacher] needs to be utilized to add a File or FileDescriptor for the selected [`JumioScanPart`][jumioScanPart].
```
let attacher = Jumio.FileAttacher()
attacher.attach(scanPart: scanPart)
attacher.set(url: "path/to/your/file")

```

### ScanPart Handling
The following sequence diagram outlines an overview of ScanPart handling details:
![ScanPart Happy Path Diagram](images/happy_paths/scanpart_happy_path_diagram.png)

Start the scanning process by initializing the scan part. Provide a `Jumio.Credential.Part` from the list below:

* [`Jumio.Scan.Mode`][jumioScanMode] values: `manual`, `faceManual`, `lineFinder`, `barcode`, `mrz`, `faceIProov`, `deviceRisk`

* [`Jumio.Credential.Part`][jumioCredentialPart] values: `front`, `back`, `face`, `nfc`, `DeviceRisk`

When the scanning is done, the parameter [`Jumio.Scan.Step.canFinish`][canFinish] will be received and the scan part can be finished by calling `currentScanPart?.finish()`.

To see if the finished credential part was the last one of the credential, check `currentCredentialPart == currentCredential?.credentialPart?.last()` Check if the credential is complete by calling [`currentCredential?.isComplete`][isComplete] and finish the current credential by calling [`currentCredential?.finish()`][credentialFinish].

Continue that procedure until all necessary credentials (e.g. `id`, `face`, `document`) are finished. Check if the last credential is finished with:

```
var index = credentialParts?.firstIndex { $0 == previousCredentialPart } ?? 0
index += previousCredentialPart != nil ? 1 : 0
guard credentialParts?.count ?? 0 > index,
              let credentialPart = credentialParts?[index] else { return }
```

Then call [`controller?.finish()`][controllerFinish] to end the user journey.

During the scanning process, use the `scanPart` delegate method to check on the scanning progress. The scan step [`canFinish`][canFinish] indicates that the scanning process for this part is done.

[`Jumio.Scan.Step`][jumioScanStep] covers lifecycle events which require action from the customer to continue the process.

* [`Jumio.Scan.Step`][jumioScanStep] values: `prepare`, `started`, `scanView`, `imageTaken`, `processing`, `confirmationView`, `retry`, `canFinish`, `rejectView`, `addonScanPart`

`prepare` is only sent if a scan part requires upfront preparation and the customer should be notified (e.g. by displaying a loading screen). [`started`][started] is always sent when a scan part is started. If a loading view was triggered before, it can now be dismissed,

[`imageTaken`][imageTaken] is triggered as soon as the image is taken. The camera preview is stopped during that step.

When background processing is executed, [`Jumio.Scan.Step.processing`][processing] is triggered.

When a confirmation view should be displayed, depending on the outcome either [`Jumio.Scan.Step.confirmationView`][confirmationView] or [`Jumio.Scan.Step.rejectView`][rejectView] is displayed. To display the ScanPart in the confirmation or reject view, simply attach the views once the steps are triggered:

```
func onScanStep(_ step: Internal.Scan.Step, data: Any?) {
  switch step {
  case .confirmationView:
    if let scanPart = self.scanPart {
      confirmationView?.attach(scanPart: scanPart)
      delegate?.showConfirmationView()
    }
  case .rejectView:
    if let scanPart = self.scanPart {
      rejectView?.attach(scanPart: scanPart)
      delegate?.showRejectView()
    }
  }
}
```

The scan part can be confirmed by calling `scanPart?.confirm()` or the scan can be taken again: Either by calling `scanPart?.retake()` in case the scan attempt was successful, or by calling `scanPart?.rejectRetake()` in case the scan attempt was rejected. (Bad lighting conditions or glare, image was blurry, etc. ...)

The retry scan step returns a data object of type [`Jumio.Retry.Reason`][jumioRetryReason]. On [`retry`][retry], a retry has to be triggered on the credential.
```
func onScanStep(_ step: Internal.Scan.Step, data: Any?) {
  case .retry:
    activeRetryReason = data as? Jumio.Retry.Reason
    var code = activeRetryReason?.code
    var message = activeRetryReason?.message
}
```

As soon as the scan part has been confirmed and all processing has been completed [`canFinish`][canFinish] is triggered. `scanPart.finish()` can now be called. During the finish routine the SDK checks if there is an add-on functionality for this part available, e.g. possible NFC scanning after an MRZ scan part. If an add-on is available, the `addonScanPart` step is triggered.

[`Jumio.Scan.Update`][jumioScanUpdate] covers scan information that is relevant and might need to be displayed during the scanning process.

* [`Jumio.Scan.Update`][jumioScanUpdate] values: `fallback`, `legalHint`

### Result and Error Handling
The method `jumio(controller: Jumio.Controller, finished result: Jumio.Result)` has to be implemented to handle data after a successful scan, which will return [`Jumio.Result`][jumioResult].

```
func jumio(controller: Jumio.Controller, finished result: Jumio.Result) {
        delegate?.controller(finished: result)
        // handle success case
    }
```

⚠️&nbsp;&nbsp;__Note:__ We recommend to hide any sensitive data, which you display to the user, when the app goes to the background. This includes the results you receive from us.

The delegate method `(controller: Jumio.Controller, error: Jumio.Error)` has to be implemented to handle data after an unsuccessful scan, which will return [`Jumio.Error`][jumioError]. Check the parameter [`error.isRetryable`][isRetryable] to see if the failed scan attempt can be retried. If an error is not retryable, the only possibility is to cancel the controller. This will result in a finished call with a [`Jumio.Result`][jumioResult] instance containing this error.

```
func jumio(controller: Jumio.Controller, error: Jumio.Error) {
    guard controller === self.controller else { return }
    guard error.isRetryable else {
        controller.cancel()
        return
    }
    ...
    // handle error case
}
```

The delegate method `(controller: Jumio.Controller, error: Jumio.LogicalError)` has to be implemented to handle data after an unsuccessful scan. [`Jumio.LogicalError`][jumioLogicalError] case occurs whenever some kind of logical error occurs. (For example: `.deadCredential: Credential` is returned when a credential has already been finished or canceled and can’t execute any action anymore. Controller has to be finished or canceled before a new one can be initialized.

* [`Jumio.LogicalError`][jumioLogicalError] values: `dependencyWrongVersion`, `notYetImplemented`, `deadController`, `errorNotRetryable`, `needToConsentFirst`, `controllerNotCompleted`, `isBeingFinished`, `multipleCredentials`, `unknownCredential`, `deadCredential`, `credentialNotCompleted`, `multipleScanParts`, `unknownScanPart`, `scanPartNotCompleted`, `deadScanPart`, `noFallbackAvailable`, `takePictureNotAllowed`

```
func jumio(controller: Jumio.Controller, logicalError: Jumio.LogicalError) {
        var logicalErrorMessage: String = ""
        switch logicalError {
        case .dependencyWrongVersion:
            logicalErrorMessage = "3rd party dependency have wrong version"
        case
          ...
          // handle error cases
        @unknown default:
            logicalErrorMessage = "unknown logical error reported"
        }
        delegate?.display(logicalErrorMessage: logicalErrorMessage)
    }
```

#### Instant Feedback
The use of Instant Feedback provides immediate end user feedback by performing a usability check on any image the user took and prompting them to provide a new image immediately if this image is not usable, for example because it is too blurry. Please refer to the [JumioRejectReason table](#class-jumiorejectreason) for a list of all reject possibilities.

# Data Analysis
You can enable or disable data analysis by calling `sdk.giveDataDogConsent(enabled: Bool)`. By default, data analysis is enabled.

# Security
All SDK related traffic is sent over HTTPS using TLS and public key pinning. Additionally, the information itself within the transmission is also encrypted utilizing __Application Layer Encryption__ (ALE). ALE is a Jumio custom-designed security protocol that utilizes RSA-OAEP and AES-256 to ensure that the data cannot be read or manipulated even if the traffic was captured.

# Support

## Licenses
The software contains third-party open source software. For more information, see [licenses](#licenses).

This software is based in part on the work of the Independent JPEG Group.

## Contact
If you have any questions regarding our implementation guide please contact Jumio Customer Service at support@jumio.com. The [Jumio online helpdesk](https://support.jumio.com) contains a wealth of information regarding our services including demo videos, product descriptions, FAQs, and other resources that can help to get you started with Jumio.

## Copyright
&copy; Jumio Corporation, 395 Page Mill Road, Suite 150, Palo Alto, CA 94306

The source code and software available on this website (“Software”) is provided by Jumio Corp. or its affiliated group companies (“Jumio”) "as is” and any express or implied warranties, including, but not limited to, the implied warranties of merchantability and fitness for a particular purpose are disclaimed. In no event shall Jumio be liable for any direct, indirect, incidental, special, exemplary, or consequential damages (including but not limited to procurement of substitute goods or services, loss of use, data, profits, or business interruption) however caused and on any theory of liability, whether in contract, strict liability, or tort (including negligence or otherwise) arising in any way out of the use of this Software, even if advised of the possibility of such damage.

In any case, your use of this Software is subject to the terms and conditions that apply to your contractual relationship with Jumio. As regards Jumio’s privacy practices, please see our privacy notice available here: [Privacy Policy](https://www.jumio.com/legal-information/privacy-policy/).

[token]: https://jumio.github.io/mobile-sdk-ios/Jumio/Structs/Jumio/SDK.html#/s:5JumioAAV3SDKC5tokenSSvp
[dataCenter]: https://jumio.github.io/mobile-sdk-ios/Jumio/Structs/Jumio/DataCenter.html
[sdkVersion]: https://jumio.github.io/mobile-sdk-ios/Jumio/Structs/Jumio/SDK.html#/s:5JumioAAV3SDKC17defaultUIDelegateAA0a7DefaultD0_pSgvp
[isJailbroken]: https://jumio.github.io/mobile-sdk-ios/Jumio/Structs/Jumio/SDK.html#/s:5JumioAAV3SDKC12isJailbrokenSbvpZ
[defaultUIDelegate]: https://jumio.github.io/mobile-sdk-ios/Jumio/Structs/Jumio/SDK.html#/s:5JumioAAV3SDKC17defaultUIDelegateAA0a7DefaultD0_pSgvp
[cameraFacing]: https://jumio.github.io/mobile-sdk-ios/Jumio/Classes/JumioScanView.html#/s:5Jumio0A8ScanViewC12cameraFacingA2AV06CameraE0Ovp
[hasFlash]: https://jumio.github.io/mobile-sdk-ios/Jumio/Classes/JumioScanView.html#/s:5Jumio0A8ScanViewC8hasFlashSbvp
[flash]: https://jumio.github.io/mobile-sdk-ios/Jumio/Classes/JumioScanView.html#/s:5Jumio0A8ScanViewC5flashSbvp
[isSuccess]: https://jumio.github.io/mobile-sdk-ios/Jumio/Structs/Jumio/Result.html#/s:5JumioAAV6ResultC9isSuccessSbvp
[userConsented]: https://jumio.github.io/mobile-sdk-ios/Jumio/Structs/Jumio/Controller.html#/s:5JumioAAV10ControllerC13userConsentedyyF
[isConfigured]: https://jumio.github.io/mobile-sdk-ios/Jumio/Structs/Jumio/Credential.html#/s:5JumioAAV10CredentialC12isConfiguredSbvp
[countries]: https://jumio.github.io/mobile-sdk-ios/Jumio/Structs/Jumio/IDCredential.html#/s:5JumioAAV12IDCredentialC9countriesSDySSSayAB8DocumentVGGvp
[isSupportedConfiguration]: https://jumio.github.io/mobile-sdk-ios/Jumio/Structs/Jumio/IDCredential.html#/s:5JumioAAV12IDCredentialC24isSupportedConfiguration7country8documentSbSS_AB8DocumentVtF
[setConfiguration]: https://jumio.github.io/mobile-sdk-ios/Jumio/Structs/Jumio/IDCredential.html#/s:5JumioAAV12IDCredentialC16setConfiguration7country8documentySS_AB8DocumentVtF
[credentialCategory]: https://jumio.github.io/mobile-sdk-ios/Jumio/Structs/Jumio/Credential.html#/s:5JumioAAV10CredentialC8CategoryO
[started]: https://jumio.github.io/mobile-sdk-ios/Jumio/Structs/Jumio/Scan/Step.html#/s:5JumioAAV4ScanV4StepO7startedyA2FmF
[imageTaken]: https://jumio.github.io/mobile-sdk-ios/Jumio/Structs/Jumio/Scan/Step.html#/s:5JumioAAV4ScanV4StepO10imageTakenyA2FmF
[processing]: https://jumio.github.io/mobile-sdk-ios/Jumio/Structs/Jumio/Scan/Step.html#/s:5JumioAAV4ScanV4StepO10imageTakenyA2FmF
[confirmationView]: https://jumio.github.io/mobile-sdk-ios/Jumio/Structs/Jumio/Scan/Step.html#/s:5JumioAAV4ScanV4StepO16confirmationViewyA2FmF
[rejectView]: https://jumio.github.io/mobile-sdk-ios/Jumio/Structs/Jumio/Scan/Step.html#/s:5JumioAAV4ScanV4StepO10rejectViewyA2FmF
[canFinish]: https://jumio.github.io/mobile-sdk-ios/Jumio/Structs/Jumio/Scan/Step.html#/s:5JumioAAV4ScanV4StepO9canFinishyA2FmF
[isComplete]: https://jumio.github.io/mobile-sdk-ios/Jumio/Structs/Jumio/Credential.html#/s:5JumioAAV10CredentialC10isCompleteSbvp
[credentialFinish]: https://jumio.github.io/mobile-sdk-ios/Jumio/Structs/Jumio/Credential.html#/s:5JumioAAV10CredentialC6finishyyF
[controllerFinish]: https://jumio.github.io/mobile-sdk-ios/Jumio/Structs/Jumio/Controller.html#/s:5JumioAAV10ControllerC6finishyyF
[retry]: https://jumio.github.io/mobile-sdk-ios/Jumio/Structs/Jumio/Scan/Step.html#/s:5JumioAAV4ScanV4StepO5retryyA2FmF
[isRetryable]: https://jumio.github.io/mobile-sdk-ios/Jumio/Structs/Jumio/Error.html#/s:5JumioAAV5ErrorV11isRetryableSbvp

[jumioScanView]: https://jumio.github.io/mobile-sdk-ios/Jumio/Classes/JumioScanView.html
[jumioTheme]: https://jumio.github.io/mobile-sdk-ios/Jumio/Structs/Jumio/Theme.html
[jumioThemeValue]: https://jumio.github.io/mobile-sdk-ios/Jumio/Structs/Jumio/Theme.html#/s:5JumioAAV5ThemeV5ValueV
[jumioViewController]: https://jumio.github.io/mobile-sdk-ios/Jumio/Classes.html#/c:@M@Jumio@objc(cs)JumioViewController
[jumioResult]: https://jumio.github.io/mobile-sdk-ios/Jumio/Structs/Jumio/Result.html
[jumioIDResult]: https://jumio.github.io/mobile-sdk-ios/Jumio/Structs/Jumio/IDResult.html
[jumioFaceResult]: https://jumio.github.io/mobile-sdk-ios/Jumio/Structs/Jumio/FaceResult.html
[jumioRejectReason]: https://jumio.github.io/mobile-sdk-ios/Jumio/Structs/Jumio/RejectReason.html
[jumioRetryReason]: https://jumio.github.io/mobile-sdk-ios/Jumio/Structs/Jumio/Retry.html#/s:5JumioAAV5RetryV6ReasonC
[jumioError]: https://jumio.github.io/mobile-sdk-ios/Jumio/Structs/Jumio/Error.html
[jumioSetupError]: https://jumio.github.io/mobile-sdk-ios/Jumio/Structs/Jumio/SetupError.html
[jumioLogicalError]: https://jumio.github.io/mobile-sdk-ios/Jumio/Structs/Jumio/LogicalError.html
[jumioController]: https://jumio.github.io/mobile-sdk-ios/Jumio/Structs/Jumio/Controller.html
[jumioCredential]: https://jumio.github.io/mobile-sdk-ios/Jumio/Structs/Jumio/Credential.html
[jumioIDCredential]: https://jumio.github.io/mobile-sdk-ios/Jumio/Structs/Jumio/IDCredential.html
[jumioDocumentCredential]: https://jumio.github.io/mobile-sdk-ios/Jumio/Structs/Jumio/DocumentCredential.html
[jumioDataCredential]: https://jumio.github.io/mobile-sdk-ios/Jumio/Structs/Jumio/DataCredential.html
[jumioFaceCredential]: https://jumio.github.io/mobile-sdk-ios/Jumio/Structs/Jumio/FaceCredential.html
[jumioDocument]: https://jumio.github.io/mobile-sdk-ios/Jumio/Structs/Jumio/Document.html
[jumioDocumentType]: https://jumio.github.io/mobile-sdk-ios/Jumio/Structs/Jumio/Document.html#/s:5JumioAAV8DocumentV0B4TypeO
[jumioDocumentVariant]: https://jumio.github.io/mobile-sdk-ios/Jumio/Structs/Jumio/Document.html#/s:5JumioAAV8DocumentV0B7VariantO
[jumioScanStep]: https://jumio.github.io/mobile-sdk-ios/Jumio/Structs/Jumio/Scan/Step.html
[jumioScanUpdate]: https://jumio.github.io/mobile-sdk-ios/Jumio/Structs/Jumio/Scan/Update.html
[jumioScanMode]: https://jumio.github.io/mobile-sdk-ios/Jumio/Structs/Jumio/Scan/Mode.html
[jumioCredentialPart]: https://jumio.github.io/mobile-sdk-ios/Jumio/Structs/Jumio/Credential/Part.html
[jumioScanPart]: https://jumio.github.io/mobile-sdk-ios/Jumio/Structs/Jumio/Scan/Mode.html
