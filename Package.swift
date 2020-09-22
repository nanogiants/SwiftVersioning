// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "swift-versioning",
    platforms: [
        .macOS(.v10_14)
    ],
    products: [
        .executable(name: "swift-versioning", targets: ["swift-versioning"])
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-argument-parser", from: "0.3.0"),
        .package(url: "https://github.com/hmlongco/Resolver.git", from: "1.1.4")
    ],
    targets: [
        .target(
            name: "swift-versioning", dependencies: [
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
                .product(name: "Resolver", package: "Resolver"),
        ]),
        .testTarget(
            name: "swift-versioningTests", dependencies: ["swift-versioning"]),
    ]
)
