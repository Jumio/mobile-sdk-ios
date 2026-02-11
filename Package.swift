// swift-tools-version:5.3
import PackageDescription

let version = "4.16.0"

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
            checksum: "4be947eb1412a7c3894a56b81b77b7353182ceb6d9034729b38c6fc179a36632"
        ),
        .binaryTarget(
            name: "JumioLiveness",
            url: "https://repo.mobile.jumio.ai/com/jumio/ios/jumio-mobile-sdk/\(version)/JumioLiveness.xcframework.zip",
            checksum: "08487644e482e128b4b4103acd953b82529015dbf751ec94646a6b2d52413d10"
        ),
        .binaryTarget(
            name: "JumioLivenessClient",
            url: "https://repo.mobile.jumio.ai/com/jumio/ios/jumio-mobile-sdk/\(version)/JumioLivenessClient.xcframework.zip",
            checksum: "8eb91c11a4ca3374aae1944a6831c49172b5bdab60fa7a86e2a02e786a09adf0"
        ),
        .binaryTarget(
            name: "JumioDefaultUI",
            url: "https://repo.mobile.jumio.ai/com/jumio/ios/jumio-mobile-sdk/\(version)/JumioDefaultUI.xcframework.zip",
            checksum: "fdeb51b82051d4e6e23e33ee7aab2ac6b3d8d8be98e7f3ff879ee6c0fc34efe9"
        ),
        .binaryTarget(
            name: "JumioNFC",
            url: "https://repo.mobile.jumio.ai/com/jumio/ios/jumio-mobile-sdk/\(version)/JumioNFC.xcframework.zip",
            checksum: "f89400395d12057aa0be7bae954743576ff661134857c0dd26c123fa123590e4"
        ),
    ]
)
