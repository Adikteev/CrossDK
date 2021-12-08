//
//  CrossDKViewController.swift
//  CrossDK-demo UIKit
//
//  Created by Adikteev on 19/07/2021.
//

import UIKit
import CrossDK

class CrossDKViewController: UIViewController {

    // MARK: - Outlets

    @IBOutlet private var bottomOverlayButton: UIButton!

    // MARK: - Private properties

    private let crossDKOverlay = CrossDKOverlay()
    private let systemVersion = UIDevice.current.systemVersion

    // MARK: - Override Funcs

    override func viewDidLoad() {
        super.viewDidLoad()
        
        crossDKOverlay.delegate = self
        bottomOverlayButton.layer.cornerRadius = 18.0
    }
}

// MARK: - Private Actions

private extension CrossDKViewController {
    /// Bottom overlay button clicked.
    @IBAction func bottomOverlayButtonPressed(_ sender: Any) {
        guard let window = view.window else { return }

        crossDKOverlay.display(window: window, format: .mid_size, position: .bottom, withCloseButton: true)
    }
}

extension CrossDKViewController: CrossDKOverlayDelegate {
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
