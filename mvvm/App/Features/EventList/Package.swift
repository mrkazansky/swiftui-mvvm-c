// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "EventList",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v14)
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "EventList",
            targets: ["EventList"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        .package(path: "../../Core/Networking"),
        .package(path: "../../Core/Model"),
        .package(path: "../../Core/Utilities"),
        .package(url: "https://github.com/onevcat/Kingfisher.git", from: "7.6.2"),
        .package(url: "https://github.com/Iaenhaall/AttributedText", from: "1.2.0"),
        .package(url: "https://github.com/nalexn/ViewInspector", from: "0.9.5"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "EventList",
            dependencies: ["Networking", "Utilities", "Model", "AttributedText", "Kingfisher"],
            resources: [.process("Resources")]),
        .testTarget(
            name: "EventListTests",
            dependencies: ["EventList", "ViewInspector"]),
    ]
)
