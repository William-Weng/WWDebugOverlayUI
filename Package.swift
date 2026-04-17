// swift-tools-version:6.1

import PackageDescription

let package = Package(
    name: "WWDebugOverlayUI",
    platforms: [
        .iOS(.v17),
    ],
    products: [
        .library(name: "WWDebugOverlayUI", targets: ["WWDebugOverlayUI"])
    ],
    dependencies: [
        
    ],
    targets: [
        .target(name: "WWDebugOverlayUI", dependencies: [])
    ],
    swiftLanguageModes: [
        .v6
    ]
)
