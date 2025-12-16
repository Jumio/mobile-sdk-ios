![Header Graphic](images/jumio_feature_graphic.jpg)

[Improvement]: https://img.shields.io/badge/Improvement-green 'Improvement shield'
[Change]: https://img.shields.io/badge/Change-blue 'Change shield'
[Fix]: https://img.shields.io/badge/Fix-success 'Fix shield'

# Change Log

All notable changes, such as SDK releases, updates and fixes, are documented in this file.
For detailed technical changes please refer to our [Transition Guide](transition_guide.md).

## Support Period

Current SDK version: __4.15.0__  
Please refer to our [SDK maintenance and support policy](maintenance_policy.md) for more information about Mobile SDK maintenance and support.

## SDK Version: 4.15.0

![Improvement](https://img.shields.io/badge/Improvement-green) Added support for NFC read-only scanning.

![Improvement](https://img.shields.io/badge/Improvement-green) Introduced a configurable max retry count for NFC scanning.

![Improvement](https://img.shields.io/badge/Improvement-green) Included NFC scanning result status in transaction details via the Retrieval API.

![Improvement](https://img.shields.io/badge/Improvement-green) Enhanced user experience for NFC scanning with automatic NFC chip location detection.

## SDK Version: 4.14.0

![Improvement](https://img.shields.io/badge/Improvement-green) Added enhanced virtual camera injection detection [ID Verification, Selfie Verification]

![Improvement](https://img.shields.io/badge/Improvement-green) Accessibility updates for compliance with WCAG 2.2 AA and EAA

![Improvement](https://img.shields.io/badge/Improvement-green) Added support for Digital Identity using eIDAS for selected countries [ID Verification]

## SDK Version: 4.13.0

![Improvement](https://img.shields.io/badge/Improvement-green) Added support for NFC extraction of Chilean IDs

![Fix](https://img.shields.io/badge/Fix-success) Various bug fixes and improvements

## SDK Version: 4.12.0

![Improvement](https://img.shields.io/badge/Improvement-green) Added support for Jumio Liveness Premium with enhanced deepfake detection [Selfie Verification]

![Improvement](https://img.shields.io/badge/Improvement-green) Added support for Brazilian Digital Driver's License [ID Verification]

## SDK Version: 4.11.1

![Fix](https://img.shields.io/badge/Fix-success) Removed Datadog from default podspec [ID Verification, Selfie Verification, Document Verification]

## SDK Version: 4.11.0

![Improvement](https://img.shields.io/badge/Improvement-green) Added tilted image capture for frontside of ID documents. Enhanced checks of certain document security features [ID Verification]

![Improvement](https://img.shields.io/badge/Improvement-green) Added unsupported documents check to improve quality of extracted data and improve user experience [ID Verification]

![Improvement](https://img.shields.io/badge/Improvement-green) Added an Updated Authentication Service [Selfie Verification]

## SDK Version: 4.10.1

![Fix](https://img.shields.io/badge/Fix-success) Removed Datadog from default podspec [ID Verification, Selfie Verification, Document Verification]

## SDK Version: 4.10.0

![Improvement](https://img.shields.io/badge/Improvement-green) Support for 4k Image capture. Improved ML model input, enhanced image and fraud checks [ID Verification]

![Improvement](https://img.shields.io/badge/Improvement-green) Added flash capture for frontside of ID documents. Enhanced checks of certain document security features [ID Verification]

![Improvement](https://img.shields.io/badge/Improvement-green) Support for Serbian language, for both Cyrillic and Latin [ID Verification, Selfie Verification, Document Verification]

## SDK Version: 4.9.1

![Fix](https://img.shields.io/badge/Fix-success) iOS 12 app startup crash fixed [ID Verification]

## SDK Version: 4.9.0

![Improvement](https://img.shields.io/badge/Improvement-green) Added possibility to pre-load required ML models. For more information checkout the according section
in the [README](../README.md#ml-models) [ID Verification, Identity Verification]
![Improvement](https://img.shields.io/badge/Improvement-green) Automated document and country selection, powered by classifer ML model [ID Verification]

![Improvement](https://img.shields.io/badge/Improvement-green) Major UI Redesign [ID Verification, Selfie Verification, Document Verification]

![Improvement](https://img.shields.io/badge/Improvement-green) Improved Liveness retry logic. Prepared for granular instant feedback, if configured accordingly [Selfie Verification]

![Improvement](https://img.shields.io/badge/Improvement-green) iProov SDK version update to 11.0.3 [Selfie Verification]

![Change](https://img.shields.io/badge/Change-blue) Default UI implementation moved to its own dynamic framework, see: [Transition Guide](transition_guide.md). [Selfie Verification]

![Change](https://img.shields.io/badge/Change-blue) Removed Device Risk module from SDK [Selfie Verification]

## SDK Version: 4.8.1

![Improvement](https://img.shields.io/badge/Improvement-green) iProov SDK version update to 10.3.3 [Selfie Verification]

## SDK Version: 4.8.0

![Improvement](https://img.shields.io/badge/Improvement-green) Managing Liveness dependencies to help better conversion

## SDK Version: 4.7.1

![Improvement](https://img.shields.io/badge/Improvement-green) iProov SDK version update to 10.3.3 [Selfie Verification]

## SDK Version: 4.7.0

![Improvement](https://img.shields.io/badge/Improvement-green) Datadog SDK version update to 2.0: Added possibility to have two Datadog instances at the same time. Added SPM and Carthage support for Datadog

![Change](https://img.shields.io/badge/Change-blue) Removed previous scanning functionalities, now all included in Autocatpure functionality [ID Verification]

![Change](https://img.shields.io/badge/Change-blue) Pod Jumio/DeviceRisk excluded from pod Jumio/All.

![Change](https://img.shields.io/badge/Change-blue) MRZ functionality moved to Jumio core.

![Change](https://img.shields.io/badge/Change-blue) Barcode functionality was moved to Jumio core.

## SDK Version: 4.6.2

![Improvement](https://img.shields.io/badge/Improvement-green) iProov SDK version update to 10.3.3 [Selfie Verification]

## SDK Version: 4.6.1

![Improvement](https://img.shields.io/badge/Improvement-green) iProov SDK version update to 10.3.1 [Selfie Verification]

![Improvement](https://img.shields.io/badge/Improvement-green) Added Apple Privacy Manifest

![Change](https://img.shields.io/badge/Change-blue) Pod Jumio/DeviceRisk was excluded from pod Jumio/All.

## SDK Version: 4.6.0

![Improvement](https://img.shields.io/badge/Improvement-green) Added Jumio Liveness module to enhance the Liveness user experience and interface [Selfie Verification]

![Improvement](https://img.shields.io/badge/Improvement-green) Improved Liveness customization options [Selfie Verification]

![Change](https://img.shields.io/badge/Change-blue) Dependency name for iProov liveness was changed, see: [Transition Guide](transition_guide.md). [Selfie Verification]

## SDK Version: 4.5.0

![Improvement](https://img.shields.io/badge/Improvement-green) Added possibility for users to verify their identity using [Digital Identity](../README.md#digital-identity) [ID Verification, Identity Verification]

![Improvement](https://img.shields.io/badge/Improvement-green) iProov SDK version update to 10.1.3 [Selfie Verification]

![Improvement](https://img.shields.io/badge/Improvement-green) Improved user consent handling in accordance with biometric data protection laws [ID Verification, Selfie Verification]

![Improvement](https://img.shields.io/badge/Improvement-green) Improvement Added Carthage as new option for dependency manager

![Fix](https://img.shields.io/badge/Fix-success) Bug fixes: UI bugs [ID Verification]

<details>
<summary>More details</summary>

### User consent

User consent is now acquired for all users to ensure the accordance with biometric data protection laws. Please also refer to the [User Consent section](integration_faq.md#user-consent) in our FAQ.

</details>

## SDK Version: 4.4.0

![Improvement](https://img.shields.io/badge/Improvement-green) Fully redesigned ID Autocapture experience - seamless capturing, precise guidance and faster user journey [ID Verification]

![Improvement](https://img.shields.io/badge/Improvement-green) Major iProov SDK version update to 10.1.0 - no more face scanning filter, improved UI and more customization options [Selfie Verification]

![Improvement](https://img.shields.io/badge/Improvement-green) Mandatory NFC scanning option [ID Verification]

![Improvement](https://img.shields.io/badge/Improvement-green) Added iOS 11+ Simulator and M1 (Apple silicon) support

![Improvement](https://img.shields.io/badge/Improvement-green) Added Swift Package Manager (SPM) as new option for dependency manager

![Fix](https://img.shields.io/badge/Fix-success) Bug fixes: UI bugs, internal crashes

<details>
<summary>More details</summary>

### Autocapture

The new Autocapture experience allows users to capture multiple images within a single camera session. For example the user can be guided to first capture the front of a document, then flip the document and capture the back of a document.

Please also refer to the [Autocapture section](integration_faq.md#autocapture) in our FAQ.

### iOS Simulator

The Jumio SDK is now buildable with all Simulator iOS versions, but to really perform a scan you still need to use a physical device.

</details>

## SDK Version: 4.3.1

![Fix](https://img.shields.io/badge/Fix-success) Fixed camera focus issue with iPhone 14 Pro

## SDK Version: 4.3.0

![Improvement](https://img.shields.io/badge/Improvement-green) Alignment of previously existing scanning method and improved user experience through addition of Autocapture module [ID Verification]

![Improvement](https://img.shields.io/badge/Improvement-green) [Document Verification](../README.md#document-verification) functionality added
![Improvement](https://img.shields.io/badge/Improvement-green) Improved user guidance: Clear distinction between scanning frontside or backside of ID document [ID Verification]

![Improvement](https://img.shields.io/badge/Improvement-green) Addition of optional Datadog diagnostics module for monitoring SDK behavior and performance, as well as more efficient troubleshooting

![Change](https://img.shields.io/badge/Change-blue) iProov SDK version update to 9.5.0 [Selfie Verification]

![Fix](https://img.shields.io/badge/Fix-success) UI bugs, internal crashes [Selfie Verification]

## SDK Version: 4.2.0

![Improvement](https://img.shields.io/badge/Improvement-green) Support for device fingerprint capability [ID Verification, Selfie Verification]

![Improvement](https://img.shields.io/badge/Improvement-green) Improved NFC image extraction, it's now possible to extract selfie for similarity check [ID Verification]

![Improvement](https://img.shields.io/badge/Improvement-green) Improved liveness customization: Centered Floating prompt for better user guidance during face scanning [Selfie Verification]

![Fix](https://img.shields.io/badge/Fix-success) Bug fixes: UI bugs, internal crashes, security patches

## SDK Version: 4.1.2

![Fix](https://img.shields.io/badge/Fix-success) Fixed NFC library handling

## SDK Version: 4.1.1

![Improvement](https://img.shields.io/badge/Improvement-green) Improved customization options [ID Verification, Selfie Verification]

![Improvement](https://img.shields.io/badge/Improvement-green) Support for ObjectiveC for DefaultUI [ID Verification, Selfie Verification]

![Change](https://img.shields.io/badge/Change-blue) iProov SDK version update to 9.3.2 [Selfie Verification]

![Fix](https://img.shields.io/badge/Fix-success) Bug fixes: UI bugs

## SDK Version: 4.1.0

![Improvement](https://img.shields.io/badge/Improvement-green) Improved, granular user feedback for improved user experience and workflow through addition of Instant Feedback [ID Verification, Selfie Verification]

![Improvement](https://img.shields.io/badge/Improvement-green) Addition of NFC functionality to improve data extraction for documents [ID Verification]

![Improvement](https://img.shields.io/badge/Improvement-green) Addition of iPad support [ID Verification, Selfie Verification]

![Change](https://img.shields.io/badge/Change-blue) iProov SDK version update to 9.2.0 [Selfie Verification]

![Fix](https://img.shields.io/badge/Fix-success) Bug fixes: UI bugs, security improvements, internal crashes

## SDK Version: 4.0.0

This is a complete rewrite of our SDK. The SDK was built with Custom UI as a basis and restructured to align Android and iOS to reduce overall complexity and integration effort.

![Improvement](https://img.shields.io/badge/Improvement-green) Improved security by switching to one-time authorization tokens for SDK initialization instead of relying on API token and secret

![Improvement](https://img.shields.io/badge/Improvement-green) Redesigned Default UI flow

![Improvement](https://img.shields.io/badge/Improvement-green) Slimline SDK configuration of only 2.8 MB size

![Improvement](https://img.shields.io/badge/Improvement-green) Improved data extraction via enhancing the SDK capabilities with server-side extraction capabilities

![Improvement](https://img.shields.io/badge/Improvement-green) Manual capture is now available as a fallback option for all other capture methods

## Contact

If you have any questions regarding our implementation guide please contact Jumio Customer Service at support@jumio.com. The Jumio online helpdesk contains a wealth of information regarding our service including demo videos, product descriptions, FAQs and other things that may help to get you started with Jumio. [Check it out at here.](https://support.jumio.com).
