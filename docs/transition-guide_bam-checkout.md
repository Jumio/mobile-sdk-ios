![BAM Checkout](images/bam_checkout.jpg)

# Transition guide for BAM Checkout
This section only covers the breaking technical changes that should be considered when updating from the previous version.

⚠️ When updating your SDK version, __all__ changes/updates made in in the meantime have to be taken into account and applied if necessary. If you're updating from SDK version __3.7.1__ to __3.9.3__, the changes outlined in __3.7.2, 3.8.0, 3.9.0__ and all subsequent versions are __still relevant__.

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
Localization file has been moved from the main directory to `/Localizations`. If you are using manual integration or Carthage you will find the localization file under `JumioMobileSDK-3.7.0/Localizations`, in case you are using Cocoapods you can copy it from `/Pods/JumioMobileSDK-3.7.0/Localizations`

## 3.6.0
No backward incompatible changes.

## 3.5.0
No backward incompatible changes.

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

#### Changes to the Public API
`- (BOOL)updateConfiguration:(BAMCheckoutConfiguration*)configuration;` has been removed.

## 3.1.2
No backward incompatible changes.

## 3.1.1
No backward incompatible changes.

## 3.1.0

#### NavigationBar Customization
`UINavigationBar+BAMCheckoutAppearance.h` was renamed to `UINavigationBar+JumioAppearance.h` and moved to JumioCore.framework</br>
`BAMCheckoutNavigationBarTitleImageView` was renamed to [`JumioNavigationBarTitleImageView`](https://jumio.github.io/mobile-sdk-ios/BAMCheckout/Classes/JumioNavigationBarTitleImageView.html) and moved to JumioCore.framework


#### Changes to Device Information
`JMDeviceInfo` class has been renamed to `JumioDeviceInfo`

## 3.0.0

#### Changes to the Public API
`merchantApiToken` has been renamed to `apiToken`</br>
`merchantApiSecret` has been renamed to `apiSecret`</br>
`merchantReportingCriteria` has been renamed to `reportingCriteria`</br>
`sdkVersion` was changed from instance to class function

#### Changes to Visual Customization
 The protocol `BAMCheckoutAppearance` has been replaced with `JumioAppearance`. </br>
 Example: `[[UINavigationBar bamCheckoutAppearance] setTintColor:[UIColor yellowColor]]` has been changed to `[[UINavigationBar jumioAppearance] setTintColor:[UIColor yellowColor]]`.

## 2.15.0
No backward incompatible changes.

## 2.14.0
No backward incompatible changes.

## 2.13.0
BAMCheckoutCreditCardTypeStarbucks removed.

#### Enums
All enums were replaced by NS_ENUM macros to have better Swift support. When using Swift this Version will break when using [`BAMCheckoutCreditCardType`](https://jumio.github.io/mobile-sdk-ios/BAMCheckout/Enums/BAMCheckoutCreditCardType.html) or [`BAMCheckoutCreditCardTypes`](https://jumio.github.io/mobile-sdk-ios/BAMCheckout/Enums/BAMCheckoutCreditCardTypes.html).

## 2.12.0
No backward incompatible changes.

## 2.11.0
No backward incompatible changes.

## 2.10.1
No backward incompatible changes.

## 2.10.0

#### Changed Handling of Frameworks to Use a Single Artifact Instead of Two
The framework binaries are available with support for device and simulator architecture. Make sure to remove the simulator architecture from our frameworks for app submissions to the AppStore, as it would cause a rejection by Apple. Read more detailed information on this in our [Manual integration](/README.md#manual) section.

#### Moved Podspec File to Github
The Jumio specific source in your Podfile is no longer needed. From now on, `JumioMobileSDK` is the only pod available. `JumioMobileSDK-FAT` is not offered anymore.

#### Exception Handling in Swift
For initialization of BAMCheckoutViewController in Swift, you need to catch the underlying exception and translate it into a `NSError` instance. Whenever an exception is thrown, the `BAMCheckoutViewController` instance will be nil and the SDK is not usable. See our [sample implementation](/sample/SampleSwift/BAMCheckoutStartViewController.swift) on how this is applied.

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
Please note that the Netswipe product has been rebranded to BAMCheckout. This applies to all public classes, methods and Localizable string keys.

#### Adyen Support Removal
Adyen support has been removed, this includes the removal of  the encryptedAdyenString property from the BAMCheckoutConfiguration and BAMCheckoutCardInformation object.

## 2.5.0
No backward incompatible changes.

## 2.4.0
#### Changes in Localizable-Netswipe.strings
Please note that several strings have been added with introducing accessibility support, while some others have been removed.

## 2.3.1
No backward incompatible changes.

## 2.3.0
#### New Parameter for Scan Reference in Error Delegate
Added scanReference to delegate didCancelWithError.
```
- (void) bamCheckoutViewController: (BAMCheckoutViewController *) controller didCancelWithError:(NSError *) error scanReference:(NSString *) scanReference;
```

#### Removed Name Match Feature
Name matching by comparing a provided name with the extracted name from a document was removed. The property _name_ in BAMCheckoutViewController class is deleted, as well as the boolean _nameMatch_ and integer _nameDistance_ in BAMCheckoutCardInformation class.

## 2.2.0
#### Changes in Localizable-BAMCheckout.strings
Please note that several strings were added or modified in regards to the new design.

## 2.1.0
#### Exceptions at Initialization
An exception is thrown in case mandatory parameters in the `BAMCheckoutConfiguration` object are invalid.

#### Removed Parameters
The boolean parameter `manualEntryEnabled` has been removed from `BAMCheckoutConfig` class, also its corresponding parameter `cardNumberManuallyEntered` from `BAMCheckoutCardInformation`.

#### Changes in Localizable-BAMCheckout.strings
Please note that several strings were removed.
