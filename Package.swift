// swift-tools-version:5.3
import PackageDescription

let version = "4.5.0"

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
            checksum: "5896a0254b1a07438d486522433face219e03ff3be6b7c7a223c9916121c20a3"
        ),
        .binaryTarget(
            name: "JumioDocFinder",
            url: "https://repo.mobile.jumio.ai/com/jumio/ios/jumio-mobile-sdk/\(version)/JumioDocFinder.xcframework.zip",
            checksum: "4a41916d5b7e94d8bb0620b94495f93ba3bcae50fa2948e7288e708eda88e40d"
        ),
        .binaryTarget(
            name: "JumioDeviceRisk",
            url: "https://repo.mobile.jumio.ai/com/jumio/ios/jumio-mobile-sdk/\(version)/JumioDeviceRisk.xcframework.zip",
            checksum: "39da720a0a14dad0963b4fcde77be34c03c49fe9dfcfea8165000f9a76fee166"
        ),
        .binaryTarget(
            name: "JumioIProov",
            url: "https://repo.mobile.jumio.ai/com/jumio/ios/jumio-mobile-sdk/\(version)/JumioIProov.xcframework.zip",
            checksum: "4294240daf9e21be340559798e0b63732db236baf7c744c886c34c397b2b6fbb"
        ),
        .binaryTarget(
            name: "Pdf417Mobi",
            url: "https://repo.mobile.jumio.ai/com/jumio/ios/jumio-mobile-sdk/\(version)/Pdf417Mobi.xcframework.zip",
            checksum: "a84a6eba6215f0c8fbd27ee0be855ff1ccf5ee82e9c3b7f7ac373a0b637516ea"
        ),
    ]
)
