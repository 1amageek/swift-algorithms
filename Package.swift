// swift-tools-version:5.7
//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift Algorithms open source project
//
// Copyright (c) 2020 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
//
//===----------------------------------------------------------------------===//

import Foundation
import PackageDescription

let manifestDirectoryURL = URL(fileURLWithPath: #filePath).deletingLastPathComponent()

func localOrForkDependency(_ repository: String, localPath: String) -> Package.Dependency {
  let resolvedLocalPath = URL(fileURLWithPath: localPath, relativeTo: manifestDirectoryURL)
    .standardizedFileURL
    .path
  if FileManager.default.fileExists(atPath: resolvedLocalPath) {
    return .package(path: resolvedLocalPath)
  }

  return .package(url: "https://github.com/1amageek/\(repository).git", branch: "main")
}

let package = Package(
  name: "swift-algorithms",
  products: [
    .library(
      name: "Algorithms",
      targets: ["Algorithms"])
  ],
  dependencies: [
    localOrForkDependency("swift-numerics", localPath: "../swift-numerics")
  ],
  targets: [
    .target(
      name: "Algorithms",
      dependencies: [
        .product(name: "RealModule", package: "swift-numerics")
      ]),
    .testTarget(
      name: "SwiftAlgorithmsTests",
      dependencies: ["Algorithms"]),
  ]
)
