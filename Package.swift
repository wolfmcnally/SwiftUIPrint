// swift-tools-version:5.9

import PackageDescription

let package = Package(
    name: "SwiftUIPrint",
    platforms: [
        .iOS(.v15), .macCatalyst(.v15)
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
