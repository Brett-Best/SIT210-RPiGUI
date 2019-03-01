// swift-tools-version:4.0

import PackageDescription

let package = Package(
  name: "RPiGUI",
  dependencies: [
    .package(url: "https://github.com/uraimo/SwiftyGPIO.git", .branch("master")),
    .package(url: "https://github.com/rhx/SwiftGtk.git", .branch("master")),
  ],
  targets: [
  .target(name: "RPiGUI", dependencies: ["SwiftyGPIO", "Gtk"]),
  ]
)
