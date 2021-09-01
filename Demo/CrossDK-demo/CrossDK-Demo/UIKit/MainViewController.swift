//
//  CrossDKAPIAnswerViewController.swift
//  CrossDK demo
//
//  Created by Steven VAILLE on 19/07/2021.
//

import UIKit
import StoreKit
import CrossDK

class MainViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet private var swiftUIButton: UIButton!
    @IBOutlet private var bottomOverlayButton: UIButton!
    @IBOutlet private var bottomRaisedOverlayButton: UIButton!
    @IBOutlet private var closeOverlayButton: UIButton!
    @IBOutlet private var tapBarView: UIVisualEffectView!
    @IBOutlet private var childTapBarView: UIVisualEffectView!

    // MARK: - Private properties
    private let crossDKOverlay = CrossDKOverlay()
    private let systemVersion = UIDevice.current.systemVersion

    // MARK: - Private Enums
    private enum Constants {
        static let cornerSwiftUIButton: CGFloat = 25.0
        static let cornerRadiusButton: CGFloat = 18.0
    }

    // MARK: - Override Funcs
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

// MARK: - Private Actions
private extension MainViewController {
    /// SwiftUI button clicked.
    @IBAction func swiftUIButtonPressed(_ sender: Any) {
        if #available(iOS 13.0, *) {
            dismissOverlay()
            //            let skOverlayView = SKOverlayView(dismiss: {
            //                self.dismiss(animated: true, completion: nil)
            //            })
            //            let skOverlayViewController = UIHostingController(rootView: skOverlayView)
            //            skOverlayViewController.modalPresentationStyle = .fullScreen
            //            present(skOverlayViewController, animated: true)
            swiftUIAlertMessage()
        } else {
            iOSIncompatibilityVersionAlertMessage()
        }
    }

    /// Bottom overlay button clicked.
    @IBAction func bottomOverlayButtonPressed(_ sender: Any) {
        if #available(iOS 14.0, *) {
            guard let window = view.window else { return }

            crossDKOverlay.display(window: window, position: .bottom)
            tapBarView.isHidden = true
            childTapBarView.isHidden = true
            closeOverlayButton.isHidden = false
        } else {
            iOSIncompatibilityVersionAlertMessage()
        }
    }

    /// Bottom raised overlay button clicked.
    @IBAction func bottomRaisedOverlayButtonPressed(_ sender: Any) {
        if #available(iOS 14.0, *) {
            guard let window = view.window else { return }

            crossDKOverlay.display(window: window, position: .bottomRaised)
            tapBarView.isHidden = false
            childTapBarView.isHidden = false
            closeOverlayButton.isHidden = false
        } else {
            iOSIncompatibilityVersionAlertMessage()
        }
    }

    /// Close overlay button clicked.
    @IBAction func closeOverlayButtonPressed(_ sender: Any) {
        if #available(iOS 14.0, *) {
            dismissOverlay()
        } else {
            iOSIncompatibilityVersionAlertMessage()
        }
    }
}

// MARK: - Private Funcs
private extension MainViewController {
    /// Presents an UIAlertController if the iOS version is is not compatible with the CrossDK.
    func iOSIncompatibilityVersionAlertMessage() {
        let alert = UIAlertController(title: "Old iOS version",
                                      message: "iOS 14 is required to run CrossDK.\nYour current iOS version is : " + systemVersion,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK",
                                      style: .default,
                                      handler: nil))
        self.present(alert,
                     animated: true)

    }

    /// Setups the UI.
    func setupUI() {
        bottomOverlayButton.layer.cornerRadius = Constants.cornerRadiusButton
        bottomRaisedOverlayButton.layer.cornerRadius = Constants.cornerRadiusButton
        bottomOverlayButton.dropShadow()
        bottomRaisedOverlayButton.dropShadow()
        swiftUIButton.dropShadow()
        swiftUIButton.layer.cornerRadius = Constants.cornerSwiftUIButton
        closeOverlayButton.isHidden = true
        tapBarView.isHidden = true
        childTapBarView.isHidden = true
    }

    /// Dismisses the Overlay view.
    func dismissOverlay() {
        if #available(iOS 14.0, *) {
            guard let window = view.window else { return }

            crossDKOverlay.dismiss(window: window)
            closeOverlayButton.isHidden = true
        } else {
            iOSIncompatibilityVersionAlertMessage()
        }
    }

    /// Presents an UIAlertController for future Swift UI demo screen integration.
    func swiftUIAlertMessage() {
        let alert = UIAlertController(title: "Available soon",
                                      message: "We working hard to bring you the SwiftUI version as soon as possible.",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK",
                                      style: .default,
                                      handler: nil))
        self.present(alert,
                     animated: true)
    }
}
