// swift-tools-version:5.3
import PackageDescription

let version = "4.15.0"

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
            checksum: "89a2523520aaa6b2a9f07b8a8509a43dc2790649521e04d7f9789d9d55a549bc"
        ),
        .binaryTarget(
            name: "JumioIProov",
            url: "https://repo.mobile.jumio.ai/com/jumio/ios/jumio-mobile-sdk/\(version)/JumioIProov.xcframework.zip",
            checksum: "37e3e757d7ab94e2a290537328d234f8c12444c7bd72742dab896e168f234d0a"
        ),
        .binaryTarget(
            name: "JumioLiveness",
            url: "https://repo.mobile.jumio.ai/com/jumio/ios/jumio-mobile-sdk/\(version)/JumioLiveness.xcframework.zip",
            checksum: "540814cf2d94338b1e868aff0419143b8599a36b6fa7aee1a14038e771c038d7"
        ),
        .binaryTarget(
            name: "JumioDefaultUI",
            url: "https://repo.mobile.jumio.ai/com/jumio/ios/jumio-mobile-sdk/\(version)/JumioDefaultUI.xcframework.zip",
            checksum: "6429b29d4fddbd2c341d67c59caa5e2faca6ec86124734badfb9662556facd8a"
        ),
    ]
)
