// swift-tools-version:5.5
import PackageDescription

let version = "4.19.0"

let package = Package(
    name: "Jumio",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v15)
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
            checksum: "7e25432287478eecfa171e9688092701ccab5f6af1c7c14f0005124ef08146a8"
        ),
        .binaryTarget(
            name: "JumioLiveness",
            url: "https://repo.mobile.jumio.ai/com/jumio/ios/jumio-mobile-sdk/\(version)/JumioLiveness.xcframework.zip",
            checksum: "9af0c1ff8d619fa3f318878eeaef9436fb412190ca450d498f08aee487d2365a"
        ),
        .binaryTarget(
            name: "JumioLivenessClient",
            url: "https://repo.mobile.jumio.ai/com/jumio/ios/jumio-mobile-sdk/\(version)/JumioLivenessClient.xcframework.zip",
            checksum: "0d6016959772c86bb283666bf774f40b3591c20602ff99f40cae4ad6363d7c0f"
        ),
        .binaryTarget(
            name: "JumioDefaultUI",
            url: "https://repo.mobile.jumio.ai/com/jumio/ios/jumio-mobile-sdk/\(version)/JumioDefaultUI.xcframework.zip",
            checksum: "e11d274e2d23d5df3fc62f38927a8d7c10c109f38cd6b239752487f2f226712f"
        ),
        .binaryTarget(
            name: "JumioNFC",
            url: "https://repo.mobile.jumio.ai/com/jumio/ios/jumio-mobile-sdk/\(version)/JumioNFC.xcframework.zip",
            checksum: "d3cba8f7e131c8c353cee2697a344c7bb720de990c6895bb5948bf7a6a47bd4b"
        ),
    ]
)
