![Fastfill & Netverify](images/authentication.png)

# Transition guide for Authentication SDK

This section only covers the breaking technical changes that should be considered when updating from the previous version.

## 3.1.0

#### NavigationBar customization
`UINavigationBar+AuthenticationAppearance.h` was renamed to `UINavigationBar+JumioAppearance.h` and moved to JumioCore.framework</br>
`AuthenticationNavigationBarTitleImageView` was renamed to [`JumioNavigationBarTitleImageView`](http://jumio.github.io/mobile-sdk-ios/NetverifyFace/Classes/JumioNavigationBarTitleImageView.html) and moved to JumioCore.framework

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
