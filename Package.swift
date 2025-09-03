// swift-tools-version:5.3
import PackageDescription

let version = "4.14.0"

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
            name: "JumioIProov",
            targets: ["JumioIProovBundle"]
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
            name: "JumioLocalization",
            targets: ["JumioLocalization"]
        )
    ],
    dependencies: [
        .package(
            name: "iProov",
            url: "https://github.com/iProov/ios.git",
            .upToNextMinor(from: "11.1.1")
        )
    ],
    targets: [
        .target(name: "JumioBundle",
                dependencies: [
                    "Jumio"
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
        .target(name: "JumioDefaultUIBundle",
                dependencies: [
                    "JumioBundle",
                    "JumioDefaultUI"
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
            checksum: "c8c4b85e77c4037f90c758c87275ef713f5d428dda2793afda99169a43c60577"
        ),
        .binaryTarget(
            name: "JumioIProov",
            url: "https://repo.mobile.jumio.ai/com/jumio/ios/jumio-mobile-sdk/\(version)/JumioIProov.xcframework.zip",
            checksum: "2333d0fba262f108d20835e60b6ce6c8f6327d0717d7289648d3fc1223f4dc53"
        ),
        .binaryTarget(
            name: "JumioLiveness",
            url: "https://repo.mobile.jumio.ai/com/jumio/ios/jumio-mobile-sdk/\(version)/JumioLiveness.xcframework.zip",
            checksum: "8a789853349ce2c961f4300bec0f4bd1a1f8a409a356f29d6edc68efcc35e45d"
        ),
        .binaryTarget(
            name: "JumioDefaultUI",
            url: "https://repo.mobile.jumio.ai/com/jumio/ios/jumio-mobile-sdk/\(version)/JumioDefaultUI.xcframework.zip",
            checksum: "7adeb215bc7818433da6f38ebd328025c08527aca71d04accfe15c8c95c9de1f"
        ),
    ]
)
