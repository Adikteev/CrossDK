# CrossDK 4.0.0

![IOS](https://img.shields.io/badge/iOS-000000?style=flat&logo=ios&logoColor=white)
[![Swift Package Manager compatible](https://img.shields.io/badge/Swift%20Package%20Manager-compatible-brightgreen.svg)](#swift-package-manager)
[![CocoaPods compatible](https://img.shields.io/badge/CocoaPods-compatible-4BC51D.svg?style=flat)](#cocoapods)

##Table of contents :
  * [UIKit](#uikit)
  * [SwiftUI](#swiftui-support)
  * [Objective-C](#objective-c-support)

## Overview

CrossDK is a solution belonging to Adikteev. The goal is to allow its users to cross-promote their application catalog through the `CrossDKOverlay` class.

### Requirements

**iOS** version **>= 10.0**

CrossDK is available with iOS 10 minimal target version but the `CrossDKOverlay` is only available since iOS 14. CrossDK provides support in order to handle cases where the `CrossDKOverlay ` is not available (see [Overlay Delegate](#overlay-delegate))

## Installation

### Swift Package Manager

_Note: Instructions below are for using **SPM** without the Xcode UI. It's easier to go to `File > Swift Packages > Add Package Dependencies...` and add CrossDK through there._

To integrate using Apple's Swift Package Manager, without Xcode integration, add the following as a dependency to your `Package.swift`:

```swift
.package(url: "https://github.com/Adikteev/crossdk-ios", .upToNextMajor(from: "4.0.0"))
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
        .package(url: "https://github.com/Adikteev/crossdk-ios", .upToNextMajor(from: "4.0.0"))
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
pod 'CrossDK'
```

Then run `pod install`.

### Manually

- Clone CrossDK's repository wherever you like in your project. For this example we will clone it in a `CrossDK-release` directory

```bash
$ git clone https://github.com/Adikteev/crossdk-ios.git CrossDK-release
```
OR

```bash
$ git clone ssh://git@github.com:Adikteev/crossdk-ios.git CrossDK-release
```

- Open the new `CrossDK-release/Products` folder, and drag the `CrossDK.xcframework` into the Project Navigator of your application's Xcode project. You can put it anywhere inside your project, just make sure you select any target that needs to use CrossDK.

- And that's it!

> XCode will automatically add `CrossDK.xcframework` to your Link Binary With Libraries Build Phase.

## Usage

In any file you'd like to use CrossDK in, don't forget to import the framework with `import CrossDK`.

### SwiftUI and Objective-C supports

In order to cover a majority of projects, the `CrossDKOverlay` class is developed in [UIKit](#uikit)  :  
- see SwiftUI support [here](#swiftui-support)  
- see Objective-C support [here](#objective-c-support)

## UIKit

> See an example in the CrossDK-demo UIKit project.

### Configuration

In order to display an overlay properly, CrossDK requires a few informations. Since CrossDK won't work without these, you should set them up as soon as possible. In the following example, we use the setup function inside `AppDelegate`'s application launch but it's up to you to set it up wherever you like.

```swift
import CrossDK

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    [...]

    func application(_ application: UIApplication, 
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
                     
        CrossDKConfig.shared.setup(appId: <YOUR APP ID>,
                                   apiKey: <YOUR API KEY>,
                                   userId: <USER'S ID (optional)>)

        return true
    }
    
    [...]
}
```

### Overlay Usage

All you need to do in order to display an overlay is to retrieve your `UIWindow` object and call the `display` function. Then call it in the `viewDidAppear`.
Here are the configurations for each overlay format :  
- `.banner` : settle its position between `.bottom` or `.bottomRaised`  
- `.mid_size` : settle its position between `.bottom` or `.bottomRaised`, with or without a close button  
- `.interstitial` : settle it with or without a close button, with or without a rewarded

```swift
import CrossDK

final class SomeViewController: UIViewController {
    private let crossDKOverlay = CrossDKOverlay()
    
    private func displayOverlay() {
        guard let window = view.window else { return }

        crossDKOverlay.display(window: window, format: .mid_size, position: .bottom, withCloseButton: true, isRewarded: false)
    }
}
```

A public variable is available in `CrossDKConfig` : `deviceId`, to use custom device to try your recommendations using another device id than yours.
Set it before crossDKOverlay.display function call.

```swift
    CrossDKConfig.shared.deviceId = "My custom device ID"
    crossDKOverlay.display(window: window, format: .banner, position: .bottom, withCloseButton: false, isRewarded: false)
```


### Overlay Delegate

Additionally, a delegate is available if you want to monitor what is happening with the `CrossDKOverlay`. 

Since `CrossDKOverlay` is only available with iOS 14 or higher, you might want, for example, to do something else if the overlay display is unavailable.

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
    
    func overlayUnavailable(error: CrossDKOverlay.OverlayError) {
        switch error {
        case .unsupportedOSVersion:
            // Do something for old iOS versions.
        case .unavailableWindowScene:
            
        case .unavailableRecommendation:
            
        case .noConfiguration:
            
        @unknown default:
            
        }
    }
}
```

## SwiftUI support

In this section, we will see how to integrate it into a SwiftUI project.

> See an example in the CrossDK-demo SwiftUI project.

### Configuration 

In order to display an overlay properly, CrossDK requires a few informations. Since CrossDK won't work without these, you should set them up as soon as possible. In the following example, we use the setup function inside `AppDelegate`'s (create the swift file in your SwiftUI project) application launch but it's up to you to set it up wherever you like.

```swift
import CrossDK

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    [...]

    func application(_ application: UIApplication, 
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
                     
        CrossDKConfig.shared.setup(appId: <YOUR APP ID>,
                                   apiKey: <YOUR API KEY>,
                                   userId: <USER'S ID (optional)>)

        return true
    }
    
    [...]
}
```

In your `App scene`, use the `UIApplicationDelegateAdaptor` property wrapper to tell SwiftUI it should use your `AppDelegate` class for the application delegate.

```swift
import SwiftUI

@main
struct SwiftUIApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
```

### Overlay Usage

All you need to do in order to display an overlay is to retrieve your `UIWindow` object and call the `display` function. Then call it in the `viewDidAppear`.
Here are the configurations for each overlay format :  
- `.banner` : settle its position between `.bottom` or `.bottomRaised`  
- `.mid_size` : settle its position between `.bottom` or `.bottomRaised`, with or without a close button  
- `.interstitial` : settle it with or without a close button, with or without a reward

Let’s create a `UIViewController` subclass named SomeViewController and add some methods to :  
- display an Overlay (to call in the `viewDidAppear`)  
- dismiss the SomeViewController (to call in the `CrossDKOverlayDelegate`)

```swift
import CrossDK

final class SomeViewController: UIViewController {
    private let crossDKOverlay = CrossDKOverlay()
    
    private func displayOverlay() {
        guard let window = view.window else { return }

        crossDKOverlay.display(window: window, format: .mid_size, position: .bottom, withCloseButton: true, isRewarded: false)
    }
    
    private func dismissCrossDKViewController() {
        dismiss(animated: true, completion: nil)
    }
}
```
### Overlay Delegate

Additionally, a delegate is available if you want to monitor what is happening with the `CrossDKOverlay`. 

Now, call the dismissCrossDKViewController() method in the `CrossDKOverlayDelegate` : 

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
    
    func overlayDidFinishDismissal() {
        dismissCrossDKViewController()
    }
}
```

### ContentView :

To use this SomeViewController with SwiftUI, we need to call `UIViewControllerRepresentable` !
Let’s create our SwiftUISomeViewController which conforms to `UIViewControllerRepresentable` :

```swift
struct SwiftUISomeViewController: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> CrossDKOverlayViewController {
        return SomeViewController()
    }

    func updateUIViewController(_ uiViewController: SomeViewController, context: Context) {

    }
}
```

To clear the UIViewControllerRepresentable backgroud, let's create a ClearBackgroundView :

```swift
struct ClearBackgroundView: UIViewRepresentable {
    func makeUIView(context: Context) -> UIView {
        let view = UIView()
        DispatchQueue.main.async {
            view.superview?.superview?.backgroundColor = .clear
        }
        
        return view
    }

    func updateUIView(_ uiView: UIView, context: Context) {}
}
```

Now, create a View to display the overlay independently :

```swift
struct CrossDKOverlayView: View {
    @State private var isVCPresented = false

    internal var body: some View {
        Color.clear
            .frame(width: 0.0, height: 0.0, alignment: .center)
            .onAppear(perform: {
                self.isVCPresented = true
            })
            .fullScreenCover(isPresented: $isVCPresented) {
                ZStack {
                    VStack {
                        SwiftUISomeViewController()
                    }
                }
                .background(ClearBackgroundView())
            }
    }
}
```

And add it in the `ContentView` : 

```swift
struct ContentView: View {
    var body: some View {
        CrossDKOverlayView()
    }
}
```

That’s all you need to know !

## Objective-C support

In this section, we will see how to integrate it into a Objective-C project.

> See an example in the CrossDK-demo Objective-C project.

### Configuration 

#### AppDelegate.h : 

You should `#import "CrossDK/CrossDK-Swift.h"` to use CrossDK.

#### AppDelegate.m :

In order to display an overlay properly, CrossDK requires a few informations. Since CrossDK won't work without these, you should set them up as soon as possible. In the following example, we use the setup function inside `AppDelegate`'s application launch but it's up to you to set it up wherever you like.

```swift
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
	[CrossDKConfig.shared setupWithAppId:<#(NSString * _Nonnull)#> apiKey:<#(NSString * _Nonnull)#> userId:<#(NSString * _Nullable)#>];
    return YES;
}

```
##### Note: `userId` being _Nullable, you can put `nil` if needed.

### Overlay Usage

#### ViewController.h :

You should `#import "CrossDK/CrossDK-Swift.h"` to use CrossDK.

#### ViewController.m :

All you need to do in order to display an overlay is to retrieve your `UIWindow` object and call the `display` function. Then call it in the `viewDidAppear`.
Here are the configurations for each overlay format :  
- `.banner` : settle its position between `.bottom` or `.bottomRaised`  
- `.mid_size` : settle its position between `.bottom` or `.bottomRaised`, with or without a close button  
- `.interstitial` : settle it with or without a close button, with or without a reward

```swift
@interface CrossDKViewController ()
    @property (strong, nonatomic) CrossDKOverlay* crossDKOverlay;
@end

- (void)displayOverlay {
    UIWindow* window = self.view.window;
    if (window != nil) {
        [_crossDKOverlay displayWithWindow:window format:OverlayFormatMid_size position:OverlayPositionBottom withCloseButton:true isRewarded:false];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    [self displayOverlay];
}
```

### Overlay Delegate

Additionally, a delegate is available if you want to monitor what is happening with the `CrossDKOverlay`. 

Since `CrossDKOverlay` is only available with iOS 14 or higher, you might want, for example, to do something else if the overlay display is unavailable.

First, add `<CrossDKOverlayDelegate>` beside `@interface CrossDKViewController ()` and call it in the `viewDidLoad`.

```swift
@interface CrossDKViewController () <CrossDKOverlayDelegate>
    @property (strong, nonatomic) CrossDKOverlay* crossDKOverlay;
@end

- (void)viewDidLoad {
    [super viewDidLoad];

    _crossDKOverlay = [[CrossDKOverlay alloc] init];
    _crossDKOverlay.delegate = self;
}
```
And now, you can access to the `CrossDKOverlayDelegate`.

```swift
[...]

- (void)overlayUnavailableWithError:(enum OverlayError)error {
    switch(error) {
        case OverlayErrorUnsupportedOSVersion:
            NSLog(@"Overlay error: unsupported iOS Version");
            break;
        case OverlayErrorUnavailableWindowScene:
            NSLog(@"Overlay error: unavailable window scene");
            break;
        case OverlayErrorUnavailableRecommendation:
            NSLog(@"Overlay error: unavailable recommendation");
            break;
        case OverlayErrorNoConfiguration:
            NSLog(@"Overlay error: no configuration");
            break;
    }
}
```

That’s all you need to know !

