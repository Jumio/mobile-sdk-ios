![ID Verification](images/jumio_feature_graphic.jpg)

# Transition Guide for iOS SDK
This section covers all technical changes that should be considered when updating from previous versions, including, but not exclusively: API breaking changes or new functionality in the public API, major dependency changes, attribute changes, deprecation notices.

⚠️&nbsp;&nbsp;When updating your SDK version, __all__ changes/updates made in in the meantime have to be taken into account and applied if necessary.     
__Example:__ If you're updating from SDK version __3.7.2__ to __3.9.2__, the changes outlined in __3.8.0, 3.9.0__ and __3.9.1__ are __still relevant__.

## 4.11.0

#### SPM
  * Library `JumioLocalization` makes it possible to localize strings with Swift Package Manager.

#### Scan Updates
* Added `Jumio.Scan.Update.ExtractionState.tilt`
* Added `Jumio.Scan.Update.TiltState`
* Added additional time parameter (in seconds) for `Jumio.Scan.Update.ExtractionState.holdStill` update
* Added `Jumio.Scan.Update.nextPosition`

#### Scan Steps
* `Jumio.Scan.Step.imageTaken` is sent exactly once per scan.
  * Please use `Jumio.Scan.Update.nextPosition` to determine the position change for Jumio Liveness instead.

#### Logical Errors
* Deprecated `noDataCenterSet` error
* Added `tokenValidationFailed` error for starting SDK with empty token 
* Added `dataCenterValidationFailed` error for starting SDK without datacenter

#### Localization Keys
The following keys have been added:
* `jumio_id_scan_guide_photo_side_tilt`
* `jumio_id_scan_prompt_tilt_less`
* `jumio_id_scan_prompt_tilt_more`

#### Reject Reasons
* Added `401 unsupportedDocument` to `Jumio.RejectReason`.

## 4.10.0
* Added `Jumio.Scan.Update.flash(FlashState)`
* Added `Jumio.Scan.Update.FlashState`
* Changed customization options
  * Renamed `Jumio.Theme.bubble.circleItemForeground` to `Jumio.Theme.bubble.outline`
  * Renamed `Jumio.Theme.scanView.bubbleForeground` to `Jumio.Theme.scanView.tooltipForeground`
  * Renamed `Jumio.Theme.scanView.bubbleBackground` to `Jumio.Theme.scanView.tooltipBackground`
  * Removed `Jumio.Theme.bubble.circleItemBackground`
  * Removed `Jumio.Theme.searchBubble.backgroundSelected`
  * Removed `Jumio.Theme.scanOverlay.fill`
  * Removed `Jumio.Theme.scanOverlay.scanOverlayTransparent`

#### Localization Keys
The following keys have been added:
  * `jumio_id_scan_prompt_captured`

The following keys have been removed:
  * `jumio_id_scan_prompt_front_captured`
  * `jumio_id_scan_prompt_back_captured`
  
#### Localization
 * Added Serbian (Cyril) `sr-Cyrl`
 * Added Serbian (Latin) `sr-Latn`

## 4.9.1
* Fixed a crash on iOS 12 app startup.

