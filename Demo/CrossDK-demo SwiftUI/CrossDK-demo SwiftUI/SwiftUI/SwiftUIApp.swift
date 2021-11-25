//
//  CrossDK_Demo_SwiftUIApp.swift
//  CrossDK-demo SwiftUI
//
//  Created by Adikteev on 03/11/2021.
//
//  NOTE : To use this app, configure the CrossDK in AppDelegate.swift and run it on a real device.

import SwiftUI

@main
struct CrossDK_Demo_SwiftUIApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            SKOverlayView()
        }
    }
}
