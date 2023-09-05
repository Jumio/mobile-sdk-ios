// swift-tools-version:5.3
import PackageDescription

let version = "4.6.1"

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
            checksum: "693434195250059a24f6fb8854bd9399e50e91fc2ea141372d58458733232ffe"
        ),
        .binaryTarget(
            name: "JumioDocFinder",
            url: "https://repo.mobile.jumio.ai/com/jumio/ios/jumio-mobile-sdk/\(version)/JumioDocFinder.xcframework.zip",
            checksum: "70cdd6fa499d6a6e2d1cf00b82ba706331bc9211b55ef9753a2911cd24570f29"
        ),
        .binaryTarget(
            name: "JumioDeviceRisk",
            url: "https://repo.mobile.jumio.ai/com/jumio/ios/jumio-mobile-sdk/\(version)/JumioDeviceRisk.xcframework.zip",
            checksum: "0ee4976de9bb35e5ade33e687bf7eda0ed793408bb1622d26a1d8b4b7ee9a640"
        ),
        .binaryTarget(
            name: "JumioIProov",
            url: "https://repo.mobile.jumio.ai/com/jumio/ios/jumio-mobile-sdk/\(version)/JumioIProov.xcframework.zip",
            checksum: "eee0666dd9a0305533c804be6608872fde6c27b305bc509638646c79cacf84be"
        ),
        .binaryTarget(
            name: "JumioLiveness",
            url: "https://repo.mobile.jumio.ai/com/jumio/ios/jumio-mobile-sdk/\(version)/JumioLiveness.xcframework.zip",
            checksum: "2e7efd916b055e8123e20df5906db34c373aac21f02f3f748642de4c76d123f2"
        ),
        .binaryTarget(
            name: "Pdf417Mobi",
            url: "https://repo.mobile.jumio.ai/com/jumio/ios/jumio-mobile-sdk/\(version)/Pdf417Mobi.xcframework.zip",
            checksum: "33f325d13e833a667ebccbb4c2c20da5bc3497abf1a24a18d173c039c9804225"
        ),
    ]
)
