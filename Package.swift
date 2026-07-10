// swift-tools-version:5.3
import PackageDescription

let version = "4.18.0"

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
            checksum: "eddf062afa95ec8981bb59a56f97871eb9e245c27fd7686ecbd4b1d5d3a3100d"
        ),
        .binaryTarget(
            name: "JumioLiveness",
            url: "https://repo.mobile.jumio.ai/com/jumio/ios/jumio-mobile-sdk/\(version)/JumioLiveness.xcframework.zip",
            checksum: "3efcf14eb49de31bc65709ec64466d19b4066526f9319ecebabd2b0d80594f5d"
        ),
        .binaryTarget(
            name: "JumioLivenessClient",
            url: "https://repo.mobile.jumio.ai/com/jumio/ios/jumio-mobile-sdk/\(version)/JumioLivenessClient.xcframework.zip",
            checksum: "9360d12471feeaa1c92fc8de8b58199b83027ace9fffb47ef2a490087e20d8c2"
        ),
        .binaryTarget(
            name: "JumioDefaultUI",
            url: "https://repo.mobile.jumio.ai/com/jumio/ios/jumio-mobile-sdk/\(version)/JumioDefaultUI.xcframework.zip",
            checksum: "9390419a150ccec12cec9f2969fbe9c859e0c0bc3bfc39711dbb3b61d885fbdf"
        ),
        .binaryTarget(
            name: "JumioNFC",
            url: "https://repo.mobile.jumio.ai/com/jumio/ios/jumio-mobile-sdk/\(version)/JumioNFC.xcframework.zip",
            checksum: "254dad96300902463fc1e5f4fc35335f3fbd4283f4f4aae231855c18984a2406"
        ),
    ]
)
