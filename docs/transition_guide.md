![Header Graphic](images/jumio_feature_graphic.jpg)

# Transition Guide for iOS SDK

This section covers all technical changes that should be considered when updating from previous versions, including, but not exclusively: API breaking changes or new functionality in the public API, major dependency changes, attribute changes, deprecation notices.

⚠️&nbsp;__Note:__
When updating your SDK version, **all** changes/updates made in in the meantime have to be taken into account and applied if necessary.
**Example:** If you're updating from SDK version **3.7.2** to **3.9.2**, the changes outlined in **3.8.0, 3.9.0** and **3.9.1** are **still relevant**.

## 4.15.0

#### Changes to Public API

The following functions and property-getters are now `async`:

- `Jumio.Controller.cancel()`
- `Jumio.Credential.cancel()`
- `Jumio.ScanPart.cancel()`
- `Jumio.ScanPart.finish()`
- `Jumio.Scan.View.isShutterEnabled`
- `Jumio.Scan.View.flash`
  - Added `Jumio.Scan.View.set(flash:)` as `Jumio.Scan.View.flash` is get-only.
- `Jumio.Scan.View.hasFlash`

The following functions and properties are now annotated with `@MainActor`:

- `Jumio.Confirmation.Handler.parts`
- `Jumio.Confirmation.Handler.renderPart(part:,view:)`
- `Jumio.Reject.Handler.parts`
- `Jumio.Reject.Handler.renderPart(part:,view:)`
- All functions in `Jumio.DefaultUI.Delegate`
- All functions in `Jumio.Controller.Delegate`
- All functions in `Jumio.ScanPart.Delegate`
- All functions in `Jumio.Preloader.Delegate`

The following classes, structs and enums conform now to `Sendable`:

- `Jumio.Theme` and all structs within
- `Jumio.Scan.Mode`
- `Jumio.Scan.Step`
- `Jumio.Scan.Update`
- `Jumio.Scan.Update.ExtractionState`
- `Jumio.Scan.Update.FallbackReason`
- `Jumio.Scan.Update.FlashState`
- `Jumio.Scan.Update.TiltState`

#### Customization options

- Added `Jumio.Theme.NFC.phoneScreen`
- Added `Jumio.Theme.NFC.chipPrimary`
- Added `Jumio.Theme.NFC.chipSecondary`
- Added `Jumio.Theme.NFC.chipBorder`
- Added `Jumio.Theme.NFC.pulse`

#### Localization Keys

The following keys have been added:

- `jumio_nfc_error_description_id`
- `jumio_nfc_error_description_other`
- `jumio_nfc_error_description_us`

The following key has been removed:

- `jumio_nfc_retry_error_general`

## 4.14.0

#### Scan Updates

- Added `Jumio.Scan.Update.ExtractionState.imageAnalysis`
- Added `Jumio.Scan.Update.cameraAvailable`

#### Localization Keys

The following keys have been added:

- `jumio_id_scan_prompt_analyzing`
- `jumio_scan_switch_to_back_camera`
- `jumio_scan_switch_to_front_camera`
- `jumio_switched_to_back_camera`
- `jumio_switched_to_front_camera`
- `jumio_button_continue`
- `jumio_change_issuing_country`
- `jumio_current_issuing_country`
- `jumio_eidas_description`
- `jumio_eidas_login_header`
- `jumio_european_did_login_header`
- `jumio_id_scan_hint_error_fallback`
- `jumio_select`

## 4.13.0

- Increased minimum iOS version to 13.0.
- Removed `Jumio/Datadog` module.

## 4.12.0

#### Scan Modes

- Added `Jumio.Scan.Mode.livenessPremium`

#### Scan Updates

- Added `Jumio.Scan.Update.ExtractionState.tiltFaceUp`
- Added `Jumio.Scan.Update.ExtractionState.tiltFaceDown`
- Added `Jumio.Scan.Update.ExtractionState.tiltFaceLeft`
- Added `Jumio.Scan.Update.ExtractionState.tiltFaceRight`
- Added `Jumio.Scan.Update.ExtractionState.moveFaceIntoFrame`

#### Jumio IDResult

