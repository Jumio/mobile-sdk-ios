![Fastfill & Netverify](images/authentication.jpg)

# Transition guide for Authentication SDK

This section only covers the breaking technical changes that should be considered when updating from the previous version.

## 3.7.0

#### Localization files
Localization files have been moved from the main directory to `/Localizations`. If you are using manual integration or Carthage you will find the localization files under `JumioMobileSDK-3.7.0/Localizations`, in case you are using Cocoapods you can copy them from `/Pods/JumioMobileSDK-3.7.0/Localizations`

## 3.6.0

#### Localization keys 
The following keys are no more uppercased 

 `auth.scan-help-view.liveness-help.button-continue.title`, 
 `auth.error-view.button.retry.title` and 
 `auth.error-view.button.cancel.title` 
 
## 3.5.0

#### Error codes
Error code D (Wrong API credentials used, retry impossible) has been removed

#### Dark mode
Added additional theme to support dark mode. Set [`enableDarkMode`](https://jumio.github.io/mobile-sdk-ios/NetverifyFace/Classes/JumioBaseView.html#/c:objc(cs)JumioBaseView(py)enableDarkMode) to `true` to change blur style and the standard foreground color. 

## 3.4.2
* A new delegate `authenticationScanViewController:shouldRequireUserConsentWithURL:` was added to [`AuthenticationScanViewControllerDelegate`](https://jumio.github.io/mobile-sdk-ios/NetverifyFace/Protocols/AuthenticationScanViewControllerDelegate.html)
* A new method `userConsentGiven:` was added to [`AuthenticationScanViewController`](https://jumio.github.io/mobile-sdk-ios/NetverifyFace/Classes/AuthenticationScanViewController.html)

## 3.4.1
No backward incompatible changes.

## 3.4.0
No backward incompatible changes.

## 3.3.1
No backward incompatible changes.

## 3.3.0
No backward incompatible changes.

## 3.2.0

#### Custom-UI handling
`authenticationScanViewController:shouldDisplayHelpWithText:animationView:` was extended to [`authenticationScanViewController:shouldDisplayHelpWithText:animationView:forReason:`](https://jumio.github.io/mobile-sdk-ios/NetverifyFace/Protocols/AuthenticationScanViewControllerDelegate.html#/c:objc(pl)AuthenticationScanViewControllerDelegate(im)authenticationScanViewController:shouldDisplayHelpWithText:animationView:forReason:) to return the `JumioZoomRetryReason`

## 3.1.2
No backward incompatible changes.

## 3.1.1
No backward incompatible changes.

## 3.1.0

#### NavigationBar customization
`UINavigationBar+AuthenticationAppearance.h` was renamed to `UINavigationBar+JumioAppearance.h` and moved to JumioCore.framework</br>
`AuthenticationNavigationBarTitleImageView` was renamed to [`JumioNavigationBarTitleImageView`](https://jumio.github.io/mobile-sdk-ios/NetverifyFace/Classes/JumioNavigationBarTitleImageView.html) and moved to JumioCore.framework

#### Custom-UI handling
Please see [Custom-UI for Authentication](https://github.com/Jumio/mobile-sdk-ios/blob/master/docs/integration_authentication.md#custom-ui) 
`authenticationScanViewControllerDidStartBiometricAnalysis:` - display loading activity while biometric data is being analysed
`authenticationScanViewController:shouldDisplayHelpWithText:animationView:` - Display a help text and animated view that is provided based on the problematic situation the user was facing and call `retryScan` on the `authenticationScanViewController` on user confirmation.
`authenticationScanViewController:didDetermineRecoverableError:` - Display the error message to the user and call `retryAfterError` on the `authenticationScanViewController` on user confirmation.

`authenticationController:didFinishInitializingScanViewController:` was adapted to return a `AuthenticationScanViewController` instance instead UIViewController.

`AuthenticationScanViewController` provides a property `customOverlayLayer` to add subviews on top as well as mechanism to retry in help/error state or cancel.

#### Changes to device information
`JMDeviceInfo` class has been renamed to `JumioDeviceInfo`

## 3.0.0
Introduction of the Authentication product
https://github.com/Jumio/mobile-sdk-ios/blob/master/docs/integration_authentication.md#callback
