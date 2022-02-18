//
//  CrossDKViewController.m
//  CrossDK-demo Objective-C
//
//  Created by Adikteev on 09/11/2021.
//

#import "CrossDKViewController.h"

@interface CrossDKViewController () <CrossDKOverlayDelegate>
    @property (strong, nonatomic) CrossDKOverlay* crossDKOverlay;
@end

@implementation CrossDKViewController

// MARK: - viewDidLoad

- (void)viewDidLoad {
    [super viewDidLoad];

    _crossDKOverlay = [[CrossDKOverlay alloc] init];
    _crossDKOverlay.delegate = self;
    for (UIButton *overlayButton in self.overlayButtons) {
        overlayButton.layer.cornerRadius = 18;
    }
}

/// Banner overlay button clicked.
- (IBAction)bannerOverlayButtonPressed:(UIButton *)sender {
    UIWindow* window = self.view.window;
    if (window != nil) {
        [_crossDKOverlay displayWithWindow:window format:OverlayFormatBanner position:OverlayPositionBottom withCloseButton:true];
    }
}

/// Mid size overlay button clicked.
- (IBAction)midSizeOverlayButtonPressed:(UIButton *)sender {
    UIWindow* window = self.view.window;
    if (window != nil) {
        [_crossDKOverlay displayWithWindow:window format:OverlayFormatMid_size position:OverlayPositionBottom withCloseButton:true];
    }
}

/// Interstitial overlay button clicked.
- (IBAction)interstitialOverlayButtonPressed:(UIButton *)sender {
    UIWindow* window = self.view.window;
    if (window != nil) {
        [_crossDKOverlay displayWithWindow:window format:OverlayFormatInterstitial position:OverlayPositionBottom withCloseButton:true];
    }
}

// MARK: - CrossDKOverlayDelegate

- (void)overlayWillStartPresentation {
    NSLog(@"Overlay will start presentation");
}

- (void)overlayDidFinishPresentation {
    NSLog(@"Overlay did finish presentation");
}

- (void)overlayWillStartDismissal {
    NSLog(@"Overlay will start dismissal");
}

- (void)overlayDidFinishDismissal {
    NSLog(@"Overlay did finish dismissal");
}

- (void)overlayStartsPlayingVideo {
    NSLog(@"Overlay starts playingVideo");
}

- (void)overlayPlayedHalfVideo {
    NSLog(@"Overlay played half video");
}

- (void)overlayDidFinishPlayingVideo {
    NSLog(@"Video Overlay did finish playing video");
}

- (void)overlayShowsRecommendedAppInAppStore {
    NSLog(@"Overlay shows recommended app in AppStore");
}

- (void)overlayDidFailToLoadWithError:(NSError * _Nonnull)error {
    NSLog(@"Overlay did fail to load with error : %ld", (long)error);
}

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

@end
