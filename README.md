# CrossDK 0.0.2

[![Swift Package Manager compatible](https://img.shields.io/badge/Swift%20Package%20Manager-compatible-brightgreen.svg)](#swift-package-manager)
[![CocoaPods compatible](https://img.shields.io/badge/CocoaPods-compatible-4BC51D.svg?style=flat)](#cocoapods)

## Installation

### Swift Package Manager

_Note: Instructions below are for using **SPM** without the Xcode UI. It's easier to go to File > Swift Packages > Add Package Dependencies... and add CrossDK through there._

To integrate using Apple's Swift Package Manager, without Xcode integration, add the following as a dependency to your `Package.swift`:

```swift
.package(url: "https://github.com/Adikteev/CrossDK-release.git", .upToNextMajor(from: "0.0.2"))
```

and then specify `"CrossDK"` as a dependency of the Target in which you wish to use CrossDK.
Here's an example `PackageDescription`:

```swift
// swift-tools-version:5.3
import PackageDescription

let package = Package(
    name: "MyPackage",
    products: [
        .library(
            name: "MyPackage",
            targets: ["MyPackage"]),
    ],
    dependencies: [
        .package(url: "https://github.com/Adikteev/CrossDK-release.git", .upToNextMajor(from: "0.0.2"))
    ],
    targets: [
        .target(
            name: "MyPackage",
            dependencies: ["CrossDK"])
    ]
)
```

### CocoaPods

Add the following entry to your Podfile for CrossDK:

```rb
pod 'CrossDK', :git => 'git@github.com:Adikteev/CrossDK-release.git'
```

Then run `pod install`.

In any file you'd like to use CrossDK in, don't forget to
import the framework with `import CrossDK`.

### Manually

- Open up Terminal, `cd` into your top-level project directory, and run the following command *if* your project is not initialized as a git repository:

```bash
$ git init
```

- Add CrossDK as a git [submodule](http://git-scm.com/docs/git-submodule) by running the following commands:

```bash
$ git submodule add https://github.com/Adikteev/CrossDK-release.git
```

- Open the new `CrossDK-release/Products` folder, and drag the `CrossDK.xcframework` into the Project Navigator of your application's Xcode project. You can put it anywhere inside your project, just make sure you select any target that needs to use CrossDK.

- And that's it!

> XCode will automatically add `CrossDK.xcframework` to your `Link Binary With Libraries` Build Phase.
