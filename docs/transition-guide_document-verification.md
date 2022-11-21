![Jumio](images/document_verification.jpg)

# Transition guide for Document Verification
This section only covers the breaking technical changes that should be considered when updating from the previous version.

⚠️ When updating your SDK version, __all__ changes/updates made in in the meantime have to be taken into account and applied if necessary. If you're updating from SDK version __3.7.1__ to __3.9.6__, the changes outlined in __3.7.2, 3.8.0, 3.9.0__ and all subsequent versions are __still relevant__.

## 3.9.6
No backward incompatible changes.

## 3.9.4
No backward incompatible changes.

## 3.9.3
No backward incompatible changes.

## 3.9.2
No backward incompatible changes.

## 3.9.1
No backward incompatible changes.

## 3.9.0
No backward incompatible changes.

## 3.8.0
No backward incompatible changes.

## 3.7.2
No backward incompatible changes.

## 3.7.1
No backward incompatible changes.

## 3.7.0

#### Localization Files
Localization files have been moved from the main directory to `/Localizations`. If you are using manual integration or Carthage you will find the localization files under `JumioMobileSDK-3.7.0/Localizations`, in case you are using Cocoapods you can copy them from `/Pods/JumioMobileSDK-3.7.0/Localizations`

## 3.6.0

#### Localization Keys
The following keys are no more uppercased

 `dv.scan-view.confirmation.button.readable`,
 `dv.scan-view.confirmation.button.retake`,
 `dv.error-view.button.retry` and
 `dv.error-view.button.cancel`


## 3.5.0

#### DocumentVerification Separation
Logic for DocumentVerification was split into a separate framework. Make sure that DocumentVerification.framework is linked in your project when updating to 3.5.0.

#### Cocoapods

* New cocoapods subspec `JumioMobileSDK/DocumentVerification` was created.

#### Changes to Visual Customization
`DocumentVerificationBaseView` to be used instead of  `NetverifyBaseView`
`DocumentVerificationNegativeButton` to be used instead of  `NetverifyPositiveButton`
`DocumentVerificationPositiveButton` to be used instead of  `BAMCheckoutNegativeButton`


#### Localizable Strings
New Added Keys:

`dv.scan-view.accessibility-label.button.switch-to-front-camera`
`dv.scan-view.accessibility-label.button.switch-to-back-camera`
`dv.scan-view.accessibility-label.flash-button.activate`
`dv.scan-view.accessibility-label.flash-button.deactivate`
`dv.scan-view.accessibility-label.button.take-photo`
`dv.scan-options.accessibility-label.close-button`

#### Error Codes
Error code D (Wrong API credentials used, retry impossible) has been removed

#### Dark Mode
Added additional theme to support dark mode. Set [`enableDarkMode`](https://jumio.github.io/mobile-sdk-ios/DocumentVerification/Classes/JumioBaseView.html#/c:objc(cs)JumioBaseView(py)enableDarkMode) to `true` to change blur style and the standard foreground color.

## 3.4.2
No backward incompatible changes.

## 3.4.1
No backward incompatible changes.

## 3.4.0
No backward incompatible changes.

## 3.3.1
No backward incompatible changes.

## 3.3.0
No backward incompatible changes.

## 3.2.0
No backward incompatible changes.

## 3.1.2
No backward incompatible changes.

## 3.1.1
No backward incompatible changes.

## 3.1.0

#### NavigationBar customization
`UINavigationBar+NetverifyAppearance.h` was renamed to `UINavigationBar+JumioAppearance.h` and moved to JumioCore.framework</br>
`NetverifyNavigationBarTitleImageView` was renamed to [`JumioNavigationBarTitleImageView`](https://jumio.github.io/mobile-sdk-ios/DocumentVerification/Classes/JumioNavigationBarTitleImageView.html) and moved to JumioCore.framework

#### Changes to Device Information
`JMDeviceInfo` class has been renamed to `JumioDeviceInfo`

## 3.0.0

#### Changes to the Public API
`merchantApiToken` has been renamed to `apiToken`</br>
`merchantApiSecret` has been renamed to `apiSecret`</br>
`merchantReportingCriteria` has been renamed to `reportingCriteria`</br>
`customerId` has been renamed to `userReference`</br>
`merchantScanReference` has been renamed to `customerInternalReference`</br>
`sdkVersion` was changed from instance to class function

#### Changes to Visual Customization
 The protocol `NetverifyAppearance` has been replaced with `JumioAppearance`. </br>
 Example: `[[UINavigationBar netverifyAppearance] setTintColor:[UIColor yellowColor]]` has been changed to `[[UINavigationBar jumioAppearance] setTintColor:[UIColor yellowColor]]`.

## 2.15.0
No backward incompatible changes.

## 2.14.0
#### Removed Document Type USSS
The document type for US social security card (USSS) was removed.

#### Default Settings
The default value for [`enableExtraction`](https://jumio.github.io/mobile-sdk-ios/DocumentVerification/Classes/DocumentVerificationConfiguration.html#/c:objc(cs)DocumentVerificationConfiguration(py)enableExtraction) was changed to `YES`. Please make sure that it is explicitly set to NO in case a scan without extraction should be performed.

## 2.13.0

#### Changes in Localizable-DocumentVerification.strings
- In addition to English, strings are now translated to Chinese (Simplified), Dutch, French, German and Spanish. Each .strings file can now be found in the specific *.lproj folders.*
- Minor adaptions in the english version for the help view headline in regards to the new languages supported for localisation.

## 2.12.0

#### Additional Information Property Removed
Property `additionalInformation` has been removed.

## 2.11.0

#### New Error Codes
Instead of `NSError` objects we now return `DocumentVerificationError` in `documentVerificationViewController:didFinishWithError:`.

Please note, that `code` now is a NSString.
Read more detailed information on this in the [Error Section](integration_document-verification.md#error)

## 2.10.1
No backward incompatible changes.

## 2.10.0

#### Changed Handling of Frameworks to Use a Single Artifact Instead of Two
The framework binaries are available with support for device and simulator architecture. Make sure to remove the simulator architecture from our frameworks for app submissions to the AppStore, as it would cause a rejection by Apple. Read more detailed information on this in our [Manual integration](/README.md#manual) section.

#### Moved Podspec File to Github
The Jumio specific source in your Podfile is no longer needed. From now on, `JumioMobileSDK` is the only pod available. `JumioMobileSDK-FAT` is not offered anymore.

#### Exception Handling in Swift
For initialization of DocumentVerificationViewController in Swift, you need to catch the underlying exception and translate it into an `NSError` instance. Whenever an exception is thrown, the `DocumentVerificationViewController` instance will be nil and the SDK is not usable. See our [sample implementation](/sample/SampleSwift/DocumentVerificationStartViewController.swift) on how this is applied.

## 2.9.2
No backward incompatible changes.

## 2.9.1
No backward incompatible changes.

## 2.9.0
No backward incompatible changes.

## 2.8.1
No backward incompatible changes.

## 2.8.0
No backward incompatible changes.

## 2.7.0
#### Product Rebranding
Please note that the Multi-Document product has been rebranded to Document Verification. This applies to all public classes, methods and Localizable string keys.

## 2.5.0
No backward incompatible changes.

## 2.4.0
No backward incompatible changes.

## 2.3.1
No backward incompatible changes.

## 2.3.0
No backward incompatible changes.

## 2.2.0
No backward incompatible changes.

## 2.1.0
No backward incompatible changes.
