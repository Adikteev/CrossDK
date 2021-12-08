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

// MARK: - viewWillAppear

- (void)viewWillAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    [self displayOverlay];
}

// MARK: - viewDidLoad

- (void)viewDidLoad {
    [super viewDidLoad];

    _crossDKOverlay = [[CrossDKOverlay alloc] init];
    _crossDKOverlay.delegate = self;
    _overlayButton.layer.cornerRadius = 18;
}

/// Overlay button clicked.
- (IBAction)overlayButtonPressed:(UIButton *)sender {
    [self displayOverlay];
}

/// Displays an Overlay.
- (void)displayOverlay {
    UIWindow* window = self.view.window;
    if (window != nil) {
        [_crossDKOverlay displayWithWindow:window format:OverlayFormatMid_size position:OverlayPositionBottom withCloseButton:true];
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