- Added `curp` to `Jumio.IDResult`
- Removed `rawBarcodeData` from `Jumio.IDResult`

#### Localization Keys

The following keys have been added:

- `jumio_liveness_prompt_keep_centered`
- `jumio_liveness_prompt_keep_still`
- `jumio_liveness_prompt_keep_upright`
- `jumio_liveness_prompt_move_away`
- `jumio_liveness_prompt_success_another_scan`
- `jumio_liveness_prompt_tilt_down`
- `jumio_liveness_prompt_tilt_left`
- `jumio_liveness_prompt_tilt_right`
- `jumio_liveness_prompt_tilt_up`
- `jumio_liveness_scanning_completed`
- `jumio_error_scanning_not_possible`

The following keys have been removed:

- `jumio_liveness_prompt_success_another_shot`
- `jumio_error_ocr_failed`

#### Reject Reasons

- Added `Jumio.RejectReason.invalidCertificate`

#### File Attacher

- Added property `helpUrl`

#### ML Models

- Replaced model for determining liveness. Find the new model [here](https://cdn.mobile.jumio.ai/ios/model/liveness_sdk_assets_v_1_1_5.enc).

## 4.11.1

- Removed `Jumio/Datadog` from default podspec configuration. This fixes [this known issue](known_issues.md#xcode16).

## 4.11.0

#### SPM

- Library `JumioLocalization` makes it possible to localize strings with Swift Package Manager.

#### Scan Updates

- Added `Jumio.Scan.Update.ExtractionState.tilt`
- Added `Jumio.Scan.Update.TiltState`
- Added additional time parameter (in seconds) for `Jumio.Scan.Update.ExtractionState.holdStill` update
- Added `Jumio.Scan.Update.nextPosition`

#### Scan Steps

- `Jumio.Scan.Step.imageTaken` is sent exactly once per scan.
  - Please use `Jumio.Scan.Update.nextPosition` to determine the position change for Jumio Liveness instead.

#### Logical Errors

- Deprecated `noDataCenterSet` error
- Added `tokenValidationFailed` error for starting SDK with empty token
- Added `dataCenterValidationFailed` error for starting SDK without datacenter

#### Localization Keys

The following keys have been added:

- `jumio_id_scan_guide_photo_side_tilt`
- `jumio_id_scan_prompt_tilt_less`
- `jumio_id_scan_prompt_tilt_more`

#### Reject Reasons

- Added `401 unsupportedDocument` to `Jumio.RejectReason`.

## 4.10.1

- Removed `Jumio/Datadog` from default podspec configuration. This fixes [this known issue](known_issues.md#xcode16).

## 4.10.0

- Added `Jumio.Scan.Update.flash(FlashState)`
- Added `Jumio.Scan.Update.FlashState`
- Changed customization options
  - Renamed `Jumio.Theme.bubble.circleItemForeground` to `Jumio.Theme.bubble.outline`
  - Renamed `Jumio.Theme.scanView.bubbleForeground` to `Jumio.Theme.scanView.tooltipForeground`
  - Renamed `Jumio.Theme.scanView.bubbleBackground` to `Jumio.Theme.scanView.tooltipBackground`
  - Removed `Jumio.Theme.bubble.circleItemBackground`
  - Removed `Jumio.Theme.searchBubble.backgroundSelected`
  - Removed `Jumio.Theme.scanOverlay.fill`
  - Removed `Jumio.Theme.scanOverlay.scanOverlayTransparent`

#### Localization Keys

The following keys have been added:

- `jumio_id_scan_prompt_captured`

The following keys have been removed:

- `jumio_id_scan_prompt_front_captured`
- `jumio_id_scan_prompt_back_captured`

#### Localization

- Added Serbian (Cyril) `sr-Cyrl`
- Added Serbian (Latin) `sr-Latn`

## 4.9.1

- Fixed a crash on iOS 12 app startup.

## 4.9.0

- Minimum iOS version raised to 12.
- Removed `Jumio/DocFinder` dependency as the functionality was moved to Jumio core. Every dependency now contains DocFinder functionality.
- Removed `Jumio/DeviceRisk` dependency as the functionality was moved to Jumio API. Plase check out our [Integration guide](integration_guide.md#risk-signal-device-risk).
- Removed Default UI from Jumio core functionality
  - Added `Jumio/DefaultUI`
  - Check out the [Integration Guide](integration_guide.md)
- Added `idSubType` to `Jumio.IDResult`
- Added `Jumio/Preloader`, check out the [Integration Guide](integration_guide.md#preloading-models)
- New `Jumio.Retry.Reason.Face`
  - generic
  - tooMuchMovement
  - lightingTooBright
  - lightingTooDark
  - eyesClosed
  - obscuredFace
  - multipleFaces
  - sunglasses
- Changed customization options
  - Added `Jumio.Theme.face`
  - Added `Jumio.Theme.PrimaryButton.outline`
  - Added `Jumio.Theme.SecondaryButton.foregroundPressed`
  - Added `Jumio.Theme.SecondaryButton.foregroundDisabled`
  - Added `Jumio.Theme.SecondaryButton.outline`
  - Added `Jumio.Theme.SearchBubble.outline`
  - Added `Jumio.Theme.Loading.loadingAnimationGradient`
  - Added `Jumio.Theme.Loading.loadingAnimationErrorGradient`
  - Added `Jumio.Theme.Confirmation.imageBorder`
  - Renamed `Jumio.Theme.Bubble.selectionIconForeground` to `Jumio.Theme.selectionIconForeground`
  - Renamed `Jumio.Theme.SearchBubble.listItemSelected` to `Jumio.Theme.SearchBubble.backgroundSelected`

## 4.8.1

- Removed `Starscream` dependency for `Jumio/IProov`.

## 4.8.0

#### Manual Integration

- Framework `JumioLiveness.xcframework` is now required when using `JumioIProov.xcframework`

#### Carthage Integration

- Framework `JumioLiveness.xcframework` is now required when using `JumioIProov.xcframework`

## 4.7.1

- Removed `Starscream` dependency for `Jumio/IProov`.

## 4.7.0

#### Barcode

- Removed `Jumio/Barcode` dependency as the functionality was moved to Jumio core. Every dependency now contains Barcode functionality.

#### MRZ

- Removed `Jumio/MRZ` dependency. Please use `Jumio/Jumio` instead.

#### NFC

- Removed `Jumio/NFC` dependency. Please use `Jumio/Jumio` instead.

#### Linefinder

- Removed `Jumio/LineFinder` dependency. Please use `Jumio/Slim` in combination with `Jumio/DocFinder` instead.

#### Changes to Public API

- Deprecated `Jumio.Theme.IProov.animationForeground`
  - Added `Jumio.Theme.ScanHelp.faceAnimationForeground`
- Deprecated `Jumio.Theme.IProov.animationBackground`
  - Added `Jumio.Theme.ScanHelp.faceAnimationBackground`
- Deprecated `Jumio.Theme.PrimaryButton.text`
  - Added `Jumio.Theme.PrimaryButton.foreground`
- Deprecated `Jumio.Theme.SecondaryButton.text`
  - Added `Jumio.Theme.SecondaryButton.foreground`
- Added `Jumio.Theme.PrimaryButton.foregroundPressed`
- Added `Jumio.Theme.PrimaryButton.foregroundDisabled`
- Removed `Jumio.Scan.Mode.lineFinder`
- Removed `Jumio.Scan.Mode.mrz`
- Deprecated `Jumio.Scan.Update.legalHint`
- Deprecated `Jumio.SDK.giveDataDogConsent(enabled: Bool)`
- Deprecated `Jumio.IDResult.rawBarcodeData`

#### Localization Keys

The following keys have been added:

- jumio_id_scan_guide_photo_side
- jumio_id_scan_guide_back_side
- jumio_id_scan_guide_photo_side_manually
- jumio_id_scan_guide_back_side_manually

The following keys have been removed:

- jumio_id_scan_guide_take_photo_front_idc
- jumio_id_scan_guide_take_photo_back_idc
- jumio_id_scan_guide_take_photo_passport
- jumio_id_scan_guide_take_photo_front_dl
- jumio_id_scan_guide_take_photo_back_dl
- jumio_id_scan_guide_take_photo_front_pd
- jumio_id_scan_guide_take_photo_back_pd

#### Localization

- Replaced Portuguese `pt` with Portuguese (Portugal) `pt-PT`
- Added Portugise (Brasil) `pt-BR`

#### SPM

- Library `JumioDatadog` which can be used to integrate JumioDatadog.

#### Carthage

- Added `JumioDatadog.json`.

#### Frameworks

- Datadog dependency `DatadogSDK` is removed

## 4.6.2

- Removed `Starscream` dependency for `Jumio/IProov`.

## 4.6.1

#### Cocoapods

- `pod 'Jumio/DeviceRisk'` was removed from `pod 'Jumio/All'`.

## 4.6.0

#### Liveness

- Added new library `JumioLiveness` to enhance the Liveness user experience/interface. Check out our [Integration Guide](integration_guide.md).
- Removed liveness confirmation handling

#### Cocoapods

- `pod 'Jumio/IProov'` replaces ~~`pod 'Jumio/Liveness'`~~ as new pod for using iProov liveness technology.
- `pod 'Jumio/Liveness'` is now required to use the Jumio liveness solution.

#### SPM

- Library `'JumioIProov'` replaces ~~`'JumioLiveness'`~~ as new library for our iProov liveness solution.
- Library `'JumioLiveness'` is now required to use the Jumio liveness solution.

#### Carthage

- Added `'JumioLiveness.json'` which is now required to use the Jumio liveness solution.

#### Changes to Public API

- Deprecated `Jumio.Theme.ScanView.shutter`:
  - Added `Jumio.Theme.ScanView.documentShutter`
  - Added `Jumio.Theme.ScanView.faceShutter`

## 4.5.0

#### Customization

- Option `Jumio.Theme.ScanView.animationBackground` has been removed.

#### Changes to Public API

- Error code format updated from `[A][x][yyyy]` to `[A][xx][yyyy]`
- Deprecated `Jumio.IDCredential.countries`:
  - Added `Jumio.IDCredential.supportedCountries`
  - Added `Jumio.IDCredential.physicalDocuments(for:)`
  - Added `Jumio.IDCredential.digitalDocuments(for:)`
- Added `Jumio.SDK.handleDeeplinkURL()`
- Added `Jumio.Document.Physical`
- Added `Jumio.Document.Digital`
- New `Jumio.Credential.Part`
  - digital
- New `Jumio.Scan.Step`
  - digitalIdentityView
  - thirdPartyVerification
- New `Jumio.Retry.Reason.DigitalIdentity`
  - unknown
  - expired
  - thirdPartyVerificationError
  - serviceError
- Changed `JumioScanView`
  - Changed `extraction` variable to get-only
  - Added `startExtraction()` function
  - Added `stopExtraction(hidePreview: Bool)` function
- Changed `JumioControllerDelegate`
  - Changed `jumio(controller: Jumio.Controller, didInitializeWith credentialInformations: [Jumio.Credential.Info], policyUrl: String?)` to `jumio(controller: Jumio.Controller, didInitializeWith credentialInformations: [Jumio.Credential.Info], consentItems: [Jumio.ConsentItem]?)`
- Changed `Jumio.Controller`
  - Changed `userConsented()` to be `userConsented(to consentItem: Jumio.ConsentItem, decision: Bool)`
  - Added `getUnconsentedItems() -> [Jumio.ConsentItem]?`

#### Localization Keys

The following keys have been added:

- jumio_idtype_di
- jumio_di_vendor_selection_title
- jumio_di_retry_unknown
- jumio_di_retry_third_party_verification_error
- jumio_di_retry_service_error
- jumio_di_back_to_document_selection

#### Cocoapods

- install hook for liveness is changed in the `podfile`:

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

- iProov dependency `SwiftProtobuf` is removed

## 4.4.0

#### Changes to Public API

- New `Jumio.Credential.Part`
  - `multipart`: This is the new Autocapture scan part. Instead of having a single scan part for all parts of a document (front, back), there is now a single `multipart` scan part that combines the two. Within this scan part all needed parts of a document are captured at once.
- New `Jumio.Scan.Step`
  - `nextPart`: This scan step shows that the previous part has been captured and the next one can be started (e.g. frontside has been captured, now switch to the backside of the document). Contains the `Jumio.Credential.Part` as additional data. We suggest to actively guide the user to move to the next part, e.g. by showing an animation and by disabling the extraction during the animation.
- Updated `Jumio.Scan.Step.started`
  - Added `Jumio.Credential.Part` as additional data
- Changed confirmation and reject handling
  - Added `Jumio.Confirmation.Handler`
  - Added `Jumio.Reject.Handler`
  - Moved `attach`, `detach`, `retake` and `confirm` methods from `Jumio.Confirmation.View` to `Jumio.Confirmation.Handler`
  - Moved `attach`, `detach` and `retake` methods from `Jumio.Reject.View` to `Jumio.Reject.Handler`
  - As a result the confirmation views for front and/or back within multipart scans are obsolete and not existing anymore.
- New `Jumio.Retry.Reason.iProov`:
  - faceMisaligned
  - eyesClosed
  - faceTooFar
  - faceTooClose
  - sunglasses
  - obscuredFace
  - userTimeout
  - notSupported
- Updated `Jumio.Scan.Step.rejectView`:
  - The returned scan step data now contains a dictionary `[Jumio.Credential.Part: Jumio.RejectReason]` instead of a single `Jumio.RejectReason`.
- Removed `Jumio.Retry.Reason.iProov`:
  - ambiguousOutcome
  - lightingFlash
  - lightingBacklit
  - motionMouth
- New options in `Jumio.Theme.IProov`:
  - filterBackgroundColor
  - surroundColor
  - livenessAssuranceCompletedOvalStrokeColor
- Renamed options in `Jumio.Theme.IProov`:
  - lineColor to filterForegroundColor
  - headerTextColor to titleTextColor
  - floatingPromptRoundedCorners to promptRoundedCorners
  - genuinePresenceAssuranceReadyOverlayStrokeColor to genuinePresenceAssuranceReadyOvalStrokeColor
  - genuinePresenceAssuranceNotReadyOverlayStrokeColor to genuinePresenceAssuranceNotReadyOvalStrokeColor
  - livenessAssuranceOverlayStrokeColor to livenessAssuranceOvalStrokeColor
  - genuinePresenceAssuranceReadyFloatingPromptBackgroundColor to promptBackgroundColor
  - genuinePresenceAssuranceNotReadyFloatingPromptBackgroundColor to promptBackgroundColor
  - livenessAssuranceFloatingPromptBackgroundColor to promptBackgroundColor
- Removed options in `Jumio.Theme.IProov`:
  - headerBackgroundColor
  - footerBackgroundColor
  - livenessAssurancePrimaryTintColor
  - livenessAssuranceSecondaryTintColor
  - genuinePresenceAssuranceProgressBarColor
  - genuinePresenceAssuranceNotReadyTintColor
  - genuinePresenceAssuranceReadyTintColor
  - floatingPromptEnabled

#### Localization Keys

The following keys have been added:

- IProov_PromptAlignFace
- IProov_FailureEyesClosed
- IProov_FailureFaceTooClose
- IProov_FailureFaceTooFar
- IProov_FailureMisalignedFace
- IProov_FailureNotSupported
- IProov_FailureObscuredFace
- IProov_FailureSunglasses
- IProov_FailureTooBright
- IProov_FailureTooDark
- IProov_FailureTooMuchMovement
- IProov_FailureUnknown
- IProov_FailureUserTimeout
- IProov_AccessibilityPromptAlignFace
- IProov_AccessibilityPromptScanning
  The following keys have been renamed:
- IProov_ErrorCameraPermissionDeniedMessageIos to IProov_ErrorCameraPermissionDeniedMessage
  The following keys have been removed:
- IProov_MessageFormat
- IProov_PromptTapToBegin
- IProov_PromptLivenessAlignFace
- IProov_PromptLivenessNoTarget
- IProov_PromptGenuinePresenceAlignFace
- IProov_ProgressStreamingSlow
- IProov_PromptGrantPermission
- IProov_PromptGrantPermissionMessage
- IProov_FailureAmbiguousOutcome
- IProov_FailureLightingBacklit
- IProov_FailureLightingFaceTooBright

* IProov_FailureLightingFlashReflectionTooLow

- IProov_FailureLightingTooDark
- IProov_FailureMotionTooMuchMouthMovement
- IProov_FailureMotionTooMuchMovement

#### Liveness

- We have seperated our liveness solution in `JumioIProov.xcframework`. You need to add this framework beside `Jumio.xcframework` to your project.

#### Cocoapods

- The following pods have been removed. Instead `Jumio/Liveness` should be added in your pod file.
  - `pod 'Jumio/SlimLiveness'`
  - `pod 'Jumio/LineFinderLiveness'`
  - `pod 'Jumio/MRZLiveness'`
  - `pod 'Jumio/BarcodeLiveness'`
  - `pod 'Jumio/NFCLiveness'`
- install hook for liveness is changed in the `podfile`:

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

- iProov dependency `SwiftProtobuf` is added
- iProov dependency `SocketIO` is removed

## 4.3.1

No backward incompatible changes.

## 4.3.0

#### Changes to the Public API

- `Jumio.Scan.Update.fallback` has now an additional `Jumio.Scan.Update.FallbackReason`:

  - `userAction`: Initiated by the user through the call of `Jumio.Scan.ScanPart.fallback()`.
  - `lowPerformance`: Initiated due to low performance on the current `Jumio.Scan.Mode`.

- Document Verification is now supported. Please check the [Integration Guide](integration_guide.md#jumio-document-credential) for more information.

#### Cocoapods

- One new pod added, containing data analysis functionality:
  - `pod 'Jumio/Datadog'`
  - `pod 'Jumio/DocFinder'`
  - `pod 'Jumio/All'` replaces ~~`pod 'Jumio/Jumio'`~~ as default subspec of `pod 'Jumio'`

#### Simulator Slice

- Minimum iOS version for simulator slice was increased to 15.0

## 4.2.0

#### Changes to the Public API

- `Jumio.Theme.Value(light: UIColor?, dark: UIColor?)` has been replaced by `Jumio.Theme.Value(light: UIColor, dark: UIColor)`.
- `Jumio.Theme.Value(_: UIColor)` has been added. This initializer should be used to provide one color for both light and dark mode.
- `Jumio.Scan.Side` has been renamed to `Jumio.Credential.Part`.

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

- Two new pods added, containing NFC scan functionality:
  - `pod 'Jumio/NFC'`
  - `pod 'Jumio/NFCLiveness'`

#### Instant Feedback Reject Reasons

Added Instant Feedback functionality to give more granular user feedback with new reject reasons:

- blackWhiteCopy
- colorPhotocopy
- digitalCopy
- notReadable
- noDoc
- missingBack
- missingFront
- blurry
- missingPartDoc
- damagedDocument
- hiddenPartDoc
- glare

## 4.0.0

#### Authentication

ℹ️&nbsp;&nbsp;**As of version 4.0.0 and onward, the SDK can only be used in combination with Jumio KYX or Jumio API v3. API v2 as well as using API token and secret to authenticate against the SDK will no longer be compatible.**

#### Cocoapods

Please refer to the [Integration section](integration_guide.md#via-cocoapods) of our guides for a detailed description of all Cocoapods and framework changes.

#### Default UI Updates

As of SDK version 4.0.0, a lot of SDK parameters that previously could be set in the actual code are now contained within and provided by the `sdk.token`. These parameters have to be configured beforehand, during the API call that requests the token.

Please refer to the [Configuration section](integration_guide.md#configuration) of our integration guides for a detailed description of all Default UI changes and updates.

Information about which user journey (ID Verification, Identity Verification, Authentication, ...) the SDK is going to provide now also has to be specified during the API call that request the `sdk.token`.

For more details on individual Jumio workflows, please refer to [Workflow Descriptions](https://documentation.jumio.ai/docs/references/servicesAndworkflow/standardService/standardServices) in our guides.

#### Custom UI Updates

As of SDK version 4.0.0, Custom UI workflow has been completely restructured.

Please refer to the [Custom UI section](integration_guide.md#custom-ui) of our integration guides for a detailed description of all Custom UI changes and updates.
