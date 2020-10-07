// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftVersioning",
    platforms: [
        .macOS(.v10_14)
    ],
    products: [
        .executable(name: "swift-versioning", targets: ["SwiftVersioning"])
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-argument-parser", from: "0.3.0"),
        .package(url: "https://github.com/hmlongco/Resolver.git", from: "1.1.4"),
        .package(url: "https://github.com/apple/swift-log.git", from: "1.0.0"),
    ],
    targets: [
        .target(
            name: "SwiftVersioning", dependencies: [
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
                .product(name: "Resolver", package: "Resolver"),
                .product(name: "Logging", package: "swift-log"),
        ]),
    ]
)
