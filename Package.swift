// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "borealis-kit",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(
            name: "BorealisKit",
            targets: ["BorealisKit"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "BorealisKit",
            dependencies: [],
            resources: [
                .process("Documentation.docc")
            ]),
        .testTarget(
            name: "BorealisKitTests",
            dependencies: ["BorealisKit"]),
    ]
)
