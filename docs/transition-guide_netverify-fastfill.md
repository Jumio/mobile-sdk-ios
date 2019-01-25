![Fastfill & Netverify](images/netverify.png)

# Transition guide for Fastfill & Netverify

This section only covers the breaking technical changes that should be considered when updating from the previous version.

## 2.15.0

#### New frameworks NetverifyFace and ZoomAuthenticationHybrid
When using Identity Verification, make sure to link NetverifyFace.framework and ZoomAuthenticationHybrid.framework to your app project. There is no new public API for you to consume, nor any implementation adaptions required.
Please also make sure that the Umoove.framework from our previous releases is removed from your app.

#### Additions in visual customization
Enhanced customization options to colorize some UI elements on the 3D face liveness screen, see [`NetverifyScanOverlay`](http://jumio.github.io/mobile-sdk-ios/Netverify/Classes/NetverifyScanOverlayView.html) class for the new options.

#### Localizable Strings
Several additions and changes, mostly in regards to the new 3D face liveness capturing functionality.

## 2.14.0

#### Default Settings
The default values for [`requireVerification`](http://jumio.github.io/mobile-sdk-ios/Netverify/Classes/NetverifyConfiguration.html#/c:objc(cs)NetverifyConfiguration(py)requireVerification) and [`requireFaceMatch`](http://jumio.github.io/mobile-sdk-ios/Netverify/Classes/NetverifyConfiguration.html#/c:objc(cs)NetverifyConfiguration(py)requireFaceMatch) were changed to `YES`. Please make sure that they are explicitly set to NO in case a scan in Fastfill mode should be performed. 

#### Enums
[`NetverifyDocumentType`](http://jumio.github.io/mobile-sdk-ios/Netverify/Enums/NetverifyDocumentType.html) was changed from NS_ENUM to NS_OPTIONS. 

## 2.13.0

#### Enums
All enums were replaced by NS_ENUM to have better Swift support. When using Swift this Version will break when using [`NetverifyDocumentType`](http://jumio.github.io/mobile-sdk-ios/Netverify/Enums/NetverifyDocumentType.html), [`NetverifyDocumentVariant`](http://jumio.github.io/mobile-sdk-ios/Netverify/Enums/NetverifyDocumentVariant.html), [`NetverifyExtractionMethod`](http://jumio.github.io/mobile-sdk-ios/Netverify/Enums/NetverifyExtractionMethod.html), [`NetverifyGender`](http://jumio.github.io/mobile-sdk-ios/Netverify/Enums/NetverifyGender.html), [`NetverifyMRZFormat`](http://jumio.github.io/mobile-sdk-ios/Netverify/Enums/NetverifyMRZFormat.html), [`NetverifyScanMode`](http://jumio.github.io/mobile-sdk-ios/Netverify/Enums/NetverifyScanMode.html) or [`NetverifyScanSide`](http://jumio.github.io/mobile-sdk-ios/Netverify/Enums/NetverifyScanSide.html).

#### Changes in Localizable-Netverify.strings
changed values in regards to error texts

#### Cleanup of our SDK
The method `destroy` was introduced to properly clean up our SDK. Call this method to destroy the NetverifyViewController instance, before you set it to nil. When re-initializing [`NetverifyViewController`](http://jumio.github.io/mobile-sdk-ios/Netverify/Classes/NetverifyViewController.html) or [`NetverifyUIController`](http://jumio.github.io/mobile-sdk-ios/Netverify/Classes/NetverifyUIController.html) make sure you've called  `destroy` in advance otherwise an exception will be raised during initializing.

## 2.12.0

#### Localizable Strings
In addition to English, strings are now translated to Chinese (Simplified), Dutch, French, German and Spanish. Each .strings file can now be found in the specific *.lproj folders.

#### Additional information property removed
Property `additionalInformation` has been removed.

## 2.11.0

#### New error scheme
Instead of `NSError` objects we now return `NetverifyError` in `netverifyViewController:didFinishInitializingWithError:` and `netverifyViewController:didCancelWithError:scanReference:`.

Please note, that `code` now is a NSString.
Read more detailed information on this in [Retrieving information](/docs/integration_netverify-fastfill.md#retrieving-information)

#### Changes in Localizable-Netverify.strings
Added values in regards to legal masking.

## 2.10.1
#### Changes in Localizable-Netverify.strings
Added one value in regards to legal masking.

## 2.10.0

#### Changed handling of frameworks to use a single artifact instead of two
The framework binaries are available with support for device and simulator architecture. Make sure to remove the simulator architecture from our frameworks for app submissions to the AppStore, as it would cause a rejection by Apple. Read more detailed information on this in our [Manual integration](/README.md#manual) section.

#### Moved podspec file to Github
The Jumio specific source in your Podfile is no longer needed. From now on, `JumioMobileSDK` is the only pod available. `JumioMobileSDK-FAT` is not offered anymore.

#### Exception handling in Swift
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

#### Additions in visual customization
Enhanced customization options to colorize the scan options header and buttons.
Class `NetverifyScanOptionsButton` was replaced by `NetverifyDocumentSelectionButton` and `NetverifyDocumentSelectionHeaderView`.

## 2.8.1
No backward incompatible changes.

## 2.8.0

#### Additions in visual customization
Added customization options to colorize the scan overlay screens.

#### Changes in Localizable-Netverify.strings
Removed three values in regards to a compliance hint

## 2.7.0

#### Changes in Localizable-Netverify.strings
Several additions and changes, mostly in regards to the new liveness screen.

## 2.5.0

#### Changes in visual customization
Removed _NetverifyCameraFlashButton_ as the icons to switch camera and toggle flash were moved to the navigation bar.

#### Changes in Localizable-Netverify.strings
Multiple additions and changes in regards to the new guidance / help screen.

## 2.4.0
No backward incompatible changes.

## 2.3.1
No backward incompatible changes.

## 2.3.0
#### Renamed enum types
Renamed the following enum types:
 * `NVDocumentVariant` to `NetverifyDocumentVariant`
 * `NVGender` to `NetverifyGender`
 * `NVMRZFormat` to `NetverifyMRZFormat`
 * `NVExtractionMethod` to `NetverifyExtractionMethod`.

#### Removed name match feature
Name matching by comparing a provided name with the extracted name from a document was removed. The property _name_ in BAMCheckoutViewController class is deleted, as well as the boolean _nameMatch_ and integer _nameDistance_ in BAMCheckoutCardInformation class.

## 2.2.0
#### Removed liveness detection result
Parameter `livenessDetected` has been removed from `NetverifyDocumentData`.

## 2.1.0
#### Exceptions at initialization
An exception is thrown in case mandatory parameters in the `NetverifyConfiguration` object are invalid.

#### Changes in Localizable-Netverify.strings
Removed one string in regards to scanning not possible.
