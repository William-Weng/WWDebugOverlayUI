//
//  ExampleApp.swift
//  Example
//
//  Created by William.Weng on 2026/4/17.
//

import SwiftUI
import WWDebugOverlayUI

@main
struct ExampleApp: App {
    
    @StateObject private var overlayManager = WWDebugOverlayUI.makeManager()
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                ContentView()
                
                if overlayManager.isGlobalOverlayVisible {
                    WWDebugOverlayUI.DebugGlobalOverlay()
                        .ignoresSafeArea()
                        .allowsHitTesting(false)
                }
            }
            .environmentObject(overlayManager)
        }
    }
}
