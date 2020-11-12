// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "abjc-ui",
    defaultLocalization: "en",
    platforms: [
        .macOS(.v10_15),
        .iOS(.v14),
        .tvOS(.v14)
    ],
    products: [
        .library(
            name: "abjc-ui",
            targets: ["abjc-ui"]),
    ],
    dependencies: [
        .package(name: "abjc-core", url: "https://github.com/ABJC/abjc-core", .upToNextMajor(from: "1.0.0-build.7")),
        .package(name: "abjc-api", url: "https://github.com/ABJC/abjc-api", .upToNextMajor(from: "1.0.0-build.7")),
        .package(name: "URLImage", url: "https://github.com/dmytro-anokhin/url-image", from: "2.1.4")
    ],
    targets: [
        .target(
            name: "abjc-ui",
            dependencies: ["URLImage", "abjc-core", "abjc-api"]),
        .testTarget(
            name: "abjc-uiTests",
            dependencies: ["abjc-ui"])
    ]
)
