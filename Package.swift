// swift-tools-version:5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
	name: "Inject",
	platforms: [.iOS(.v15)],
	products: [
		.library(name: "Inject", targets: ["Inject"]),
	],
	dependencies: [],
	targets: [
		.target(
			name: "Inject",
			dependencies: []
		),
		.testTarget(
			name: "InjectTests",
			dependencies: ["Inject"]
		),
	]
)
