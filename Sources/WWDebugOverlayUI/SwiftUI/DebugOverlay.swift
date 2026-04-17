//
//  DebugOverlay.swift
//  WWDebugOverlayUI
//
//  Created by William.Weng on 2026/4/17.
//

import SwiftUI

// MARK: - 公開工具
extension WWDebugOverlayUI {
    
    /// 一個 SwiftUI View，用來在畫面上畫「layout debug 輔助線」，包括 bounds 框線、中心線與 safe area 等，可由外界決定顯示模式。
    struct DebugOverlay: View {
        
        let modes: Set<DebugOverlayMode>
        
        var body: some View {
            
            GeometryReader { proxy in
                drawLine(at: proxy, modes: modes)
            }
            .allowsHitTesting(false)
        }
    }
}

// MARK: - 小工具
private extension WWDebugOverlayUI.DebugOverlay {
    
    /// 根據給定的 GeometryProxy 與顯示模式，畫出對應的 layout 輔助線
    /// - Parameters:
    ///   - proxy: SwiftUI 提供的 GeometryProxy，可取得 View 的 frame 與 safe area
    ///   - modes: 要畫出的 debug 模式集合
    /// - Returns: 包含多條路徑與線條的 Group View
    func drawLine(at proxy: GeometryProxy, modes: Set<WWDebugOverlayUI.DebugOverlayMode>) -> some View {
        
        let rect = proxy.frame(in: .local)
        let inset = proxy.safeAreaInsets
        
        return Group {
            
            if modes.contains(.bounds) {
                Path.boundsPath(at: rect)
                    .stroke(.red.opacity(0.8), lineWidth: 1)
            }
            
            if modes.contains(.centerLines) {
                
                Path.centerVerticalPath(at: rect)
                    .stroke(.green.opacity(0.7), lineWidth: 0.5)
                
                Path.centerHorizontalPath(at: rect)
                    .stroke(.blue.opacity(0.7), lineWidth: 0.5)
            }
            
            if modes.contains(.safeArea) {
                Rectangle()
                    .stroke(.orange, lineWidth: 1)
                    .padding(inset)
            }
        }
    }
}

