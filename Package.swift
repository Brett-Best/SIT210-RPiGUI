// swift-tools-version:4.0

import PackageDescription

#if os(macOS)

let package = Package(
  name: "RPiGUI",
  dependencies: [
    .package(url: "https://github.com/uraimo/SwiftyGPIO.git", .branch("master")),
    .package(url: "https://github.com/Brett-Best/SwiftGtk.git", .branch("master"))
  ],
  targets: [
    .target(name: "RPiGUI", dependencies: ["SwiftyGPIO", "Gtk"]),
  ]
)

#else

let package = Package(
  name: "RPiGUI",
  dependencies: [
    .package(url: "https://github.com/uraimo/SwiftyGPIO.git", .branch("master")),
    .package(url: "https://github.com/Brett-Best/SwiftGtk.git", .branch("bb-pkg-dev"))
  ],
  targets: [
    .target(name: "RPiGUI", dependencies: ["SwiftyGPIO", "Gtk"]),
  ]
)

#endif
