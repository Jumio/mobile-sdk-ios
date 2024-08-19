![Version](https://img.shields.io/github/v/release/Jumio/Mobile-SDK-IOS?style=flat)
![License](https://img.shields.io/cocoapods/l/JumioMobileSDK.svg?style=flat)
![Platform](https://img.shields.io/cocoapods/p/JumioMobileSDK.svg?style=flat)
[![Pod Version](https://img.shields.io/cocoapods/v/JumioMobileSDK.svg?style=flat)](https://cocoapods.org/pods/JumioMobileSDK)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![Swift 3.0-5.x](http://img.shields.io/badge/Swift-3.x,%204.x%20&%205.x-orange.svg?style=flat)](https://swift.org/)

[Improvement]: https://img.shields.io/badge/Improvement-green "Improvement shield"
[Change]: https://img.shields.io/badge/Change-blue "Change shield"
[Fix]: https://img.shields.io/badge/Fix-success "Fix shield"

# Change Log
All notable changes, such as SDK releases, updates and fixes, are documented in this file.
For detailed technical changes please refer to our [Transition Guide](transition_guide.md).

## Support Period

Current SDK version: __4.11.0__     
Please refer to our [SDK maintenance and support policy](maintenance_policy.md) for more information about Mobile SDK maintenance and support.

## SDK Version: __4.11.0__
![Improvement] Added tilted image capture for frontside of ID documents. Enhanced checks of certain document security features [ID Verification]

![Improvement] Added unsupported documents check to improve quality of extracted data and improve user experience [ID Verification]

![Improvement] Added an Updated Authentication Service [Identity Verification]

## SDK Version: __4.10.0__
![Improvement] Support for 4k Image capture. Improved ML model input, enhanced image and fraud checks [ID Verification]

![Improvement] Added flash capture for frontside of ID documents. Enhanced checks of certain document security features [ID Verification]

![Improvement] Support for Serbian language, for both Cyrillic and Latin [ID Verification, Identity Verification, Document Verification]

## SDK Version: __4.9.1__
![Fix] iOS 12 app startup crash fixed [ID Verification]

## SDK Version: __4.9.0__
![Improvement] Added possibility to pre-load required ML models. For more information checkout the according section in the [README](../README.md#ml-models) [ID Verification, Identity Verification]

![Improvement] Automated document and country selection, powered by classifer ML model [ID Verification]

![Improvement] Major UI Redesign [ID Verification, Identity Verification, Document Verification]

![Improvement] Improved Liveness retry logic. Prepared for granular instant feedback, if configured accordingly [Identity Verification]

![Improvement] iProov SDK version update to 11.0.3 [Identity Verification] 

![Change] Default UI implementation moved to its own dynamic framework, see: [Transition Guide](transition_guide.md). [Identity Verification]

![Change] Removed Device Risk module from SDK [Identity Verification]

## SDK Version: __4.8.1__
![Improvement] iProov SDK version update to 10.3.3 [Identity Verification]

## SDK Version: __4.8.0__
![Improvement] Managing Liveness dependencies to help better conversion

## SDK Version: __4.7.1__
![Improvement] iProov SDK version update to 10.3.3 [Identity Verification]

## SDK Version: __4.7.0__
![Improvement] Datadog SDK version update to 2.0: Added possibility to have two Datadog instances at the same time. Added SPM and Carthage support for Datadog

![Change] Removed previous scanning functionalities, now all included in Autocatpure functionality [ID Verification]

![Change] Pod Jumio/DeviceRisk excluded from pod Jumio/All.   

![Change] MRZ functionality moved to Jumio core. 

![Change] Barcode functionality was moved to Jumio core.  

## SDK Version: __4.6.2__
![Improvement] iProov SDK version update to 10.3.3 [Identity Verification]

## SDK Version: __4.6.1__
![Improvement] iProov SDK version update to 10.3.1 [Identity Verification]

![Improvement] Added Apple Privacy Manifest

![Change] Pod Jumio/DeviceRisk was excluded from pod Jumio/All.

## SDK Version: __4.6.0__
![Improvement] Added Jumio Liveness module to enhance the Liveness user experience and interface [Identity Verification]

![Improvement] Improved Liveness customization options [Identity Verification]

![Change] Dependency name for iProov liveness was changed, see: [Transition Guide](transition_guide.md). [Identity Verification]

## SDK Version: __4.5.0__
![Improvement] Added possibility for users to verify their identity using [Digital Identity](../README.md#digital-identity) [ID Verification, Identity Verification]

![Improvement] iProov SDK version update to 10.1.3 [Identity Verification]

![Improvement] Improved user consent handling in accordance with biometric data protection laws [ID Verification, Identity Verification]

![Improvement] Improvement Added Carthage as new option for dependency manager

![Fix] Bug fixes: UI bugs [ID Verification]

<details>
<summary>More details</summary>

### User consent

User consent is now acquired for all users to ensure the accordance with biometric data protection laws. Please also refer to the [User Consent section](integration_faq.md#user-consent) in our FAQ.

</details>

## SDK Version: __4.4.0__
![Improvement] Fully redesigned ID Autocapture experience - seamless capturing, precise guidance and faster user journey [ID Verification]

![Improvement] Major iProov SDK version update to 10.1.0 - no more face scanning filter, improved UI and more customization options [Identity Verification]

![Improvement] Mandatory NFC scanning option [ID Verification]

![Improvement] Added iOS 11+ Simulator and M1 (Apple silicon) support

![Improvement] Added Swift Package Manager (SPM) as new option for dependency manager

![Fix] Bug fixes: UI bugs, internal crashes

<details>
<summary>More details</summary>

### Autocapture

The new Autocapture experience allows users to capture multiple images within a single camera session. For example the user can be guided to first capture the front of a document, then flip the document and capture the back of a document.

Please also refer to the [Autocapture section](integration_faq.md#autocapture) in our FAQ.

### iOS Simulator

The Jumio SDK is now buildable with all Simulator iOS versions, but to really perform a scan you still need to use a physical device.

</details>

## SDK Version: __4.3.1__
![Fix] Fixed camera focus issue with iPhone 14 Pro

## SDK Version: __4.3.0__
![Improvement] Alignment of previously existing scanning method and improved user experience through addition of Autocapture module [ID Verification]

![Improvement] [Document Verification](../README.md#document-verification) functionality added

![Improvement] Improved user guidance: Clear distinction between scanning frontside or backside of ID document [ID Verification]

![Improvement] Addition of optional Datadog diagnostics module for monitoring SDK behavior and performance, as well as more efficient troubleshooting

![Change] iProov SDK version update to 9.5.0 [Identity Verification]

![Fix] UI bugs, internal crashes [Identity Verification]

## SDK Version: __4.2.0__
![Improvement] Support for device fingerprint capability [ID Verification, Identity Verification]

![Improvement] Improved NFC image extraction, it's now possible to extract selfie for similarity check [ID Verification]

![Improvement] Improved liveness customization: Centered Floating prompt for better user guidance during face scanning [Identity Verification]

![Fix] Bug fixes: UI bugs, internal crashes, security patches

## SDK Version: __4.1.2__
![Fix] Fixed NFC library handling

## SDK Version: __4.1.1__
![Improvement] Improved customization options [ID Verification, Identity Verification]

![Improvement] Support for ObjectiveC for DefaultUI [ID Verification, Identity Verification]

![Change] iProov SDK version update to 9.3.2 [Identity Verification]

![Fix] Bug fixes: UI bugs

## SDK Version: __4.1.0__
![Improvement] Improved, granular user feedback for improved user experience and workflow through addition of Instant Feedback [ID Verification, Identity Verification]

![Improvement] Addition of NFC functionality to improve data extraction for documents [ID Verification]

![Improvement] Addition of iPad support [ID Verification, Identity Verification]

![Change] iProov SDK version update to 9.2.0 [Identity Verification]

![Fix] Bug fixes: UI bugs, security improvements, internal crashes

## SDK Version: __4.0.0__
This is a complete rewrite of our SDK. The SDK was built with Custom UI as a basis and restructured to align Android and iOS to reduce overall complexity and integration effort.

![Improvement] Improved security by switching to one-time authorization tokens for SDK initialization instead of relying on API token and secret

![Improvement] Redesigned Default UI flow

![Improvement] Slimline SDK configuration of only 2.8 MB size

![Improvement] Improved data extraction via enhancing the SDK capabilities with server-side extraction capabilities

![Improvement] Manual capture is now available as a fallback option for all other capture methods

## SDK Version: __3.9.4__
![Fix] iProov SDK version update to 9.0.1, which fixes an issue introduced in SDK 3.9.3 when building with XCode versions prior to XCode 12.5. [Identity Verification]

## SDK Version: __3.9.3__
![Improvement] iProov SDK version update to 9.0.0, which improves performance, reliability and security against spoof attacks. [Identity Verification]

## SDK Version: __3.9.2__
![Improvement] iProov SDK version update to 8.4.0, which improves performance and accuracy [Identity Verification]

![Fix] Fixed issue to avoid duplicate invocation of shouldDisplayHelpWithText: in CustomUI [Identity Verification]

## SDK Version: __3.9.1__
![Improvement] iProov SDK version update to 8.3.1, which improves performance and offers additional customization options [Identity Verification]

## SDK Version: __3.9.0__
![Improvement] Improved retry guidance for Identity Verification [Identity Verification]

![Improvement] Improved customization options for Identity Verification [Identity Verification]

![Improvement] MicroBlink pdf417 version update to 7.3.0 [ID Verification/Fastfill]

![Improvement] Added more granular differentiations for `ScanMode` in CustomUI [Identity Verification]

![Improvement] Improved handling of extracted data reading from barcodes [ID Verification/Fastfill]

![Fix] Fixed rare issue of help animation overlapping with view header on smaller screen sizes [Identity Verification]

![Fix] Fixed missing close button on initial document selection screen [ID Verification/Fastfill]

![Fix] Fixed app crashing after back button click on barcode backside scan view in some scenarios [ID Verification/Fastfill]

![Fix] Fixed app crashing on face scan start after barcode scanning in some scenarios when using Zoom in certain cases [ID Verification/Fastfill, Identity Verification]

![Fix] Fixed rare occurrence of app being stuck on processing after app is put in the background during iProov face scan [Identity Verification]

![Change] iProov SDK version update to 8.2.0, which includes image quality improvements that reduces false rejects [Identity Verification]

## SDK Version: __3.8.0__
![Fix] Fixed minor breaking constraints on scan view [ID Verification]

![Change] Added iProov as an additional liveness vendor to the [Jumio KYX platform](https://www.jumio.com/kyx/) [Identity Verification]

## SDK Version: __3.7.2__
![Improvement] New error code is returned in case an ad blocker or a firewall is detected [ID Verification/Fastfill, Authentication, Document Verification]

![Improvement] Added option to test custom UI on Simulator and change position after NetverifyCustomScanViewController is displayed [ID Verification Custom UI]

![Fix] Fixed a rare problem in which Identity Verification (Face capture) was skipped [ID Verification]

![Fix] Fixed a problem in which the close button disappeared on iOS 14 [ID Verification/Fastfill]

![Fix] Added a fix to bypass a [CoreNFC bug in XCode 12](https://developer.apple.com/documentation/xcode-release-notes/xcode-12_2-release-notes) that caused the SDK to crash in Simulator


## SDK Version: __3.7.1__
![Fix] Fixed problem in reading the issuing date correctly from AUS passports [ID Verification]

![Fix] Fixed problem that front of ID was missing for processing in certain edge cases [ID Verification]

## SDK Version: __3.7.0__
![Change] New NFC reading functionality of Passports [ID Verification]

![Change] Adjusted Jumio logo and default color to reflect new Jumio appearance [ID Verification/Fastfill, Authentication, Document Verification]

![Improvement] Support of 24 new languages [ID Verification/Fastfill, Authentication, Document Verification]

![Improvement] Possibility to retrieve the captured images directly in the SDK [ID Verification/Fastfill]

![Fix] Various smaller bug fixes/improvements [ID Verification/Fastfill, Authentication, Document Verification]

## SDK version: __3.6.0__
![Change] Added support for right-to-left languages [Netverify/Fastfill, Authentication, Document Verification]

![Change] Provide access to document guidance animation [Netverify Custom UI]

![Change] Added Carthage as an additional dependency manager [Netverify/Fastfill, Authentication, Document Verification, BAM Checkout]

![Change] Adjusted handling of document types which don’t support plastic documents [Netverify]

![Improvement] Support for 5 new languages (Czech, Greek, Hungarian, Polish, Romanian) [Netverify/Fastfill, Authentication, Document Verification]

![Improvement] Improved accessibility handling [Netverify/Fastfill, Authentication, Document Verification]

![Fix] Various smaller bug fixes/improvements [Netverify/Fastfill, Authentication, Document Verification]

## Contact
If you have any questions regarding our implementation guide please contact Jumio Customer Service at support@jumio.com. The Jumio online helpdesk contains a wealth of information regarding our service including demo videos, product descriptions, FAQs and other things that may help to get you started with Jumio. [Check it out at here.](https://support.jumio.com.)
