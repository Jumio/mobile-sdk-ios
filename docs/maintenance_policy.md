![Header Graphic](images/jumio_feature_graphic.jpg)

# Maintenance and Support Policy

## Overview
This document outlines the maintenance policy for Jumio’s Software Development Kits (“SDKs”), including Mobile and Web SDK and their dependencies. 
Our SDK releases are published publicly as indicated in our documentation as well as to package managers. Documentation and sample implementations are available as source code on GitHub ([Android](https://github.com/Jumio/mobile-sdk-android) and [iOS](https://github.com/Jumio/mobile-sdk-ios)).

We are consistently updating the Jumio SDKs in order to provide the best possible experience for you. Upgrading to the latest SDK version will not only ensure you benefit from various performance enhancements and bug fixes, but will also allow you to take advantage of new capabilities. All releases undergo comprehensive testing by our teams before being deployed.

If you are using a Mobile SDK, please ensure your apps have been released and your end-users have updated before the End-of-Support date. Jumio does not provide support after the End-of-Support date. 

Customers should review the [Jumio Terms and Conditions](https://www.jumio.com/legal-information/privacy-notices/) for requirements related to the implementation of updates. 

## Versioning
Jumio SDK release versions are in the form of X.Y.Z:
* X major version - very rarely updated
* Y minor version - normally updated once in a quarter
* Z patch version - updated on demand

Major versions of Jumio’s SDKs are released rarely, and only in case of substantial changes to support new features and patterns. Breaking changes can happen in Major and Minor versions. Applications need to be updated in order for them to work with the newest SDK version. Breaking changes are highlighted in our [Android](https://github.com/Jumio/mobile-sdk-android) and [iOS](https://github.com/Jumio/mobile-sdk-ios) implementation guides for each release.

Jumio will only provide patches or additional updates on the latest version regardless if it’s Major, Minor or Patch. 

## SDK Version Lifecycle
The life-cycle for SDK versions consists of these phases, which are outlined below:
* __Developer Preview__ (Phase 0) - During this phase, SDKs are not supported, must not be used in production environments, and are meant for early access and feedback purposes only. It is possible for future releases to introduce breaking changes. It can be alpha, beta, or release candidate.
* __General availability / Full support__ (Phase 1) - During this phase, SDKs are fully supported. Jumio will provide active support on this version and will provide required bug fixes or security fixes within new / upcoming versions (major, minor, patch). 
* __End-of-Support__ (Phase 2) - Each SDK version reaches end of support 9 months after the release date. Issues that appear after the End-of-Support date will only be addressed in the upcoming SDK releases. Previously published releases will continue to be available via public package managers and the code will remain on GitHub. Use of an SDK that has reached End-of-Support is done at the business customers’ discretion. We recommend upgrading to the latest version.
* __End-of-Life__ (Phase 3) - By default, our SDK will reach the end of life 24 months after the release date. The SDK may continue to work but Jumio will no longer provide support or updates. Customers will be notified at least 3 months prior to the end of life of a product should it be less than 24 months. 

The following table is a visual representation of the SDK 4.x.x version life-cycle. SDK 3.x.x has reached its End-of-Life on December 31, 2023.

| Version |     Release      |   End of Support  |   End of Life    | 
|:-------:|:----------------:|:-----------------:|:----------------:|
|  4.13.0 |    04 April 2025 |   04 January 2026 |    04 April 2027 |
|  4.12.0 | 05 December 2024 | 05 September 2025 | 05 December 2026 |
|  4.11.0 |   19 August 2024 |       19 May 2025 |   19 August 2026 |
|  4.10.0 |     05 June 2024 |      5 March 2025 |      5 June 2026 |
|  4.9.1  |    13 March 2024 |  21 November 2024 | 21 February 2026 |
|  4.9.0  | 21 February 2024 |  21 November 2024 | 21 February 2026 |
|  4.8.0  |  17 October 2023 |      17 July 2024 |  17 October 2025 |
|  4.7.0  |27 September 2023 |      27 June 2024 |27 September 2025 |
|  4.6.1  |05 September 2023 |     05 March 2024 |     05 June 2025 | 
|  4.6.0  |     05 June 2023 |     05 March 2024 |     05 June 2025 | 
|  4.5.0  |    14 April 2023 |   14 January 2024 |    14 April 2025 | 
|  4.4.0  | 21 December 2022 | 21 September 2023 | 21 December 2024 | 
|  4.3.1  |  25 October 2022 |       30 May 2023 |   30 August 2024 | 
|  4.3.0  |   30 August 2022 |       30 May 2023 |   30 August 2024 | 
|  4.2.0  |      25 May 2022 |  25 February 2023 |      25 May 2024 | 
|  4.1.2  |    19 April 2022 |  09 December 2022 |    09 March 2024 |
|  4.1.1  |    04 April 2022 |  09 December 2022 |    09 March 2024 |
|  4.1.0  |    09 March 2022 |  09 December 2022 |    09 March 2024 |
|  4.0.0  | 16 November 2021 |    16 August 2022 | 16 November 2023 | 
