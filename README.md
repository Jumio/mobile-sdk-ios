![Jumio](docs/images/jumio_feature_graphic.png)

# Table of Content
- [Release notes](#release-notes)
- [Basic Setup](#basic-setup)
- [Get started](#get-started)
- [Support](#support)


# Release notes
All changes apply to Netverify and Fastfill

SDK version: 2.11.0

#### Changes
* Added new Custom UI functionality
* Added support for legal masking in Germany
* Added support for new gender code X  (gender-unspecified) on MRZ documents
* Updated error code schema 

#### Fixes
* Fixed handling for British Columbia driving licenses
* Various smaller bug fixes/improvements in all products

__Version 2.10.0 and above contain a security fix. We advice to update immediately, latest until May 1, 2018.__

# Basic Setup

## General Requirements
The minimum requirements for the SDK are:
- iOS 9.0 and higher
- Internet connection

The following architectures are supported in the SDK:
- armv7 and arm64 for devices
- x86_64 for iOS simulator

## App thinning and size matters
The iOS 9 feature app thinning (app slicing, bitcode and on-demand resources) is supported within the SDK. For app slicing, the image resources are placed within a xcassets collection. For Fastfill & Netverify, some resource files (e.g. images) are  loaded on demand.

In case you experience a build error when building your app in Debug configuration and aim to run it on a device, we advise to temporarily disable the build setting "Enable Bitcode" in your Xcode project.

## Permissions
The app’s Info.plist must contain the `NSCameraUsageDescription` key with a string value explaining to the user how the app uses this data. Example: *“This will allow <your-app-name> to take photos of your credentials."*

## Integration
Check the Xcode sample project to learn the most common use. Make sure to use the device only frameworks for app submissions to the AppStore. Read more detailed information on this here: [Manual integration](/README.md#manual)

### via Cocoapods
Jumio supports cocoapods as dependency management tool for easy integration of the SDK.


Update your local clone of the specs repo in Terminal to ensure that you are using the latest podspec files:
```
pod repo update
```

Adapt your Podfile and add the pod according to the product(s) you use. Check the following example how a Podfile could look like:
```
source 'https://github.com/CocoaPods/Specs.git'

use_frameworks! # Required for proper framework handling

pod 'JumioMobileSDK', '~>2.11' # If you use BAM Checkout along Netverify in your app. Frameworks supporting device architectures only.

pod 'JumioMobileSDK/Netverify', '~>2.11' # Specify Netverify as subspec to only use Netverify, Fastfill or Document Verification
pod 'JumioMobileSDK/BAMCheckout', '~>2.11' # Specify BAMCheckout as subspec to only use BAM Checkout
```

Install the pod to your project via Terminal:
```
pod install
```

### Manually
The Jumio Mobile SDK consists of several dynamic frameworks. Add specific frameworks to your Xcode project, depending on which product you use.

The following table shows which frameworks have to be added:

| Product | Size | JumioCore | BAMCheckout | Netverify | MicroBlink | UMoove |
| :--- | :---: | :---: | :---: | :---: | :---: | :---: |
| Fastfill & Netverify | 17 MB | x |  | x | x | x |
| Document Verification | 7.5 MB | x |  | x |  |  |
| BAM Checkout credit card scanning | 7 MB | x | x |  |  |  |
| BAM Checkout credit card<br/>+ ID scanning | 23 MB | x | x | x | x | x |

In case you use a combination of these products, make sure to add frameworks only once to your app and that those frameworks are linked and embedded in your Xcode project. For Document Verification, the frameworks `MicroBlink` and `UMoove` can be removed but this requires Bitcode to be disabled in your app.

The size values in the table above depict the decompressed install size required on a device. It can be compared with the Estimated App Store files size. The size value can vary by a few percent, depending on the actual device used.

The framework binaries are available with support for device and simulator architecture. Make sure to remove the simulator architecture from our frameworks for app submissions to the AppStore. If this step is not performed, your submission will be rejection by Apple. Add the following code snippet as run script build phase to your app project and ensure that it is executed after the frameworks are embedded. Please see the required setup in our sample project.

__Note:__ The simulator architecture is automatically removed if using cocoapods via "[CP] Embed Pods Frameworks" build phase.
```shell
if [[ "$CONFIGURATION" == "Release" ]]; then
  $PROJECT_DIR/remove-simulator-architecture.sh
fi
```
Code snippet source: https://stackoverflow.com/questions/30547283/submit-to-app-store-issues-unsupported-architecture-x86

Add the following linker flags to your Xcode Build Settings:<br/>
__Note:__ Added automatically if using CocoaPods.
- "-lc++"
- "-ObjC" (recommended) or -all_load

Make sure that the following Xcode build settings in your app are set accordingly:

| Setting | Value |
| :--- | :---: |
| Link Frameworks Automatically | YES |

## Localization
All label texts and button titles can be changed and localized using the `Localizable-<YOUR_PRODUCT>.strings` file. Just adapt the values to your required language, add it to your app project and mark it as Localizable. This way, when upgrading our SDK to a newer version your localization file won't be overwritten. Make sure, that the content of this localization file is up to date after an SDK update.
Note: If using CocoaPods, the original file is located under `/Pods/JumioMobileSDK`.

Our SDK supports Accessibility. Visually impaired users can enable __VoiceOver__ or increased __text size__ on their device. VoiceOver uses separate values in the localization file, which can be customised.

# Get started
- [Integration Netverify & Fastfill](docs/integration_netverify-fastfill.md)
- [Integration Document Verification](docs/integration_document-verification.md)
- [Integration BAM Checkout](docs/integration_bam-checkout.md)

# Support

## Previous version
The previous release version 2.11.0 of the Jumio Mobile SDK is supported until 2018-07-04.

In case the support period is expired, no bug fixes are provided anymore (typically fixed in the upcoming versions). The SDK will keep functioning (until further notice).

## Contact
If you have any questions regarding our implementation guide please contact Jumio Customer Service at support@jumio.com or https://support.jumio.com. The Jumio online helpdesk contains a wealth of information regarding our service including demo videos, product descriptions, FAQs and other things that may help to get you started with Jumio. Check it out at: https://support.jumio.com.

## Two-factor Authentication
If you want to enable two-factor authentication for your Jumio merchant backend please contact us at https://support.jumio.com. Once enabled, users will be guided through the setup upon their first login to obtain a security code using the "Google Authenticator" app.

## Copyright

&copy; Jumio Corp. 268 Lambert Avenue, Palo Alto, CA 94306
