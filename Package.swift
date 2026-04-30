// swift-tools-version:5.3
import PackageDescription

let version = "4.17.1"

let package = Package(
    name: "Jumio",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "Jumio",
            targets: ["JumioBundle"]
        ),
        .library(
            name: "JumioLiveness",
            targets: ["JumioLivenessBundle"]
        ),
        .library(
            name: "JumioDefaultUI",
            targets: ["JumioDefaultUIBundle"]
        ),
        .library(
            name: "JumioNFC",
            targets: ["JumioNFCBundle"]
        ),
        .library(
            name: "JumioLocalization",
            targets: ["JumioLocalization"]
        )
    ],
    targets: [
        .target(name: "JumioBundle",
                dependencies: [
                    "Jumio"
                ]
               ),
        .target(name: "JumioLivenessBundle",
                dependencies: [
                    "JumioBundle",
                    "JumioLiveness",
                    "JumioLivenessClient"
                ]
               ),
        .target(name: "JumioDefaultUIBundle",
                dependencies: [
                    "JumioBundle",
                    "JumioDefaultUI"
                ]
        ),
        .target(name: "JumioNFCBundle",
                dependencies: [
                    "JumioBundle",
                    "JumioNFC"
                ]
        ),
        .target(name: "JumioLocalization",
                dependencies: [
                    "JumioBundle"
                ],
                resources: [.process("Localization")]),
        .binaryTarget(
            name: "Jumio",
            url: "https://repo.mobile.jumio.ai/com/jumio/ios/jumio-mobile-sdk/\(version)/Jumio.xcframework.zip",
            checksum: "2a1fa5b4fe24d9f914f4fa6b1b03f97433e216d81587632c7849d9c18b4eeb65"
        ),
        .binaryTarget(
            name: "JumioLiveness",
            url: "https://repo.mobile.jumio.ai/com/jumio/ios/jumio-mobile-sdk/\(version)/JumioLiveness.xcframework.zip",
            checksum: "e8534c1fbea286875e0618a7430588120b0a3cc068956133325d53fa1e99c52f"
        ),
        .binaryTarget(
            name: "JumioLivenessClient",
            url: "https://repo.mobile.jumio.ai/com/jumio/ios/jumio-mobile-sdk/\(version)/JumioLivenessClient.xcframework.zip",
            checksum: "05c4917781cae8d9039b220b862f294c07eaf712cc6c0b1750f0535eae8382ee"
        ),
        .binaryTarget(
            name: "JumioDefaultUI",
            url: "https://repo.mobile.jumio.ai/com/jumio/ios/jumio-mobile-sdk/\(version)/JumioDefaultUI.xcframework.zip",
            checksum: "48f2d2d3110f2004eb5f7f8c6e81892a7f85b63305ad487aef9a91997c8ad1b3"
        ),
        .binaryTarget(
            name: "JumioNFC",
            url: "https://repo.mobile.jumio.ai/com/jumio/ios/jumio-mobile-sdk/\(version)/JumioNFC.xcframework.zip",
            checksum: "b6ccdbbe5806e230f063f6880b83bf0bef170230ff45cdb2ce999163b96a42a1"
        ),
    ]
)
