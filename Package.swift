// swift-tools-version:5.3
import PackageDescription

let version = "4.8.0"

let package = Package(
    name: "Jumio",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v11)
    ],
    products: [
        .library(
            name: "Jumio",
            targets: ["JumioBundle"]
        ),
        .library(
            name: "JumioDocFinder",
            targets: ["JumioDocFinderBundle"]
        ),
        .library(
            name: "JumioDeviceRisk",
            targets: ["JumioDeviceRiskBundle"]
        ),
        .library(
            name: "JumioIProov",
            targets: ["JumioIProovBundle"]
        ),
        .library(
            name: "JumioLiveness",
            targets: ["JumioLivenessBundle"]
        ),
    ],
    dependencies: [
        .package(
            name: "iProov",
            url: "https://github.com/iProov/ios.git",
            .exact("10.3.1")
        )
    ],
    targets: [
        .target(name: "JumioBundle",
                dependencies: [
                    "Jumio"
                ]
               ),
        .target(name: "JumioDocFinderBundle",
                dependencies: [
                    "JumioBundle",
                    "JumioDocFinder"
                ]
               ),
        .target(name: "JumioDeviceRiskBundle",
                dependencies: [
                    "JumioBundle",
                    "JumioDeviceRisk"
                ]
               ),
        .target(name: "JumioIProovBundle",
                dependencies: [
                    "JumioBundle",
                    "JumioLivenessBundle",
                    "JumioIProov",
                    .product(name: "iProov", package: "iProov")
                ]
               ),
        .target(name: "JumioLivenessBundle",
                dependencies: [
                    "JumioBundle",
                    "JumioLiveness"
                ]
               ),
        .binaryTarget(
            name: "Jumio",
            url: "https://repo.mobile.jumio.ai/com/jumio/ios/jumio-mobile-sdk/\(version)/Jumio.xcframework.zip",
            checksum: "f4bdb047df830dfdd244c9532d3855958699eee3684011b4cb796841112162c6"
        ),
        .binaryTarget(
            name: "JumioDocFinder",
            url: "https://repo.mobile.jumio.ai/com/jumio/ios/jumio-mobile-sdk/\(version)/JumioDocFinder.xcframework.zip",
            checksum: "c5dcf0c8051d6b2e93fa0738c2ae56bf7d108384bdbb33507c8edc6ca3d0d8e7"
        ),
        .binaryTarget(
            name: "JumioDeviceRisk",
            url: "https://repo.mobile.jumio.ai/com/jumio/ios/jumio-mobile-sdk/\(version)/JumioDeviceRisk.xcframework.zip",
            checksum: "3e244bf03b9fcc88bfa6b9e5e68e3a4c2d3982784d948a3bde8b2d28eb2016f8"
        ),
        .binaryTarget(
            name: "JumioIProov",
            url: "https://repo.mobile.jumio.ai/com/jumio/ios/jumio-mobile-sdk/\(version)/JumioIProov.xcframework.zip",
            checksum: "6bbc56158b0b22f1b91fb1be88fa52d2110eb75a8da3b7f918b2fb30cb7f3fd5"
        ),
        .binaryTarget(
            name: "JumioLiveness",
            url: "https://repo.mobile.jumio.ai/com/jumio/ios/jumio-mobile-sdk/\(version)/JumioLiveness.xcframework.zip",
            checksum: "71651ac66f49c90ea60e482e900720769e9d8427a4775e3d4f01752c7ef2f20b"
        ),
    ]
)
