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

    @IBOutlet private var overlayButtons: [UIButton]!

    // MARK: - Private properties

    private let crossDKOverlay = CrossDKOverlay()
    private let systemVersion = UIDevice.current.systemVersion

    // MARK: - Override Funcs

    override func viewDidLoad() {
        super.viewDidLoad()
        
        crossDKOverlay.delegate = self
        overlayButtons.forEach { $0.layer.cornerRadius = 18 }
    }
}

// MARK: - Private Actions

private extension CrossDKViewController {
    /// Overlay button clicked.
    @IBAction func overlayButtonPressed(_ sender: UIButton) {
        guard let window = view.window else { return }

        switch sender {
        case overlayButtons[0]:
            crossDKOverlay.display(window: window, format: .banner, position: .bottom, withCloseButton: true)
        case overlayButtons[1]:
            crossDKOverlay.display(window: window, format: .mid_size, position: .bottom, withCloseButton: true)
        case overlayButtons[2]:
            crossDKOverlay.display(window: window, format: .interstitial, position: .bottom, withCloseButton: true)
        default:
            break
        }
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
