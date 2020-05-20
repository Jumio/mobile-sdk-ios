![Jumio](docs/images/jumio_feature_graphic.jpg)

![Version](https://img.shields.io/github/v/release/Jumio/Mobile-SDK-IOS?style=flat)
![License](https://img.shields.io/cocoapods/l/JumioMobileSDK.svg?style=flat)
![Platform](https://img.shields.io/cocoapods/p/JumioMobileSDK.svg?style=flat)
[![Pod Version](https://img.shields.io/cocoapods/v/JumioMobileSDK.svg?style=flat)](https://cocoapods.org/pods/JumioMobileSDK)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![Swift 3.0-5.x](http://img.shields.io/badge/Swift-3.x,%204.x%20&%205.x-orange.svg?style=flat)](https://swift.org/)

# Table of Content
- [Release notes](#release-notes)
- [Basic Setup](#basic-setup)
- [Get started](#get-started)
- [Support](#support)
- [FAQ](docs/integration_faq.md)


# Release notes
### SDK version: 3.6.0

#### Changes
* Support for 5 new languages (Czech, Greek, Hungarian, Polish, Romanian) [Netverify/Fastfill, Authentication, Document Verification]
* Added support for right-to-left languages [Netverify/Fastfill, Authentication, Document Verification]
* Provide access to document guidance animation [Netverify Custom UI]
* Added Carthage as an additional dependency manager [Netverify/Fastfill, Authentication, Document Verification, BAM Checkout]
* Adjusted handling of document types which don’t support plastic documents [Netverify]

#### Fixes
* Improved accessibility handling [Netverify/Fastfill, Authentication, Document Verification]
* Various smaller bug fixes/improvements [Netverify/Fastfill, Authentication, Document Verification]

# Basic Setup

## General Requirements
The minimum requirements for the SDK are:
- iOS 10.0 and higher
- Internet connection

The following architectures are supported in the SDK:
- armv7 and arm64 for devices
- x86_64 for iOS simulator

## App thinning and size matters
App thinning (app slicing, bitcode and on-demand resources) is supported within the SDK. For app slicing, the image resources are placed within a xcassets collection. For Fastfill & Netverify, some resource files (e.g. images) are loaded on demand.

In case you experience a build error when building your app in Debug configuration and aim to run it on a device, we advise to temporarily disable the build setting "Enable Bitcode" in your Xcode project.

## Permissions
The app’s Info.plist must contain the `NSCameraUsageDescription` key with a string value explaining to the user how the app uses this data. Example: *“This will allow <your-app-name> to take photos of your credentials."*

## Integration
Check the Xcode sample project to learn the most common use. Make sure to use the device only frameworks for app submissions to the AppStore. Read more detailed information on this here: [Manual integration](/README.md#manually)

### via Cocoapods
Jumio supports CocoaPods as dependency management tool for easy integration of the SDK.


Update your local clone of the specs repo in Terminal to ensure that you are using the latest podspec files:
```
pod repo update
```

Adapt your Podfile and add the pod according to the product(s) you use. Check the following example how a Podfile could look like:
```
source 'https://github.com/CocoaPods/Specs.git'

use_frameworks! # Required for proper framework handling

pod 'JumioMobileSDK', '~>3.6.0' # Use Netverify, Authentication, Document Verification and BAM Checkout together in your app

pod 'JumioMobileSDK/Netverify', '~>3.6.0' # Use full Netverify and Authentication functionality
pod 'JumioMobileSDK/NetverifyBase', '~>3.6.0' # For Fastfill, Netverify basic functionality
pod 'JumioMobileSDK/NetverifyBarcode', '~>3.6.0' # For Fastfill, Netverify functionality with barcode extraction
pod 'JumioMobileSDK/NetverifyFace', '~>3.6.0' # For Fastfill, Netverify functionality with identity verification, Authentication

pod 'JumioMobileSDK/DocumentVerification', '~>3.6.0' # Use Document Verification functionality

pod 'JumioMobileSDK/BAMCheckout', '~>3.6.0' # Use BAM Checkout functionality
```

Install the pod to your project via Terminal:
```
pod install
```
### via Carthage
Jumio supports Carthage as dependency management tool for easy integration of the SDK.

Adapt you Cartfile and add the JumioMobileSDK dependency. Check the following example how a Cartfile could look like:

```
binary "https://raw.githubusercontent.com/Jumio/mobile-sdk-ios/blob/master/Carthage/JumioMobileSDK.json" == 3.6.0
```

Update you Carthage dependencies via Terminal:
```
carthage update
```

### Manually

Download our frameworks manually via [ios-jumio-mobile-sdk-3.6.0.zip](https://mobile-sdk.jumio.com/com/jumio/ios/jumio-mobile-sdk/3.6.0/ios-jumio-mobile-sdk-3.6.0.zip).

__Note:__ Our sample project on GitHub contains the sample implementation without our frameworks. The project file contains a “Run Script Phase” which downloads our frameworks automatically during build time.

The Jumio Mobile SDK consists of several dynamic frameworks. Add specific frameworks to your Xcode project, depending on which product you use.

Please see [Strip unused frameworks](/docs/integration_faq.md#strip-unused-frameworks) for more information.

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
All label texts and button titles can be changed and localized using the `Localizable-<YOUR_PRODUCT>.strings` file. Just adapt the values to your required language, add it to your app or framework project and mark it as Localizable. This way, when upgrading our SDK to a newer version your localization file won't be overwritten. Make sure, that the content of this localization file is up to date after an SDK update.
Note: If using CocoaPods, the original file is located under `/Pods/JumioMobileSDK`.

For our products Netverify & Fastfill, Authentication & Document Verification we support following languages for your convenience:
* Chinese (Simplified)
* Czech
* Dutch
* English
* French
* German
* Greek
* Hungarian
* Italian
* Polish
* Portuguese
* Romanian
* Spanish

Please check out our sample project to see how to use the strings files in your app.

Our SDK supports Accessibility. Visually impaired users can enable __VoiceOver__ or increased __text size__ on their device. VoiceOver uses separate values in the localization file, which can be customised.

# Get started
- [Integration Netverify & Fastfill](docs/integration_netverify-fastfill.md)
- [Integration Authentication](docs/integration_authentication.md)
- [Integration Document Verification](docs/integration_document-verification.md)
- [Integration BAM Checkout](docs/integration_bam-checkout.md)

# Support

## Previous version
The previous release version 3.5.0 of the Jumio Mobile SDK is supported until 2020-08-04.

In case the support period is expired, no bug fixes and technical support are provided anymore (bugs are typically fixed in the upcoming versions).
Older SDK versions will keep functioning with our server until further notice, but we highly recommend to always update to the latest version to benefit from SDK improvements and bug fixes.

## Contact
If you have any questions regarding our implementation guide please contact Jumio Customer Service at support@jumio.com or https://support.jumio.com. The Jumio online helpdesk contains a wealth of information regarding our service including demo videos, product descriptions, FAQs and other things that may help to get you started with Jumio. Check it out at: https://support.jumio.com.

## Two-factor Authentication
If you want to enable two-factor authentication for your Jumio merchant backend please contact us at https://support.jumio.com. Once enabled, users will be guided through the setup upon their first login to obtain a security code using the "Google Authenticator" app.

## Licenses
The software contains third-party open source software. For more information, please see [licenses](https://github.com/Jumio/mobile-sdk-ios/tree/master/licenses).

This software is based in part on the work of the Independent JPEG Group.

## Copyright
&copy; Jumio Corporation, 395 Page Mill Road, Suite 150, Palo Alto, CA 94306

The source code and software available on this website (“Software”) is provided by Jumio Corp. or its affiliated group companies (“Jumio”) "as is” and any express or implied warranties, including, but not limited to, the implied warranties of merchantability and fitness for a particular purpose are disclaimed. In no event shall Jumio be liable for any direct, indirect, incidental, special, exemplary, or consequential damages (including but not limited to procurement of substitute goods or services, loss of use, data, profits, or business interruption) however caused and on any theory of liability, whether in contract, strict liability, or tort (including negligence or otherwise) arising in any way out of the use of this Software, even if advised of the possibility of such damage.
In any case, your use of this Software is subject to the terms and conditions that apply to your contractual relationship with Jumio. As regards Jumio’s privacy practices, please see our privacy notice available here: [Privacy Policy](https://www.jumio.com/legal-information/privacy-policy/).
