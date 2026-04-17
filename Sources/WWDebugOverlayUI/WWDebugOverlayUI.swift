//
//  WWDebugOverlayUI.swift
//  WWDebugOverlayUI
//
//  Created by William.Weng on 2026/4/17.
//

import SwiftUI

public enum WWDebugOverlayUI {}

public extension WWDebugOverlayUI {
    
    @MainActor
    static func makeManager() -> DebugOverlayManager { DebugOverlayManager() }
}
