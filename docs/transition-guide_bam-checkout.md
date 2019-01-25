![BAM Checkout](images/bam_checkout.png)

# Transition guide for BAM Checkout

This section only covers the breaking technical changes that should be considered when updating from the previous version.

## 2.15.0
No backward incompatible changes.

## 2.14.0
No backward incompatible changes.

## 2.13.0
BAMCheckoutCreditCardTypeStarbucks removed.

#### Enums
All enums were replaced by NS_ENUM macros to have better Swift support. When using Swift this Version will break when using [`BAMCheckoutCreditCardType`](http://jumio.github.io/mobile-sdk-ios/BAMCheckout/Enums/BAMCheckoutCreditCardType.html) or [`BAMCheckoutCreditCardTypes`](http://jumio.github.io/mobile-sdk-ios/BAMCheckout/Enums/BAMCheckoutCreditCardTypes.html).

## 2.12.0
No backward incompatible changes.

## 2.11.0
No backward incompatible changes.

## 2.10.1
No backward incompatible changes.

## 2.10.0

#### Changed handling of frameworks to use a single artifact instead of two
The framework binaries are available with support for device and simulator architecture. Make sure to remove the simulator architecture from our frameworks for app submissions to the AppStore, as it would cause a rejection by Apple. Read more detailed information on this in our [Manual integration](/README.md#manual) section.

#### Moved podspec file to Github
The Jumio specific source in your Podfile is no longer needed. From now on, `JumioMobileSDK` is the only pod available. `JumioMobileSDK-FAT` is not offered anymore.

#### Exception handling in Swift
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
#### Product re-rebranding
Please note that the Netswipe product has been re-branded to BAMCheckout. This applies to all public classes, methods and Localizable string keys.

#### Adyen support removal
Adyen support has been removed, this includes the removal of  the encryptedAdyenString property from the BAMCheckoutConfiguration and BAMCheckoutCardInformation object.

## 2.5.0
No backward incompatible changes.

## 2.4.0
#### Changes in Localizable-Netswipe.strings
Please note that several strings have been added with introducing accessibility support, while some others have been removed.

## 2.3.1
No backward incompatible changes.

## 2.3.0
#### New parameter for scan reference in error delegate
Added scanReference to delegate didCancelWithError.
```
- (void) bamCheckoutViewController: (BAMCheckoutViewController *) controller didCancelWithError:(NSError *) error scanReference:(NSString *) scanReference;
```

#### Removed name match feature
Name matching by comparing a provided name with the extracted name from a document was removed. The property _name_ in BAMCheckoutViewController class is deleted, as well as the boolean _nameMatch_ and integer _nameDistance_ in BAMCheckoutCardInformation class.

## 2.2.0
#### Changes in Localizable-BAMCheckout.strings
Please note that several strings were added or modified in regards to the new design.

## 2.1.0
#### Exceptions at initialisation
An exception is thrown in case mandatory parameters in the `BAMCheckoutConfiguration` object are invalid.

#### Removed parameters
The boolean parameter `manualEntryEnabled` has been removed from `BAMCheckoutConfig` class, also its corresponding parameter `cardNumberManuallyEntered` from `BAMCheckoutCardInformation`.

#### Changes in Localizable-BAMCheckout.strings
Please note that several strings were removed.
