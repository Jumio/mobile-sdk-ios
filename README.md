![Jumio](docs/images/jumio_feature_graphic.png)

# Table of Content
- [Release notes](#release-notes)
- [Basic Setup](#basic-setup)
- [Get started](#get-started)
- [Support](#support)

# Release notes
Applies to all products.

#### Additions
* iOS 11 support

# Basic Setup

## General Requirements
The minimum requirements for the SDK are:
- iOS 8.0 and higher
- Internet connection

The following architectures are supported in the SDK:
- armv7 and arm64 for devices
- x86_64 for iOS simulator

## App thinning and size matters
The iOS 9 feature app thinning (app slicing, bitcode and on-demand resources) is supported within the SDK. For app slicing, the image resources are moved to an xcassets collection. For Fastfill & Netverify, some resource files (e.g. images) are being loaded on demand.

## Permissions
The app’s Info.plist must contain an `NSCameraUsageDescription` key with a string value explaining to the user how the app uses this data. Its value can look like this: *“This will allow <your-app-name> to take photos of your credentials."*

## Integration
Check the Xcode sample project to learn the most common use. Make sure to use the device only frameworks for app submissions to the AppStore.

### Cocoapods
Jumio supports cocoapods as dependency management tool for easy integration of the SDK.

Add our private repository as source to your Podfile and state the use_frameworks! command:
```
source 'http://mobile-sdk.jumio.com/distribution.git'
use_frameworks!
```

Update your local clone of the specs repo to ensure you are using the latest podspec files:
```
pod repo update
```

Choose the pod according to the product you use and suiting your configuration.
```
pod 'JumioMobileSDK' # If you use BAM Checkout along Netverify in your app. Frameworks supporting device architectures only.

pod 'JumioMobileSDK/BAMCheckout' # Specify BAMCheckout as subspec to only use the BAM Checkout part of the Jumio Mobile SDK
pod 'JumioMobileSDK/Netverify' # Specify Netverify as subspec to only use the Netverify part of the Jumio Mobile SDK

pod 'JumioMobileSDK-FAT' # For development purposes, use the frameworks with device and simulator support (also supports subspecs)
```

### Manual
The Jumio Mobile SDK consists of several dynamic frameworks. Add specific frameworks to your Xcode project, depending on which product you use.

The following table shows which frameworks have to be added:

| Product | JumioCore | BAMCheckout | Netverify | MicroBlink | UMoove |
| :--- | :---: | :---: | :---: | :---: | :---: |
| Fastfill & Netverify | x |  | x | x | x |
| Document Verification | x |  | x |  |  |
| BAM Checkout credit card scanning | x | x |  |  |  |
| BAM Checkout credit card + ID scanning | x | x | x | x | x |

In case you use a combination of these products, make sure to add frameworks only once to your app and that those frameworks are linked and embedded in your Xcode project.
Two packages are available with frameworks for device only and frameworks with device and simulator support. Make sure to use the device only frameworks for app submissions to the AppStore, as using the other package will cause a rejection by Apple.

Add the following linker flags to your Xcode Build Settings:<br/>
__Note:__ Added automatically if using CocoaPods.
- "-lc++"
- "-ObjC" (recommended) or -all_load

Make sure that the following Xcode build settings in your app are set accordingly:

| Setting | Value |
| :--- | :---: |
| Link Frameworks Automatically | YES |
| Always Embed Swift Standard Libraries | YES |

## Localization
All label texts and button titles can be changed and localized using the `Localizable-<YOUR_PRODUCT>.strings` file. Just adapt the values to your required language and add it to your app project. This way, when upgrading our SDK to a newer version, your localization file won't be overwritten. Make sure, that the content of your localization file is up to date after an SDK update.
Note: If using CocoaPods, the original file is located under `/Pods/JumioMobileSDK`.

With accessibility support, visually impaired users can now enable __VoiceOver__ or change the __font size__ on their device. VoiceOver uses existing localization values, just some new strings were added to the localization file.

# Get started
- [Integration Netverify & Fastfill](docs/integration_netverify-fastfill.md)
- [Integration Document Verification](docs/integration_document-verification.md)
- [Integration BAM Checkout](docs/integration_bam-checkout.md)

# Support

## Previous version
The previous release version 2.7.0 of the Jumio Mobile SDK is supported until 2017-11-29.

In case the support period is expired, no bug fixes are provided anymore (typically fixed in the upcoming versions). The SDK will keep functioning (until further notice).

## Contact
If you have any questions regarding our implementation guide please contact Jumio Customer Service at support@jumio.com or https://support.jumio.com. The Jumio online helpdesk contains a wealth of information regarding our service including demo videos, product descriptions, FAQs and other things that may help to get you started with Jumio. Check it out at: https://support.jumio.com.

## Two-factor Authentication
If you want to enable two-factor authentication for your Jumio merchant backend please contact us at https://support.jumio.com. Once enabled, users will be guided through the setup upon their first login to obtain a security code using the "Google Authenticator" app.

## Copyright

&copy; Jumio Corp. 268 Lambert Avenue, Palo Alto, CA 94306
