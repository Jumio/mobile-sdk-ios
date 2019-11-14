![Jumio](docs/images/jumio_feature_graphic.jpg)

# Table of Content
- [Release notes](#release-notes)
- [Basic Setup](#basic-setup)
- [Get started](#get-started)
- [Support](#support)
- [FAQ](docs/integration_faq.md)


# Release notes
SDK version: 3.4.0

#### Changes
* Support for Colombian ID barcode scanning [Netverify/Fastfill]
* Improved image selection to reduce number of documents which are not fully visible [Netverify]
* Advanced document checks on the back of IDs to increase user conversion [Netverify]
* Full iOS 13 compatibility, solved dark mode UI glitches [Netverify/Fastfill, Authentication, Document Verification, BAM Checkout]
* Deprecated iOS 9 support [Netverify/Fastfill, Authentication, Document Verification, BAM Checkout]

#### Fixes
* Fixed a problem in the callbackURL validation [Netverify, Authentication, Document Verification]
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
Jumio supports cocoapods as dependency management tool for easy integration of the SDK.


Update your local clone of the specs repo in Terminal to ensure that you are using the latest podspec files:
```
pod repo update
```

Adapt your Podfile and add the pod according to the product(s) you use. Check the following example how a Podfile could look like:
```
source 'https://github.com/CocoaPods/Specs.git'

use_frameworks! # Required for proper framework handling

pod 'JumioMobileSDK', '~>3.3.1' # Use Netverify, Authentication, DocumentVerification and BAM Checkout together in your app

pod 'JumioMobileSDK/Netverify', '~>3.3.1' # Use full Netverify and Authentication functionality
pod 'JumioMobileSDK/Netverify-Light', '~>3.3.1' # For Fastfill or Document Verification, or Netverify without 3D face liveness capturing technology

pod 'JumioMobileSDK/BAMCheckout', '~>3.3.1' # Use BAM Checkout only
```

Install the pod to your project via Terminal:
```
pod install
```

### Manually

Download our frameworks manually via [ios-jumio-mobile-sdk-3.3.1.zip](https://mobile-sdk.jumio.com/com/jumio/ios/jumio-mobile-sdk/3.3.1/ios-jumio-mobile-sdk-3.3.1.zip).

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

For our products Netverify & Fastfill, Authentication & Document Verification we are providing eight individual languages for your convenience:
* Chinese (Simplified)
* Dutch
* English
* French
* German
* Italian
* Portuguese
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
The previous release version 3.3.1 of the Jumio Mobile SDK is supported until 2020-02-15.

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
&copy; Jumio Corp. 268 Lambert Avenue, Palo Alto, CA 94306

The source code and software available on this website (“Software”) is provided by Jumio Corp. or its affiliated group companies (“Jumio”) "as is” and any express or implied warranties, including, but not limited to, the implied warranties of merchantability and fitness for a particular purpose are disclaimed. In no event shall Jumio be liable for any direct, indirect, incidental, special, exemplary, or consequential damages (including but not limited to procurement of substitute goods or services, loss of use, data, profits, or business interruption) however caused and on any theory of liability, whether in contract, strict liability, or tort (including negligence or otherwise) arising in any way out of the use of this Software, even if advised of the possibility of such damage.
In any case, your use of this Software is subject to the terms and conditions that apply to your contractual relationship with Jumio. As regards Jumio’s privacy practices, please see our privacy notice available here: [Privacy Policy](https://www.jumio.com/legal-information/privacy-policy/).
