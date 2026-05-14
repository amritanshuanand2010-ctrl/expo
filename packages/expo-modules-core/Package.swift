// swift-tools-version: 6.2
import PackageDescription
import Foundation

struct PackageJSON: Decodable {
  let name: String
  let version: String
}

let packageDir = URL(fileURLWithPath: #filePath).deletingLastPathComponent()
let packageJsonData = try Data(contentsOf: packageDir.appendingPathComponent("package.json"))
let packageJson = try JSONDecoder().decode(PackageJSON.self, from: packageJsonData)

let package = Package(
  name: packageJson.name,
  platforms: [
    .iOS("16.4"),
    .tvOS("16.4"),
    .macOS("13.4"),
  ],
  products: [
    .library(
      name: "ExpoModulesCore",
      targets: [
        "ExpoModulesCore",
        "ExpoModulesCoreCommon",
        "ExpoModulesWorklets"
      ]
    ),
  ],
  dependencies: [
    .package(name: "ExpoModulesJSI", path: "../expo-modules-jsi"),
  ],
  targets: [
    .target(
      name: "ExpoModulesCoreCommon",
      dependencies: [],
      path: "common/cpp",
    ),
    .binaryTarget(
      name: "ExpoModulesCore",
      path: "apple/Products/debug/ExpoModulesCore.xcframework",
    ),
    .binaryTarget(
      name: "ExpoModulesWorklets",
      path: "apple/Products/debug/ExpoModulesWorklets.xcframework",
    ),
  ]
)