## 4.9.0
* Minimum iOS version raised to 12.
* Removed `Jumio/DocFinder` dependency as the functionality was moved to Jumio core. Every dependency now contains DocFinder functionality.
* Removed `Jumio/DeviceRisk` dependency as the functionality was moved to Jumio API. Plase check out our [Integration guide](integration_guide.md#risk-signal-device-risk).
* Removed Default UI from Jumio core functionality
    * Added `Jumio/DefaultUI`
    * Check out the [Integration Guide](integration_guide.md)
* Added `idSubType` to `Jumio.IDResult`
* Added `Jumio/Preloader`, check out the [Integration Guide](integration_guide.md#preloading-models)
* New `Jumio.Retry.Reason.Face`
  * generic
  * tooMuchMovement
  * lightingTooBright
  * lightingTooDark
  * eyesClosed
  * obscuredFace
  * multipleFaces
  * sunglasses
* Changed customization options
  * Added `Jumio.Theme.face`
  * Added `Jumio.Theme.PrimaryButton.outline`
  * Added `Jumio.Theme.SecondaryButton.foregroundPressed`
  * Added `Jumio.Theme.SecondaryButton.foregroundDisabled`
  * Added `Jumio.Theme.SecondaryButton.outline`
  * Added `Jumio.Theme.SearchBubble.outline`
  * Added `Jumio.Theme.Loading.loadingAnimationGradient`
  * Added `Jumio.Theme.Loading.loadingAnimationErrorGradient`
  * Added `Jumio.Theme.Confirmation.imageBorder`
  * Renamed `Jumio.Theme.Bubble.selectionIconForeground` to `Jumio.Theme.selectionIconForeground`
  * Renamed `Jumio.Theme.SearchBubble.listItemSelected` to `Jumio.Theme.SearchBubble.backgroundSelected`

## 4.8.1
 * Removed `Starscream` dependency for `Jumio/IProov`.

## 4.8.0
#### Manual Integration
* Framework `JumioLiveness.xcframework` is now required when using `JumioIProov.xcframework`

#### Carthage Integration
* Framework `JumioLiveness.xcframework` is now required when using `JumioIProov.xcframework`

## 4.7.1
 * Removed `Starscream` dependency for `Jumio/IProov`.

## 4.7.0
#### Barcode
 * Removed `Jumio/Barcode` dependency as the functionality was moved to Jumio core. Every dependency now contains Barcode functionality.

#### MRZ
 * Removed `Jumio/MRZ` dependency. Please use `Jumio/Jumio` instead.

#### NFC
 * Removed `Jumio/NFC` dependency. Please use `Jumio/Jumio` instead.

#### Linefinder
* Removed `Jumio/LineFinder` dependency. Please use `Jumio/Slim` in combination with `Jumio/DocFinder` instead.

#### Changes to Public API
 * Deprecated `Jumio.Theme.IProov.animationForeground`
    * Added `Jumio.Theme.ScanHelp.faceAnimationForeground`
 * Deprecated `Jumio.Theme.IProov.animationBackground`
    * Added `Jumio.Theme.ScanHelp.faceAnimationBackground`
 * Deprecated `Jumio.Theme.PrimaryButton.text`
    * Added `Jumio.Theme.PrimaryButton.foreground`
 * Deprecated `Jumio.Theme.SecondaryButton.text`
    * Added `Jumio.Theme.SecondaryButton.foreground`
 * Added `Jumio.Theme.PrimaryButton.foregroundPressed`
 * Added `Jumio.Theme.PrimaryButton.foregroundDisabled`
 * Removed `Jumio.Scan.Mode.lineFinder`
 * Removed `Jumio.Scan.Mode.mrz`
 * Deprecated `Jumio.Scan.Update.legalHint`
 * Deprecated `Jumio.SDK.giveDataDogConsent(enabled: Bool)`
 * Deprecated `Jumio.IDResult.rawBarcodeData`
 
#### Localization Keys
The following keys have been added:
  * jumio_id_scan_guide_photo_side
  * jumio_id_scan_guide_back_side
  * jumio_id_scan_guide_photo_side_manually
  * jumio_id_scan_guide_back_side_manually

The following keys have been removed:
  * jumio_id_scan_guide_take_photo_front_idc
  * jumio_id_scan_guide_take_photo_back_idc
  * jumio_id_scan_guide_take_photo_passport
  * jumio_id_scan_guide_take_photo_front_dl
  * jumio_id_scan_guide_take_photo_back_dl
  * jumio_id_scan_guide_take_photo_front_pd
  * jumio_id_scan_guide_take_photo_back_pd

#### Localization
 * Replaced Portuguese `pt` with Portuguese (Portugal) `pt-PT`
 * Added Portugise (Brasil) `pt-BR`

#### SPM
  * Library `JumioDatadog` which can be used to integrate JumioDatadog.
  
#### Carthage
  * Added `JumioDatadog.json`.

#### Frameworks
  * Datadog dependency `DatadogSDK` is removed

## 4.6.2
 * Removed `Starscream` dependency for `Jumio/IProov`.

## 4.6.1
#### Cocoapods
 * `pod 'Jumio/DeviceRisk'` was removed from `pod 'Jumio/All'`.

## 4.6.0
#### Liveness
 * Added new library `JumioLiveness` to enhance the Liveness user experience/interface. Check out our [Integration Guide](integration_guide.md).
 * Removed liveness confirmation handling

#### Cocoapods
  * `pod 'Jumio/IProov'` replaces ~~`pod 'Jumio/Liveness'`~~ as new pod for using iProov liveness technology.
  * `pod 'Jumio/Liveness'` is now required to use the Jumio liveness solution.
  
#### SPM
  * Library `'JumioIProov'` replaces ~~`'JumioLiveness'`~~ as new library for our iProov liveness solution.
  * Library `'JumioLiveness'` is now required to use the Jumio liveness solution.
  
#### Carthage
  * Added `'JumioLiveness.json'` which is now required to use the Jumio liveness solution.
  
#### Changes to Public API
* Deprecated `Jumio.Theme.ScanView.shutter`:
    * Added `Jumio.Theme.ScanView.documentShutter`
    * Added `Jumio.Theme.ScanView.faceShutter`

## 4.5.0
#### Customization
* Option `Jumio.Theme.ScanView.animationBackground` has been removed.

#### Changes to Public API
* Error code format updated from `[A][x][yyyy]` to `[A][xx][yyyy]`
* Deprecated `Jumio.IDCredential.countries`:
    * Added `Jumio.IDCredential.supportedCountries`
    * Added `Jumio.IDCredential.physicalDocuments(for:)`
    * Added `Jumio.IDCredential.digitalDocuments(for:)`
* Added `Jumio.SDK.handleDeeplinkURL()`
* Added `Jumio.Document.Physical`
* Added `Jumio.Document.Digital`
* New `Jumio.Credential.Part`
  * digital
* New `Jumio.Scan.Step`
  * digitalIdentityView
  * thirdPartyVerification
* New `Jumio.Retry.Reason.DigitalIdentity`
  * unknown
  * expired
  * thirdPartyVerificationError
  * serviceError
* Changed `JumioScanView`
  * Changed `extraction` variable to get-only
  * Added `startExtraction()` function
  * Added `stopExtraction(hidePreview: Bool)` function
  
* Changed `JumioControllerDelegate`
  * Changed `jumio(controller: Jumio.Controller, didInitializeWith credentialInformations: [Jumio.Credential.Info], policyUrl: String?)` to `jumio(controller: Jumio.Controller, didInitializeWith credentialInformations: [Jumio.Credential.Info], consentItems: [Jumio.ConsentItem]?)`
  
* Changed `Jumio.Controller`
  * Changed `userConsented()` to be `userConsented(to consentItem: Jumio.ConsentItem, decision: Bool)`
  * Added `getUnconsentedItems() -> [Jumio.ConsentItem]?`
  
#### Localization Keys
The following keys have been added:
  * jumio_idtype_di
  * jumio_di_vendor_selection_title
  * jumio_di_retry_unknown
  * jumio_di_retry_third_party_verification_error
  * jumio_di_retry_service_error
  * jumio_di_back_to_document_selection
  
#### Cocoapods
* install hook for liveness is changed in the `podfile`:
```
post_install do |installer|
   installer.pods_project.targets.each do |target|
     if ['iProov', 'Starscream'].include? target.name
       target.build_configurations.each do |config|
           config.build_settings['BUILD_LIBRARY_FOR_DISTRIBUTION'] = 'YES'
       end
     end
    end
end
```

#### Frameworks
* iProov dependency `SwiftProtobuf` is removed

## 4.4.0
#### Changes to Public API
* New `Jumio.Credential.Part`
  * `multipart`: This is the new Autocapture scan part. Instead of having a single scan part for all parts of a document (front, back), there is now a single `multipart` scan part that combines the two. Within this scan part all needed parts of a document are captured at once.
* New `Jumio.Scan.Step`
  * `nextPart`: This scan step shows that the previous part has been captured and the next one can be started (e.g. frontside has been captured, now switch to the backside of the document). Contains the `Jumio.Credential.Part` as additional data. We suggest to actively guide the user to move to the next part, e.g. by showing an animation and by disabling the extraction during the animation.
* Updated `Jumio.Scan.Step.started`
  * Added `Jumio.Credential.Part` as additional data
* Changed confirmation and reject handling
  * Added `Jumio.Confirmation.Handler`
  * Added `Jumio.Reject.Handler`
  * Moved `attach`, `detach`, `retake` and `confirm` methods from `Jumio.Confirmation.View` to `Jumio.Confirmation.Handler`
  * Moved `attach`, `detach` and `retake` methods from `Jumio.Reject.View` to `Jumio.Reject.Handler`
  * As a result the confirmation views for front and/or back within multipart scans are obsolete and not existing anymore.
* New `Jumio.Retry.Reason.iProov`:
  * faceMisaligned
  * eyesClosed
  * faceTooFar
  * faceTooClose
  * sunglasses
  * obscuredFace
  * userTimeout
  * notSupported
* Updated `Jumio.Scan.Step.rejectView`:
  * The returned scan step data now contains a dictionary `[Jumio.Credential.Part: Jumio.RejectReason]` instead of a single `Jumio.RejectReason`.
* Removed `Jumio.Retry.Reason.iProov`:
  * ambiguousOutcome
  * lightingFlash
  * lightingBacklit
  * motionMouth
* New options in `Jumio.Theme.IProov`:
  * filterBackgroundColor
  * surroundColor
  * livenessAssuranceCompletedOvalStrokeColor
* Renamed options in `Jumio.Theme.IProov`:
  * lineColor to filterForegroundColor
  * headerTextColor to titleTextColor
  * floatingPromptRoundedCorners to promptRoundedCorners
  * genuinePresenceAssuranceReadyOverlayStrokeColor to genuinePresenceAssuranceReadyOvalStrokeColor
  * genuinePresenceAssuranceNotReadyOverlayStrokeColor to genuinePresenceAssuranceNotReadyOvalStrokeColor
  * livenessAssuranceOverlayStrokeColor to livenessAssuranceOvalStrokeColor
  * genuinePresenceAssuranceReadyFloatingPromptBackgroundColor to promptBackgroundColor
  * genuinePresenceAssuranceNotReadyFloatingPromptBackgroundColor to promptBackgroundColor
  * livenessAssuranceFloatingPromptBackgroundColor to promptBackgroundColor
* Removed options in `Jumio.Theme.IProov`:
  * headerBackgroundColor
  * footerBackgroundColor
  * livenessAssurancePrimaryTintColor
  * livenessAssuranceSecondaryTintColor
  * genuinePresenceAssuranceProgressBarColor
  * genuinePresenceAssuranceNotReadyTintColor
  * genuinePresenceAssuranceReadyTintColor
  * floatingPromptEnabled

#### Localization Keys
The following keys have been added:
  * IProov_PromptAlignFace
  * IProov_FailureEyesClosed
  * IProov_FailureFaceTooClose
  * IProov_FailureFaceTooFar
  * IProov_FailureMisalignedFace
  * IProov_FailureNotSupported
  * IProov_FailureObscuredFace
  * IProov_FailureSunglasses
  * IProov_FailureTooBright
  * IProov_FailureTooDark
  * IProov_FailureTooMuchMovement
  * IProov_FailureUnknown
  * IProov_FailureUserTimeout
  * IProov_AccessibilityPromptAlignFace
  * IProov_AccessibilityPromptScanning
The following keys have been renamed:
  * IProov_ErrorCameraPermissionDeniedMessageIos to IProov_ErrorCameraPermissionDeniedMessage
The following keys have been removed:
  * IProov_MessageFormat
  * IProov_PromptTapToBegin
  * IProov_PromptLivenessAlignFace
  * IProov_PromptLivenessNoTarget
  * IProov_PromptGenuinePresenceAlignFace
  * IProov_ProgressStreamingSlow
  * IProov_PromptGrantPermission
  * IProov_PromptGrantPermissionMessage
  * IProov_FailureAmbiguousOutcome
  * IProov_FailureLightingBacklit
  * IProov_FailureLightingFaceTooBright
  + IProov_FailureLightingFlashReflectionTooLow
  * IProov_FailureLightingTooDark
  * IProov_FailureMotionTooMuchMouthMovement
  * IProov_FailureMotionTooMuchMovement

#### Liveness
* We have seperated our liveness solution in `JumioIProov.xcframework`. You need to add this framework beside `Jumio.xcframework` to your project. 

#### Cocoapods
* The following pods have been removed. Instead `Jumio/Liveness` should be added in your pod file.
  * `pod 'Jumio/SlimLiveness'`
  * `pod 'Jumio/LineFinderLiveness'`
  * `pod 'Jumio/MRZLiveness'`
  * `pod 'Jumio/BarcodeLiveness'`
  * `pod 'Jumio/NFCLiveness'`
* install hook for liveness is changed in the `podfile`:
```
post_install do |installer|
   installer.pods_project.targets.each do |target|
     if ['iProov', 'SwiftProtobuf', 'Starscream'].include? target.name
       target.build_configurations.each do |config|
           config.build_settings['BUILD_LIBRARY_FOR_DISTRIBUTION'] = 'YES'
       end
     end
    end
end
```

#### Frameworks
* iProov dependency `SwiftProtobuf` is added
* iProov dependency `SocketIO` is removed

## 4.3.1
No backward incompatible changes.

## 4.3.0

#### Changes to the Public API
* `Jumio.Scan.Update.fallback` has now an additional `Jumio.Scan.Update.FallbackReason`:
  * `userAction`: Initiated by the user through the call of `Jumio.Scan.ScanPart.fallback()`.
  * `lowPerformance`: Initiated due to low performance on the current `Jumio.Scan.Mode`.

* Document Verification is now supported. Please check the [Integration Guide](https://github.com/Jumio/mobile-sdk-ios/blob/master/docs/integration_guide.md#jumio-document-credential) for more information.

#### Cocoapods
* One new pod added, containing data analysis functionality:
  * `pod 'Jumio/Datadog'`
  * `pod 'Jumio/DocFinder'`
  * `pod 'Jumio/All'` replaces ~~`pod 'Jumio/Jumio'`~~ as default subspec of `pod 'Jumio'`

#### Simulator Slice
* Minimum iOS version for simulator slice was increased to 15.0

## 4.2.0

#### Changes to the Public API

* `Jumio.Theme.Value(light: UIColor?, dark: UIColor?)` has been replaced by `Jumio.Theme.Value(light: UIColor, dark: UIColor)`.
* `Jumio.Theme.Value(_: UIColor)` has been added. This initializer should be used to provide one color for both light and dark mode.
* `Jumio.Scan.Side` has been renamed to `Jumio.Credential.Part`.

## 4.1.2
No backward incompatible changes.

## 4.1.1

#### Customization
Added Customization functionality to enable customizing Jumio Theme. `Jumio.Theme` is a class that can be used to create a custom theme and override colors for Jumio views.

For more details on Customization, please refer to [Customization](integration_guide.md#customization) in our guides.

#### ObjC support
Added DefaultUI support for Objective-C based projects. Now `JumioSDK` class can be reached and initiated form Objective-C code with it's own configuration and delegate `JumioDefaultUIDelegate`.

## 4.1.0

#### Cocoapods
* Two new pods added, containing NFC scan functionality:
  * `pod 'Jumio/NFC'`
  * `pod 'Jumio/NFCLiveness'`

#### Instant Feedback Reject Reasons
Added Instant Feedback functionality to give more granular user feedback with new reject reasons:
* blackWhiteCopy
* colorPhotocopy
* digitalCopy
* notReadable
* noDoc
* missingBack
* missingFront
* blurry
* missingPartDoc
* damagedDocument
* hiddenPartDoc
* glare

## 4.0.0

#### Authentication
ℹ️&nbsp;&nbsp;__As of version 4.0.0 and onward, the SDK can only be used in combination with Jumio KYX or Jumio API v3. API v2 as well as using API token and secret to authenticate against the SDK will no longer be compatible.__

#### Cocoapods
Please refer to the [Integration section](integration_guide.md#integration) of our guides for a detailed description of all Cocoapods and framework changes.

#### Default UI Updates
As of SDK version 4.0.0, a lot of SDK parameters that previously could be set in the actual code are now contained within and provided by the `sdk.token`. These parameters have to be configured beforehand, during the API call that requests the token.

Please refer to the [Configuration section](integration_guide.md#configuration) of our integration guides for a detailed description of all Default UI changes and updates.

Information about which user journey (ID Verification, Identity Verification, Authentication, ...) the SDK is going to provide now also has to be specified during the API call that request the `sdk.token`.

For more details on individual Jumio workflows, please refer to [Workflow Descriptions](https://github.com/Jumio/implementation-guides/blob/master/api-guide/workflow_descriptions.md) in our guides.

#### Custom UI Updates
As of SDK version 4.0.0, Custom UI workflow has been completely restructured.

Please refer to the [Custom UI section](integration_guide.md#custom-ui) of our integration guides for a detailed description of all Custom UI changes and updates.

## 3.9.4
No backward incompatible changes.

## 3.9.3
No backward incompatible changes.

## 3.9.2
No backward incompatible changes.

## 3.9.1
* Enum `JumioRetryReason` now only contains the values:
  * `JumioFaceRetryReasonDeviceInLandscape`
  * `JumioFaceRetryReasonIProovGeneric`
  * `JumioFaceRetryReasonIProovGPA`
  * all ~~`JumioFaceRetryReasonZoom__`~~ cases have been removed

## 3.9.0
#### Frameworks
`MicroBlink.framework` has been renamed to be `Microblink.framework`

#### Changes to the Public API
Two new parameters added to the following methods:

`accountId` has been added to the following methods to return Account Id if available
`authenticationResult` has been added to `didFinishWithDocumentData` methods to return Authentication's result in case it was lunched for Authentication product.

* `(void) netverifyViewController:(NetverifyViewController* _Nonnull)netverifyViewController didFinishWithDocumentData:(NetverifyDocumentData * _Nonnull)documentData scanReference:(NSString* _Nonnull)scanReference accountId:(NSString* _Nullable)accountId authenticationResult:(BOOL)authenticationResult;`
* `(void) netverifyViewController:(NetverifyViewController* _Nonnull)netverifyViewController didCancelWithError:(NetverifyError* _Nullable)error scanReference: (NSString* _Nullable)scanReference accountId:(NSString* _Nullable)accountId;`

* `(void) netverifyUIController:(NetverifyUIController* _Nonnull)netverifyUIController didFinishWithDocumentData:(NetverifyDocumentData * _Nonnull)documentData scanReference:(NSString* _Nonnull)scanReference accountId:(NSString* _Nullable)accountId authenticationResult:(BOOL)authenticationResult;`
* `(void) netverifyUIController:(NetverifyUIController* _Nonnull)netverifyUIController didCancelWithError:(NetverifyError* _Nullable)error scanReference:(NSString* _Nullable)scanReference accountId:(NSString* _Nullable)accountId;`

#### Custom UI Changes
* Enum `JumioFaceRetryReasonIProovGPA` was added as an indicator that the returned help view is for `iProovGPA`
* Enum `JumioFaceRetryReasonIProovGeneric` is used as an indicator that the returned help view is for `iProovLA`
* Enum `NetverifyScanMode` was changed by replacing `NetverifyScanMode3DLiveness` with `NetverifyScanModeFaceZoom` and `NetverifyScanModeFaceIProov`

## 3.8.0
#### Localization Keys
The following keys have been added:
* `"IProov_IntroFlash"`
* `"IProov_IntroLa"`
* `"IProov_PromptLivenessAlignFace"`
* `"IProov_PromptLivenessNoTarget"`
* `"IProov_PromptLivenessScanCompleted"`
* `"IProov_PromptTooClose"`
* `"IProov_PromptTooFar"`

#### Custom UI Changes
Added two new methods to Netverify Custom UI:

* `(void) netverifyCustomScanViewControllerWillPrepareIProovController:(NetverifyCustomScanViewController * _Nonnull)customScanView;`

* `(void) netverifyCustomScanViewControllerWillPresentIProovController:(NetverifyCustomScanViewController * _Nonnull)customScanView;`

* Enum ~~`JumioZoomRetryReason`~~ is replaced by `JumioFaceRetryReason`

#### Cocoapods
* pod ~~`NetverifyFace`~~ is replaced by `NetverifyFace+iProov`

* pod `NetverifyFace+Zoom` is added

* install hook is added to the `podfile`:
```
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

#### Frameworks
* `JumioIProov.framework` is added
* `IProov.framework` is added
* iProov dependencies `[SocketIO, Starscream]` are added

#### Property Changes
Property `selectedCountry` in `NetverifyDocumentData` class is now nullable (optional).

## 3.7.2
#### Error Code Change
Error code N ("Required images are missing to finalize the acquisition") has been added.
Read more detailed information on this in chapter [Error codes](/docs/integration_guide.md#error-codes)

## 3.7.1
No backward incompatible changes.

## 3.7.0

#### NFC Setup
To make our SDK capable to read NFC chips you will need to set the following settings.

Add the Near Field Communication Tag Reading capability to your project, App ID and provisioning profiles in [Apple Developer portal](https://developer.apple.com).
Add `NFCReaderUsageDescription` to your info.plist file with a proper description of why you are using this feature. You will also need to add the following key and value to your plist file to be able to read NFC chips from passports.
```
<key>com.apple.developer.nfc.readersession.iso7816.select-identifiers</key>
<array>
    <string>A0000002471001</string>
</array>
```

#### Localization Files
Localization files have been moved from the main directory to `/Localizations`. If you are using manual integration or Carthage you will find the localization files under `JumioMobileSDK-3.7.0/Localizations`, in case you are using Cocoapods you can copy them from `/Pods/JumioMobileSDK-3.7.0/Localizations`

## 3.6.0

#### Custom UI Callbacks
`netverifyCustomScanViewController:shouldDisplayHelpWithText:animationView:forReason:` is called for each scanner that has a help animation.

#### Localization Keys
The following keys are no more uppercased

 `netverify.scan-help-view.liveness-help.button-continue.title`,
 `netverify.confirmation-view.button.continue`,
 `netverify.confirmation-view.button.retry`,
 `netverify.error-view.button.cancel.title` and
 `netverify.error-view.button.retry.title`

## 3.5.0

#### DocumentVerification Separation
Logic for DocumentVerification was split into a separate framework. Make sure that DocumentVerification.framework is linked in your project when updating to 3.5.0.

#### Cocoapods
* pod  `JumioMobileSDK/Netverify-Light` was replaced by `JumioMobileSDK/NetverifyBase`.

#### Localizable Strings
`netverify.confirmation-view.button.submit` was renamed to `netverify.confirmation-view.button.continue`

#### Error Codes
Error code D (Wrong API credentials used, retry impossible) has been removed

#### Dark Mode
Added additional theme to support dark mode. Set [`enableDarkMode`](https://jumio.github.io/mobile-sdk-ios/Netverify/Classes/JumioBaseView.html#/c:objc(cs)JumioBaseView(py)enableDarkMode) to `true` to change blur style and the standard foreground color.

## 3.4.2
* A new delegate `netverifyUIController:shouldRequireUserConsentWithURL:` was added to [`NetverifyUIControllerDelegate`](https://jumio.github.io/mobile-sdk-ios/Netverify/Protocols/NetverifyUIControllerDelegate.html)
* A new method `userConsentGiven:` was added to [`NetverifyUIController`](https://jumio.github.io/mobile-sdk-ios/Netverify/Classes/NetverifyUIController.html)

## 3.4.1
No backward incompatible changes.

## 3.4.0
#### Custom UI Callbacks
*  ~~`netverifyCustomScanViewController:shouldDisplayFlipDocumentHint:confirmation:`~~ has been replaced with [`netverifyCustomScanViewController:shouldDisplayConfirmationWithImageView:type:text:confirmation:retake:`](https://jumio.github.io/mobile-sdk-ios/Netverify/Protocols/NetverifyCustomScanViewControllerDelegate.html#/c:objc(pl)NetverifyCustomScanViewControllerDelegate(im)netverifyCustomScanViewController:shouldDisplayConfirmationWithImageView:type:text:confirmation:retake:)
* to be able to distinguish between different scenarios when the confirmation view is presented we added [`NetverifyConfirmationType`](https://jumio.github.io/mobile-sdk-ios/Netverify/Enums/NetverifyConfirmationType.html)

#### Localizable Strings
Several additions and changes, mostly in regards to the new confirmation view.


## 3.3.1
No backward incompatible changes.

## 3.3.0
No backward incompatible changes.

## 3.2.0

#### 3D-Liveness Handling via Custom UI
`netverifyCustomScanViewController:shouldDisplayHelpWithText:animationView:` was extended to [`netverifyCustomScanViewController:shouldDisplayHelpWithText:animationView:forReason:`](https://jumio.github.io/mobile-sdk-ios/Netverify/Protocols/NetverifyCustomScanViewControllerDelegate.html#/c:objc(pl)NetverifyCustomScanViewControllerDelegate(im)netverifyCustomScanViewController:shouldDisplayHelpWithText:animationView:forReason:) to return the `JumioZoomRetryReason`

#### Additions to the Public API for Jumio Screening
Added support for the Jumio screening feature, see new properties [`watchlistScreening`](https://jumio.github.io/mobile-sdk-ios/Netverify/Classes/NetverifyConfiguration.html#/c:objc(cs)NetverifyConfiguration(py)watchlistScreening) and [`watchlistSearchProfile`](https://jumio.github.io/mobile-sdk-ios/Netverify/Classes/NetverifyConfiguration.html#/c:objc(cs)NetverifyConfiguration(py)watchlistSearchProfile).

#### Changes to the Public API
`- (BOOL)updateConfiguration:(NetverifyConfiguration*)configuration;` has been removed.

## 3.1.2
No backward incompatible changes.

## 3.1.1
No backward incompatible changes.

## 3.1.0

#### NavigationBar Customization
`UINavigationBar+NetverifyAppearance.h` was renamed to `UINavigationBar+JumioAppearance.h` and moved to JumioCore.framework</br>
`NetverifyNavigationBarTitleImageView` was renamed to [`JumioNavigationBarTitleImageView`](https://jumio.github.io/mobile-sdk-ios/Netverify/Classes/JumioNavigationBarTitleImageView.html) and moved to JumioCore.framework

#### 3D-Liveness Handling via Custom UI
Please see [3D-Liveness in Custom Scan View Delegate](https://github.com/Jumio/mobile-sdk-ios/blob/master/docs/integration_guide.md#custom-scan-view-delegate)
`netverifyCustomScanViewControllerStartedBiometricAnalysis:`
`netverifyCustomScanViewController:shouldDisplayHelpWithText:animationView:`

`NetverifyScanModeFace` was changed to `NetverifyScanMode3DLiveness` for 3D-Liveness and `NetverifyScanModeFaceCapture` for alternative face capturing.

#### Additions in Visual Customization
Enhanced customization options `scanBackgroundColor` to colorize the background color during scanning, see [`NetverifyScanOverlay`](https://jumio.github.io/mobile-sdk-ios/Netverify/Classes/NetverifyScanOverlayView.html) class for the new option.

#### Changes to Device Information
`JMDeviceInfo` class has been renamed to `JumioDeviceInfo`


## 3.0.0

#### Changes to the Public API
`merchantApiToken` has been renamed to `apiToken`</br>
`merchantApiSecret` has been renamed to `apiSecret`</br>
`merchantReportingCriteria` has been renamed to `reportingCriteria`</br>
`customerId` has been renamed to `userReference`</br>
`requireFaceMatch` has been renamed to `enableIdentityVerification`</br>
`requireVerification` has been renamed to `enableVerification`</br>
`merchantScanReference` has been renamed to `customerInternalReference`</br>
`sdkVersion` was changed from instance to class function

#### Changes to Visual Customization
The protocol `NetverifyAppearance` has been replaced with `JumioAppearance`. </br>
 Example: `[[UINavigationBar netverifyAppearance] setTintColor:[UIColor yellowColor]]` has been changed to `[[UINavigationBar jumioAppearance] setTintColor:[UIColor yellowColor]]`.

#### New Framework NetverifyBarcode
When using Barcode scanning for Fastfill or Netverify, make sure to link NetverifyBarcode.framework and MicroBlink.framework to your app project. There is no new public API for you to consume, nor any implementation adaptions required.

#### Changes in Localizable-Netverify.strings
Added one value in regards to 3D face liveness.

## 2.15.0

#### New Frameworks NetverifyFace and ZoomAuthenticationHybrid
When using Identity Verification, make sure to link NetverifyFace.framework and ZoomAuthenticationHybrid.framework to your app project. There is no new public API for you to consume, nor any implementation adaptions required.
Please also make sure that the Umoove.framework from our previous releases is removed from your app.

#### Additions in Visual Customization
Enhanced customization options to colorize some UI elements on the 3D face liveness screen, see [`NetverifyScanOverlay`](https://jumio.github.io/mobile-sdk-ios/Netverify/Classes/NetverifyScanOverlayView.html) class for the new options.

#### Localizable Strings
Several additions and changes, mostly in regards to the new 3D face liveness capturing functionality.

## 2.14.0

#### Default Settings
The default values for [`requireVerification`](https://jumio.github.io/mobile-sdk-ios/Netverify/Classes/NetverifyConfiguration.html#/c:objc(cs)NetverifyConfiguration(py)requireVerification) and [`requireFaceMatch`](https://jumio.github.io/mobile-sdk-ios/Netverify/Classes/NetverifyConfiguration.html#/c:objc(cs)NetverifyConfiguration(py)requireFaceMatch) were changed to `YES`. Please make sure that they are explicitly set to NO in case a scan in Fastfill mode should be performed.

#### Enums
[`NetverifyDocumentType`](https://jumio.github.io/mobile-sdk-ios/Netverify/Enums/NetverifyDocumentType.html) was changed from NS_ENUM to NS_OPTIONS.

## 2.13.0

#### Enums
All enums were replaced by NS_ENUM to have better Swift support. When using Swift this Version will break when using [`NetverifyDocumentType`](https://jumio.github.io/mobile-sdk-ios/Netverify/Enums/NetverifyDocumentType.html), [`NetverifyDocumentVariant`](https://jumio.github.io/mobile-sdk-ios/Netverify/Enums/NetverifyDocumentVariant.html), [`NetverifyExtractionMethod`](https://jumio.github.io/mobile-sdk-ios/Netverify/Enums/NetverifyExtractionMethod.html), [`NetverifyGender`](https://jumio.github.io/mobile-sdk-ios/Netverify/Enums/NetverifyGender.html), [`NetverifyMRZFormat`](https://jumio.github.io/mobile-sdk-ios/Netverify/Enums/NetverifyMRZFormat.html), [`NetverifyScanMode`](https://jumio.github.io/mobile-sdk-ios/Netverify/Enums/NetverifyScanMode.html) or [`NetverifyScanSide`](https://jumio.github.io/mobile-sdk-ios/Netverify/Enums/NetverifyScanSide.html).

#### Changes in Localizable-Netverify.strings
changed values in regards to error texts

#### Cleanup of our SDK
The method `destroy` was introduced to properly clean up our SDK. Call this method to destroy the NetverifyViewController instance, before you set it to nil. When re-initializing [`NetverifyViewController`](https://jumio.github.io/mobile-sdk-ios/Netverify/Classes/NetverifyViewController.html) or [`NetverifyUIController`](https://jumio.github.io/mobile-sdk-ios/Netverify/Classes/NetverifyUIController.html) make sure you've called  `destroy` in advance otherwise an exception will be raised during initializing.

## 2.12.0

#### Localizable Strings
In addition to English, strings are now translated to Chinese (Simplified), Dutch, French, German and Spanish. Each .strings file can now be found in the specific \*.lproj folders.

#### Additional Information Property Removed
Property `additionalInformation` has been removed.

## 2.11.0

#### New Error Scheme
Instead of `NSError` objects we now return `NetverifyError` in `netverifyViewController:didFinishInitializingWithError:` and `netverifyViewController:didCancelWithError:scanReference:`.

Please note, that `code` now is a NSString.
Read more detailed information on this in [Retrieving information](/docs/integration_guide.md#retrieving-information)

#### Changes in Localizable-Netverify.strings
Added values in regards to legal masking.

## 2.10.1
#### Changes in Localizable-Netverify.strings
Added one value in regards to legal masking.

## 2.10.0

#### Changed Handling of Frameworks to Use a Single Artifact Instead of Two
The framework binaries are available with support for device and simulator architecture. Make sure to remove the simulator architecture from our frameworks for app submissions to the AppStore, as it would cause a rejection by Apple. Read more detailed information on this in our [Manual integration](/README.md#manual) section.

#### Moved Podspec File to Github
The Jumio specific source in your Podfile is no longer needed. From now on, `JumioMobileSDK` is the only pod available. `JumioMobileSDK-FAT` is not offered anymore.

#### Exception Handling in Swift
For initialization of NetverifyViewController or NetverifyUIController in Swift, you need to catch the underlying exception and translate it into a `NSError` instance. Whenever an exception is thrown, the `NetverifyViewController` or `NetverifyUIController` instance will be nil and the SDK is not usable. See our [sample implementation](/sample/SampleSwift/NetverifyStartViewController.swift) on how this is applied.

#### Changes in Localizable-Netverify.strings
Removed some unused values.

## 2.9.2
No backward incompatible changes.

## 2.9.1
No backward incompatible changes.

## 2.9.0

#### Changes in Localizable-Netverify.strings
Several additions and changes, mostly in regards to the new scan options and face guidance screen.

#### Additions in Visual Customization
Enhanced customization options to colorize the scan options header and buttons.
Class `NetverifyScanOptionsButton` was replaced by `NetverifyDocumentSelectionButton` and `NetverifyDocumentSelectionHeaderView`.

## 2.8.1
No backward incompatible changes.

## 2.8.0

#### Additions in Visual Customization
Added customization options to colorize the scan overlay screens.

#### Changes in Localizable-Netverify.strings
Removed three values in regards to a compliance hint

## 2.7.0

#### Changes in Localizable-Netverify.strings
Several additions and changes, mostly in regards to the new liveness screen.

## 2.5.0

#### Changes in Visual Customization
Removed _NetverifyCameraFlashButton_ as the icons to switch camera and toggle flash were moved to the navigation bar.

#### Changes in Localizable-Netverify.strings
Multiple additions and changes in regards to the new guidance / help screen.

## 2.4.0
No backward incompatible changes.

## 2.3.1
No backward incompatible changes.

## 2.3.0
#### Renamed Enum Types
Renamed the following enum types:
 * `NVDocumentVariant` to `NetverifyDocumentVariant`
 * `NVGender` to `NetverifyGender`
 * `NVMRZFormat` to `NetverifyMRZFormat`
 * `NVExtractionMethod` to `NetverifyExtractionMethod`.

#### Removed Name Match Feature
Name matching by comparing a provided name with the extracted name from a document was removed. The property _name_ in BAMCheckoutViewController class is deleted, as well as the boolean _nameMatch_ and integer _nameDistance_ in BAMCheckoutCardInformation class.

## 2.2.0
#### Removed Liveness Detection Result
Parameter `livenessDetected` has been removed from `NetverifyDocumentData`.

## 2.1.0
#### Exceptions at Initialization
An exception is thrown in case mandatory parameters in the `NetverifyConfiguration` object are invalid.

#### Changes in Localizable-Netverify.strings
Removed one string in regards to scanning not possible.
