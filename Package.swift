// swift-tools-version: 5.7

import PackageDescription

let package = Package(
    name: "APIFetcher",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(
            name: "APIFetcher",
            targets: ["APIFetcher"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "APIFetcher",
            dependencies: []),
        .testTarget(
            name: "APIFetcherTests",
            dependencies: ["APIFetcher"],
            resources: []),
    ],
    swiftLanguageVersions: [.v5]
)
