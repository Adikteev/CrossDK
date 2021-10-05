//
//  MainViewController.swift
//  CrossDK demo
//
//  Created by Adikteev on 19/07/2021.
//

import UIKit
import StoreKit
import CrossDK

class MainViewController: UIViewController {
    // MARK: - Outlets

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
    /// Bottom overlay button clicked.
    @IBAction func bottomOverlayButtonPressed(_ sender: Any) {
        guard let window = view.window else { return }

        crossDKOverlay.display(window: window, position: .bottom)
        tapBarView.isHidden = true
        childTapBarView.isHidden = true
        closeOverlayButton.isHidden = false
    }

    /// Bottom raised overlay button clicked.
    @IBAction func bottomRaisedOverlayButtonPressed(_ sender: Any) {
        guard let window = view.window else { return }

        crossDKOverlay.display(window: window, position: .bottomRaised)
        tapBarView.isHidden = false
        childTapBarView.isHidden = false
        closeOverlayButton.isHidden = false
    }

    /// Close overlay button clicked.
    @IBAction func closeOverlayButtonPressed(_ sender: Any) {
        guard let window = view.window else { return }

        crossDKOverlay.dismiss(window: window)
    }
}

// MARK: - Private Funcs

private extension MainViewController {
    /// Setups the UI.
    func setupUI() {
        bottomOverlayButton.layer.cornerRadius = Constants.cornerRadiusButton
        bottomRaisedOverlayButton.layer.cornerRadius = Constants.cornerRadiusButton
        bottomOverlayButton.dropShadow()
        bottomRaisedOverlayButton.dropShadow()
        closeOverlayButton.isHidden = true
        tapBarView.isHidden = true
        childTapBarView.isHidden = true
    }
}

extension MainViewController: CrossDKOverlayDelegate {
    func storeOverlayWillStartPresentation() {
        NSLog("Overlay will start presentation")
    }

    func storeOverlayDidFinishPresentation() {
        NSLog("Overlay did finish presentation")
    }

    func storeOverlayWillStartDismissal() {
        NSLog("Overlay will start dismissal")
    }

    func storeOverlayDidFinishDismissal() {
        NSLog("Overlay did finish dismissal")
    }

    func storeOverlayDidFailToLoad(error: Error) {
        NSLog("Overlay did fail to load")
    }

    func overlayUnavailable(error: CrossDKOverlay.OverlayError) {
        if error == .unsupportedOSVersion {
            NSLog("iOS 14 is required to run CrossDK. Current iOS version is : \(systemVersion)")
        }
    }
}
