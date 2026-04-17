//
//  ViewModifier.swift
//  WWDebugOverlayUI
//
//  Created by William.Weng on 2026/4/17.
//

import SwiftUI

// MARK: - ViewModifier
public extension WWDebugOverlayUI {
    
    /// 觀察某個 View 的幾何資訊，並把它的 global frame 回報給 DebugOverlayManager。這樣全域 overlay 就能根據最新位置，畫出目標 View 的外框與資訊。
    struct LayoutObserverModifier: ViewModifier {
        
        @ObservedObject public var overlayManager: DebugOverlayManager  /// 全域 debug overlay 的狀態管理器
        
        public let viewName: String
        
        public func body(content: Content) -> some View {
            content
                .background(
                    GeometryReader { proxy in
                        Color.clear
                            .onAppear { updateFrame(proxy) }
                            .onChange(of: proxy.size) { _ in updateFrame(proxy) }
                            .onChange(of: viewName) { _ in updateFrame(proxy) }
                    }
                )
        }
        
        /// 更新目前 View 在 global 座標系中的 frame，並同步到 overlayManager
        /// - Parameter proxy: GeometryProxy，用來取得當前 View 的 frame
        private func updateFrame(_ proxy: GeometryProxy) {
            
            let frame = proxy.frame(in: .global)
            overlayManager.targetViewName = viewName
            overlayManager.targetViewFrame = frame
        }
    }
}

// MARK: - ViewModifier
extension WWDebugOverlayUI {
    
    /// 為任意 SwiftUI View 提供「debug layout overlay」的功能，可以在 Debug 模式下開啟，Release 時則不會繪製任何 debug 線。
    struct DebugLayoutModifier: ViewModifier {
        
        let modes: Set<DebugOverlayMode>
        
        #if DEBUG
            @AppStorage("SwiftUIDebugLayout_InlineEnabled") private var isEnabled = true
        #else
            private var isEnabled = false
        #endif
        
        func body(content: Content) -> some View {
            
            content._if(isEnabled) { content in
                content.overlay(DebugOverlay(modes: modes))
            }
        }
    }
}
