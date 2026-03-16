// swift-tools-version:5.3
import PackageDescription

let version = "4.17.0"

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
            checksum: "9a3b0665996e9d387768a9159a6c0f01a12c0472f56179253ff8d1daaeae6f74"
        ),
        .binaryTarget(
            name: "JumioLiveness",
            url: "https://repo.mobile.jumio.ai/com/jumio/ios/jumio-mobile-sdk/\(version)/JumioLiveness.xcframework.zip",
            checksum: "4ad19bd8898b3b03fef8fc4e857885c47e97ff0a676eae28af6cf08ef087edac"
        ),
        .binaryTarget(
            name: "JumioLivenessClient",
            url: "https://repo.mobile.jumio.ai/com/jumio/ios/jumio-mobile-sdk/\(version)/JumioLivenessClient.xcframework.zip",
            checksum: "9c8068d2e1c2ad66fbed1fd7acc8d24115b9fa0b19362061c4c649857f545a82"
        ),
        .binaryTarget(
            name: "JumioDefaultUI",
            url: "https://repo.mobile.jumio.ai/com/jumio/ios/jumio-mobile-sdk/\(version)/JumioDefaultUI.xcframework.zip",
            checksum: "7ce611f2c84a9e3e3943d9c2e78bffd34df2428809590e453262a1cd45ae5ab8"
        ),
        .binaryTarget(
            name: "JumioNFC",
            url: "https://repo.mobile.jumio.ai/com/jumio/ios/jumio-mobile-sdk/\(version)/JumioNFC.xcframework.zip",
            checksum: "c484653fff2c2faddb52dbd1797c9d9e7a258ae200adebf400026fdbe556c28e"
        ),
    ]
)
