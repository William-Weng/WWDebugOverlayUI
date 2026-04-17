//
//  Extension+SwiftUI.swift
//  WWDebugOverlayUI
//
//  Created by William.Weng on 2026/4/17.
//

import SwiftUI

// MARK: - View (@ViewBuilder)
public extension View {
    
    /// 畫面的if功能
    /// - Parameters:
    ///   - condition: 判斷式
    ///   - transform: (Self) -> Content
    /// - Returns: some View
    @ViewBuilder
    func _if<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
        
        if condition {
            transform(self)
        } else {
            self
        }
    }
}

// MARK: - View
public extension View {
    
    /// 將當前 View 的 frame 上報給「全域 debug overlay」，讓它能在整個畫面上顯示該 View 的位置與大小
    /// - Parameters:
    ///   - overlayManager: 全域 debug overlay 狀態管理器
    ///   - name: 在 overlay 上顯示的 View 名稱（例如 "BlueBox"）
    /// - Returns: 套用 `LayoutObserverModifier` 之後的 View
    func observeLayoutInGlobalOverlay(_ overlayManager: WWDebugOverlayUI.DebugOverlayManager, name: String) -> some View {
        
        modifier(
            WWDebugOverlayUI.LayoutObserverModifier(overlayManager: overlayManager, viewName: name)
        )
    }
    
    /// 為當前 View 套用一個「layout debug overlay」，可選擇顯示 bounds、中心線、safe area 等輔助線
    /// - Parameters:
    ///   - showBounds: 是否顯示該 View 的 bounds 框線（預設 true）
    ///   - showCenterLines: 是否顯示水平與垂直中心線（預設 true）
    ///   - showSafeArea: 是否顯示 safe area 範圍（預設 false）
    /// - Returns: 套用 `DebugLayoutModifier` 之後的 View
    func debugLayout(showBounds: Bool = true, showCenterLines: Bool = true, showSafeArea: Bool = false) -> some View {
        
        var modes: Set<WWDebugOverlayUI.DebugOverlayMode> = []
        
        if showBounds { modes.insert(.bounds) }
        if showCenterLines { modes.insert(.centerLines) }
        if showSafeArea { modes.insert(.safeArea) }
        
        return modifier(WWDebugOverlayUI.DebugLayoutModifier(modes: modes))
    }
}

// MARK: - Path
extension Path {
    
    /// 產生框線路徑
    /// - Parameter rect: CGRect
    /// - Returns: Path
    static func boundsPath(at rect: CGRect) -> Path {
        
        Path { path in
            path.addRect(rect)
        }
    }
    
    /// 產生中心垂直線路徑
    /// - Parameter rect: CGRect
    /// - Returns: Path
    static func centerVerticalPath(at rect: CGRect) -> Path {
        
        Path { path in
            path.move(to: CGPoint(x: rect.midX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.midX, y: rect.maxY))
        }
    }
    
    /// 產生中心水平線路徑
    /// - Parameter rect: CGRect
    /// - Returns: Path
    static func centerHorizontalPath(at rect: CGRect) -> Path {
        
        Path { path in
            path.move(to: CGPoint(x: rect.minX, y: rect.midY))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
        }
    }
}
