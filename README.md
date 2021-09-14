# CrossDK 0.1.1

[![Swift Package Manager compatible](https://img.shields.io/badge/Swift%20Package%20Manager-compatible-brightgreen.svg)](#swift-package-manager)
[![CocoaPods compatible](https://img.shields.io/badge/CocoaPods-compatible-4BC51D.svg?style=flat)](#cocoapods)

## Overview

CrossDK is a solution belonging to Adikteev. The goal is to allow its users to cross-promote their application catalog through the `SKOverlay` class.

### Requirements

**iOS** version **>= 10.0**

CrossDK is available with iOS 10 minimal target version but the `SKOverlay` is only available since iOS 14. CrossDK provides support in order to handle cases where the `SKOverlay` is not available (see [Overlay Delegate](#overlay-delegate))

## Installation

### Swift Package Manager

_Note: Instructions below are for using **SPM** without the Xcode UI. It's easier to go to `File > Swift Packages > Add Package Dependencies...` and add CrossDK through there._

To integrate using Apple's Swift Package Manager, without Xcode integration, add the following as a dependency to your `Package.swift`:

```swift
.package(url: "https://github.com/Adikteev/CrossDK-release.git", .upToNextMajor(from: "0.1.1"))
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
        .package(url: "https://github.com/Adikteev/CrossDK-release.git", .upToNextMajor(from: "0.1.1"))
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

### Manually

- Clone CrossDK's repository wherever you like in your project. For this example we will clone it in a `CrossDK-release` directory

```bash
$ git clone https://github.com/Adikteev/CrossDK-release.git CrossDK-release
```
OR

```bash
$ git clone ssh://git@github.com:Adikteev/CrossDK-release.git CrossDK-release
```

- Open the new `CrossDK-release/Products` folder, and drag the `CrossDK.xcframework` into the Project Navigator of your application's Xcode project. You can put it anywhere inside your project, just make sure you select any target that needs to use CrossDK.

- And that's it!

> XCode will automatically add `CrossDK.xcframework` to your Link Binary With Libraries Build Phase.

## Usage

In any file you'd like to use CrossDK in, don't forget to import the framework with `import CrossDK`.

### Configuration

In order to display overlays properly, CrossDK requires a few informations. Since CrossDK won't work without these, you should set them up as soon as possible. In the following example, we use the setup function inside `AppDelegate`'s application launch but it's up to you to set it up wherever you like.

```swift
import CrossDK

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    [...]

    func application(_ application: UIApplication, 
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
                     
        CrossDKConfig.shared.setup(appId: <YOUR APP ID>,
                                   apiKey: <YOUR API KEY>,
                                   userId: <USER'S IDFA (optional)>)

        return true
    }
    
    [...]
}
```

### Overlay Usage

All you need to do in order to display an overlay is to retrieve your `UIWindow` object and call the `display` function. A `dismiss` function is available as well if you want to programmatically dismiss a previously displayed overlay.

```swift
import CrossDK

final class SomeViewController: UIViewController {
    private let crossDKOverlay = CrossDKOverlay()
    
    private func displayOverlay() {
        guard let window = view.window else { return }

        crossDKOverlay.display(window: window, position: .bottom)
    }
}
```

### Overlay Delegate

Additionally, a delegate is available if you want to monitor what is happening with the `CrossDKOverlay`. 

Since `SKOverlay` is only available with iOS 14 or higher, you might want, for example, to do something else if the overlay display is unavailable.

```swift
import CrossDK

final class SomeViewController: UIViewController {
    private let crossDKOverlay = CrossDKOverlay()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        crossDKOverlay.delegate = self
    }
}

extension SomeViewController: CrossDKOverlayDelegate {
    [...]
    
    func overlayUnavaible(error: CrossDKOverlay.OverlayError) {
        if error == .unsupportedOSVersion {
            // Do something for old iOS versions.
        }
    }
}
```
