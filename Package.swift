// swift-tools-version:5.3
import PackageDescription

let version = "4.4.0"

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
            name: "JumioLiveness",
            targets: ["JumioLivenessBundle"]
        ),
    ],
    dependencies: [
        .package(
            name: "iProov",
            url: "https://github.com/iProov/ios.git",
            .exact("10.1.0")
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
        .target(name: "JumioLivenessBundle",
                dependencies: [
                    "JumioBundle",
                    "JumioIProov",
                    .product(name: "iProov", package: "iProov")
                ]
        ),
        .binaryTarget(
            name: "Jumio",
            url: "https://repo.mobile.jumio.ai/com/jumio/ios/jumio-mobile-sdk/\(version)/Jumio.xcframework.zip",
            checksum: "3c00e83c045c987808311054c0f16800a0bd381d0e73ab66a729893b4fce5a67"
        ),
        .binaryTarget(
            name: "JumioDocFinder",
            url: "https://repo.mobile.jumio.ai/com/jumio/ios/jumio-mobile-sdk/\(version)/JumioDocFinder.xcframework.zip",
            checksum: "3ecc2595d0d8546fcdb766c35663665e4f4b210c9dec633d46dc114c8e26b071"
        ),
        .binaryTarget(
            name: "JumioDeviceRisk",
            url: "https://repo.mobile.jumio.ai/com/jumio/ios/jumio-mobile-sdk/\(version)/JumioDeviceRisk.xcframework.zip",
            checksum: "6f4ceabd4091b5f29ec8dabfa37466886a81ef12683b543d12e52f396f62440e"
        ),
        .binaryTarget(
            name: "JumioIProov",
            url: "https://repo.mobile.jumio.ai/com/jumio/ios/jumio-mobile-sdk/\(version)/JumioIProov.xcframework.zip",
            checksum: "5fad851accbc44c23856ba521d88cc138930a4356d8aecebaee8ac0aaba971c2"
        ),
        .binaryTarget(
            name: "Pdf417Mobi",
            url: "https://repo.mobile.jumio.ai/com/jumio/ios/jumio-mobile-sdk/\(version)/Pdf417Mobi.xcframework.zip",
            checksum: "b6d45025a2dd77ce21737a08f2627fc3ad5a572ff45dcd61de43d228f7932575"
        ),
    ]
)
