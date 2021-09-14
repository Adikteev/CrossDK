// swift-tools-version:5.3
import PackageDescription

let package = Package(
    name: "CrossDK",
    platforms: [
        .iOS(.v10)
    ],
    products: [
        .library(
            name: "CrossDK",
            targets: ["CrossDK"])
    ],
    dependencies: [],
    targets: [
        .binaryTarget(
            name: "CrossDK",
            path: "Products/CrossDK.xcframework"
        )
    ]
)
