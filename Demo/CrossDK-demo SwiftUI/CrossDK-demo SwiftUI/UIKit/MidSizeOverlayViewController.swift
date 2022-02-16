//
//  MidSizeOverlayViewController.swift
//  CrossDK-demo SwiftUI
//
//  Created by Adikteev on 28/01/2022.
//

import UIKit
import CrossDK

class MidSizeOverlayViewController: UIViewController {

    // MARK: - Private properties

    private let crossDKOverlay = CrossDKOverlay()
    private let systemVersion = UIDevice.current.systemVersion

    // MARK: - Override Funcs

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        displayOverlay()
        crossDKOverlay.delegate = self
    }
}

// MARK: - Private Funcs

extension MidSizeOverlayViewController {

    /// Displays an Overlay.
    private func displayOverlay() {
        guard let window = view.window else { return }

        crossDKOverlay.display(window: window, format: .mid_size, position: .bottom, withCloseButton: true)
    }

    /// Dismisses the MidSizeOverlayViewController.
    private func dismissMidSizeOverlayViewController() {
        dismiss(animated: true, completion: nil)
    }
}

// MARK: - CrossDKOverlayDelegate

extension MidSizeOverlayViewController: CrossDKOverlayDelegate {
    func overlayWillStartPresentation() {
        NSLog("Overlay will start presentation")
    }

    func overlayDidFinishPresentation() {
        NSLog("Overlay did finish presentation")
    }

    func overlayWillStartDismissal() {
        NSLog("Overlay will start dismissal")
    }

    func overlayDidFinishDismissal() {
        NSLog("Overlay did finish dismissal")
        dismissMidSizeOverlayViewController()
    }

    func overlayStartsPlayingVideo() {
        NSLog("Overlay starts playing video")
    }

    func overlayPlayedHalfVideo() {
        NSLog("Overlay played half video")
    }

    func overlayDidFinishPlayingVideo() {
        NSLog("Overlay did finish playing video")
    }

    func overlayShowsRecommendedAppInAppStore() {
        NSLog("Overlay shows recommended app in App Store")
    }

    func overlayDidFailToLoad(error: Error) {
        NSLog("Overlay did fail to load with error: \(error)")
    }

    func overlayUnavailable(error: CrossDKOverlay.OverlayError) {
        switch error {
        case .unsupportedOSVersion:
            NSLog("iOS 14 is required to run CrossDK. Current iOS version is: \(systemVersion)")
        case .unavailableWindowScene:
            NSLog("Unavailable WindowScene")
        case .unavailableRecommendation:
            NSLog("Unavailable Recommendation")
        case .noConfiguration:
            NSLog("No configuration WindowScene")
        @unknown default:
            NSLog("Overlay unavailable")
        }
    }
}

