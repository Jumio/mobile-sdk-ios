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
            checksum: "4f0583bf8543bac04ca937d03e55c6b6a65c1897f830c92f71c7ea7c4d7fc8f6"
        ),
        .binaryTarget(
            name: "JumioDocFinder",
            url: "https://repo.mobile.jumio.ai/com/jumio/ios/jumio-mobile-sdk/\(version)/JumioDocFinder.xcframework.zip",
            checksum: "9c8690adf352eecf199c70a1e713517797d649d948d1e7faa81fc8cebe6586cf"
        ),
        .binaryTarget(
            name: "JumioDeviceRisk",
            url: "https://repo.mobile.jumio.ai/com/jumio/ios/jumio-mobile-sdk/\(version)/JumioDeviceRisk.xcframework.zip",
            checksum: "305861e8d535d6b28b2699b7815eec9d8a981d2dfe9e751472fa75a94084c629"
        ),
        .binaryTarget(
            name: "JumioIProov",
            url: "https://repo.mobile.jumio.ai/com/jumio/ios/jumio-mobile-sdk/\(version)/JumioIProov.xcframework.zip",
            checksum: "f26e0f549ed238e82e428fbe82c3ce4345d335825134b68d166af96ce0a0566e"
        ),
        .binaryTarget(
            name: "Pdf417Mobi",
            url: "https://repo.mobile.jumio.ai/com/jumio/ios/jumio-mobile-sdk/\(version)/Pdf417Mobi.xcframework.zip",
            checksum: "39149d13de7bdaab77225d45af977d226044344c10ce6ab51d7431ca228e5b8b"
        ),
    ]
)
