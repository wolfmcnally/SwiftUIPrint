// swift-tools-version:5.9

import PackageDescription

let package = Package(
    name: "SwiftUIPrint",
    platforms: [
        .iOS(.v17), .macCatalyst(.v17)
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
