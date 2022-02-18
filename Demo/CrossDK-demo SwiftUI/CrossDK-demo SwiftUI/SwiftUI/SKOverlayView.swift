//
//  SKOverlayView.swift
//  CrossDK-demo SwiftUI
//
//  Created by Adikteev on 03/11/2021.
//
//  NOTE : To use this app, configure the CrossDK in AppDelegate.swift and run it on a real device.
//  To call the Overlay independently, go to the 'Perform the overlay independently' Mark.

import SwiftUI

// MARK: - SKOverlayView

struct SKOverlayView: View {
    internal var body: some View {
        VStack {
            HStack() {
                Text("CrossDK demo - SwiftUI")
                    .font(.system(size: 24, weight: .bold))
                    .frame(maxWidth: .infinity, alignment: .center)
                Spacer()
            }
        }
        .padding(.horizontal)
        .padding(.top, 20)
        Spacer()
        ZStack {
            BannerOverlayButton()
            MidSizeOverlayButton()
            InterstitialOverlayButton()
        }
        Spacer()
    }
}

// MARK: - BannerOverlayButton

struct BannerOverlayButton: View {
    /// Create a fullScreenCover and call the SwiftUICrossDKOverlayViewController and the ClearBackgroundView.
    /// To perform the overlay independently, please go to the bottom of this page or to the README file.
    @State private var isVCPresented = false

    internal var body: some View {
        Button("Show banner overlay") {
            self.isVCPresented = true
            print("banner")
        }
        .buttonStyle(ButtonShape())
        .offset(x: 0, y: -66)
        .fullScreenCover(isPresented: $isVCPresented) {
            ZStack {
                VStack {
                    SwiftUIBannerOverlayViewController()
                }
            }
            .background(ClearBackgroundView())
        }
    }
}

// MARK: - MidSizeOverlayButton

struct MidSizeOverlayButton: View {
    @State private var isVCPresented = false

    internal var body: some View {
        Button("Show mid size overlay") {
            self.isVCPresented = true
            print("mid size")
        }
        .buttonStyle(ButtonShape())
        .offset(x: 0, y: 0)
        .fullScreenCover(isPresented: $isVCPresented) {
            ZStack {
                VStack {
                    SwiftUIMidSizeOverlayViewController()
                }
            }
            .background(ClearBackgroundView())
        }
    }
}

// MARK: - InterstitialOverlayButton

struct InterstitialOverlayButton: View {
    @State private var isVCPresented = false

    internal var body: some View {
        Button("Show interstitial overlay") {
            self.isVCPresented = true
            print("interstitial")
        }
        .buttonStyle(ButtonShape())
        .offset(x: 0, y: +66)
        .fullScreenCover(isPresented: $isVCPresented) {
            ZStack {
                VStack {
                    SwiftUIInterstitialOverlayViewController()
                }
            }
            .background(ClearBackgroundView())
        }
    }
}

// MARK: - ButtonShapeStyle

struct ButtonShape: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(width: 260, height: 50, alignment: .center)
            .background(Color(#colorLiteral(red: 0.004781197757, green: 0.09419874102, blue: 0.5764622092, alpha: 1)))
            .foregroundColor(.white)
            .font(.system(size: 16, weight: .semibold, design: .rounded))
            .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
    }
}

// MARK: - ClearBackgroundView

/// Create a ClearBackgroundView to use the UIViewControllerRepresentable.
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

// MARK: - SwiftUIBannerOverlayViewController

/// Create a UIViewControllerRepresentable to call a UIViewController.
struct SwiftUIBannerOverlayViewController: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> BannerOverlayViewController {
        return BannerOverlayViewController()
    }

    func updateUIViewController(_ uiViewController: BannerOverlayViewController, context: Context) {

    }
}

// MARK: - SwiftUIBannerOverlayViewController

/// Create a UIViewControllerRepresentable to call a UIViewController.
struct SwiftUIMidSizeOverlayViewController: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> MidSizeOverlayViewController {
        return MidSizeOverlayViewController()
    }

    func updateUIViewController(_ uiViewController: MidSizeOverlayViewController, context: Context) {

    }
}

// MARK: - SwiftUIInterstitialOverlayViewController

/// Create a UIViewControllerRepresentable to call a UIViewController.
struct SwiftUIInterstitialOverlayViewController: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> InterstitialOverlayViewController {
        return InterstitialOverlayViewController()
    }

    func updateUIViewController(_ uiViewController: InterstitialOverlayViewController, context: Context) {

    }
}

// MARK: - SKOverlayView_Previews

struct SKOverlayView_Previews: PreviewProvider {
    static var previews: some View {
        SKOverlayView()
    }
}

// MARK: - Perform the overlay independently

/// To call the Overlay independently, add this sample code in the body of the SKOverlayView struct :
/// Note : it may be necessary to relaunch the application after building it to permfor the overlay independently.
struct IndependantOverlayExample: View {
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
                        SwiftUIBannerOverlayViewController()
                    }
                }
                .background(ClearBackgroundView())
            }
    }
}
