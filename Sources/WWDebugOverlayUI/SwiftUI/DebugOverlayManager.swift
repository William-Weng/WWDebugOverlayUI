//
//  DebugOverlayManager.swift
//  WWDebugOverlayUI
//
//  Created by William.Weng on 2026/4/17.
//

import SwiftUI

/// 管理全域 Debug Overlay 的狀態。
public extension WWDebugOverlayUI {
    
    /// 這個 manager 負責：
    /// - 控制全域 overlay 是否顯示。
    /// - 記錄目前被選取的 view 名稱。
    /// - 記錄目前被選取的 view frame。
    @MainActor
    final class DebugOverlayManager: ObservableObject {
        
        @Published public var isGlobalOverlayVisible: Bool = false  // 是否顯示全域 overlay。
        @Published public var targetViewName: String = ""           // 目前選取的 view 名稱。
        @Published public var targetViewFrame: CGRect = .zero       // 目前選取的 view frame（global 座標）。
        
        init() {}
        
        /// 更新目前選取的目標 view，並同步打開全域 overlay。
        /// - Parameters:
        ///   - viewName: 目標 view 的名稱。
        ///   - frame: 目標 view 在 global 座標系中的 frame。
        public func select(viewName: String, frame: CGRect) {
            targetViewName = viewName
            targetViewFrame = frame
            isGlobalOverlayVisible = true
        }
    }
}
