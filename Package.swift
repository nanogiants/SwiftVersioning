// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftVersioning",
    platforms: [
        .macOS(.v10_14)
    ],
    products: [
        .executable(
            name: "swiftversioning",
            targets: ["SwiftVersioning"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-argument-parser", from: "0.3.0")
    ],
    targets: [
        .target(
            name: "SwiftVersioning",
            dependencies: [
                .product(name: "ArgumentParser", package: "swift-argument-parser")
            ]
        ),
        .testTarget(
            name: "SwiftVersioningTests",
            dependencies: ["SwiftVersioning"]),
    ]
)
