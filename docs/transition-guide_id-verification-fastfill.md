![ID Verification and Fastfill](images/id-verification-fastfill.jpg)

# Transition guide for ID Verification & Fastfill
This section only covers the breaking technical changes that should be considered when updating from the previous version.

⚠️ When updating your SDK version, __all__ changes/updates made in in the meantime have to be taken into account and applied if necessary. If you're updating from SDK version __3.7.1__ to __3.9.4__, the changes outlined in __3.7.2, 3.8.0, 3.9.0__ and all subsequent versions are __still relevant__.

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
Two new parameters added to the follwing methods:

`accountId` has been added to the following methods to return Account Id if available
`authenticationResult` has been added to `didFinishWithDocumentData` methods to return Authentication's result in case it was lunched for Authentication product.

* `(void) netverifyViewController:(NetverifyViewController* _Nonnull)netverifyViewController didFinishWithDocumentData:(NetverifyDocumentData * _Nonnull)documentData scanReference:(NSString* _Nonnull)scanReference accountId:(NSString* _Nullable)accountId authenticationResult:(BOOL)authenticationResult;`
* `(void) netverifyViewController:(NetverifyViewController* _Nonnull)netverifyViewController didCancelWithError:(NetverifyError* _Nullable)error scanReference: (NSString* _Nullable)scanReference accountId:(NSString* _Nullable)accountId;`

* `(void) netverifyUIController:(NetverifyUIController* _Nonnull)netverifyUIController didFinishWithDocumentData:(NetverifyDocumentData * _Nonnull)documentData scanReference:(NSString* _Nonnull)scanReference accountId:(NSString* _Nullable)accountId authenticationResult:(BOOL)authenticationResult;`
* `(void) netverifyUIController:(NetverifyUIController* _Nonnull)netverifyUIController didCancelWithError:(NetverifyError* _Nullable)error scanReference:(NSString* _Nullable)scanReference accountId:(NSString* _Nullable)accountId;`

####  Custom UI changes
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
Read more detailed information on this in chapter [Error codes](/docs/integration_id-verification-fastfill.md#error-codes)

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
Please see [3D-Liveness in Custom Scan View Delegate](https://github.com/Jumio/mobile-sdk-ios/blob/master/docs/integration_id-verification-fastfill.md#custom-scan-view-delegate)
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
Read more detailed information on this in [Retrieving information](/docs/integration_id-verification-fastfill.md#retrieving-information)

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
