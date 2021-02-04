// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "SwiftUIPrint",
    platforms: [
        .iOS(.v14), .macOS(.v11)
    ],
    products: [
        .library(
            name: "SwiftUIPrint",
            targets: ["SwiftUIPrint"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "SwiftUIPrint",
            dependencies: [])
    ]
)
