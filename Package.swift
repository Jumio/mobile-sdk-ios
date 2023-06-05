// swift-tools-version:5.3
import PackageDescription

let version = "4.6.0"

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
            .exact("10.1.3")
        ),
    ],
    targets: [
        .target(name: "JumioBundle",
                dependencies: [
                    "Jumio",
                    "Pdf417Mobi"
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
            checksum: "0d5f466f7edccfa609e35426ac514a0973f9841e75e60ae07cf7fff8b2654917"
        ),
        .binaryTarget(
            name: "JumioDocFinder",
            url: "https://repo.mobile.jumio.ai/com/jumio/ios/jumio-mobile-sdk/\(version)/JumioDocFinder.xcframework.zip",
            checksum: "0386e8a1b41e5a29d9cf4e74cb314f6418bdd37a28b300a683d81c3a61420dca"
        ),
        .binaryTarget(
            name: "JumioDeviceRisk",
            url: "https://repo.mobile.jumio.ai/com/jumio/ios/jumio-mobile-sdk/\(version)/JumioDeviceRisk.xcframework.zip",
            checksum: "d0bf3135890b37c566932968dd5b38effc72d6a3eaa1a481d839d3196c3cdbc3"
        ),
        .binaryTarget(
            name: "JumioIProov",
            url: "https://repo.mobile.jumio.ai/com/jumio/ios/jumio-mobile-sdk/\(version)/JumioIProov.xcframework.zip",
            checksum: "55e4ed8a3e2891c9c66799246283a1424d9ad8841be89836aeb0d19c0ce17a54"
        ),
        .binaryTarget(
            name: "JumioLiveness",
            url: "https://repo.mobile.jumio.ai/com/jumio/ios/jumio-mobile-sdk/\(version)/JumioLiveness.xcframework.zip",
            checksum: "c8afdcd35b206a389bf294fb42c24c02fbb7315832f57ca41ccfdc3beafef39f"
        ),
        .binaryTarget(
            name: "Pdf417Mobi",
            url: "https://repo.mobile.jumio.ai/com/jumio/ios/jumio-mobile-sdk/\(version)/Pdf417Mobi.xcframework.zip",
            checksum: "052b69a356325fc2692fe4fac6b2dc21666786a0b9ee4790be7329f9c5c1b180"
        ),
    ]
)
