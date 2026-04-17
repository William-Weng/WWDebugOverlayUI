//
//  DebugGlobalOverlay.swift
//  WWDebugOverlayUI
//
//  Created by William.Weng on 2026/4/17.
//

import SwiftUI

// MARK: - 全域的lOverlay
public extension WWDebugOverlayUI {
    
    struct DebugGlobalOverlay: View {
        
        @EnvironmentObject private var overlayManager: DebugOverlayManager
        
        public init() {}
        
        public var body: some View {
            GeometryReader { proxy in
                drawLine(at: proxy, targetFrame: overlayManager.targetViewFrame)
            }
            .allowsHitTesting(false)
        }
    }
}

// MARK: - Layout
private extension WWDebugOverlayUI.DebugGlobalOverlay {
    
    /// 繪出完整的外框、安全區與資訊欄
    /// - Parameters:
    ///   - proxy: GeometryProxy
    ///   - targetFrame: 目標 View 的 global frame
    /// - Returns: 畫面上的 debug overlay
    @ViewBuilder
    func drawLine(at proxy: GeometryProxy, targetFrame: CGRect?) -> some View {
        ZStack(alignment: .topLeading) {
            
            drawOverlayBorder(at: proxy)
            
            if let frame = targetFrame { drawTarget(at: proxy, frame: frame) }
            
            drawTargetInformation(at: proxy, targetFrame: targetFrame)
                .padding(.leading, 8)
                .padding(.top, 8)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
    }
}

// MARK: - Shape
private extension WWDebugOverlayUI.DebugGlobalOverlay {
    
    /// 繪出整個 overlay 的外框
    /// - Parameter proxy: GeometryProxy
    /// - Returns: overlay 外框
    @ViewBuilder
    func drawOverlayBorder(at proxy: GeometryProxy) -> some View {
        let fullSize = proxy.size
        
        Rectangle()
            .stroke(Color.red.opacity(0.6), lineWidth: 5)
            .frame(width: fullSize.width, height: fullSize.height)
    }
    
    /// 繪出目標 View 的外框
    /// - Parameters:
    ///   - proxy: GeometryProxy
    ///   - frame: 目標 View 的 global frame
    /// - Returns: 目標框線
    @ViewBuilder
    func drawTarget(at proxy: GeometryProxy, frame: CGRect) -> some View {
        
        let overlayFrame = proxy.frame(in: .global)
        let x = frame.minX - overlayFrame.minX
        let y = frame.minY - overlayFrame.minY
        
        RoundedRectangle(cornerRadius: 2)
            .stroke(.yellow.opacity(0.5), lineWidth: 10)
            .frame(width: frame.width, height: frame.height)
            .offset(x: x, y: y)
    }
}

// MARK: - Information
private extension WWDebugOverlayUI.DebugGlobalOverlay {
    
    /// 繪出目標 View 的尺寸與位置資訊
    /// - Parameters:
    ///   - proxy: GeometryProxy
    ///   - targetFrame: 目標 View 的 global frame
    /// - Returns: 資訊欄
    @ViewBuilder
    func drawTargetInformation(at proxy: GeometryProxy, targetFrame: CGRect?) -> some View {
        let fullSize = proxy.size
        
        VStack(alignment: .leading, spacing: 4) {
            
            Text("Overlay: \(Int(fullSize.width)) × \(Int(fullSize.height))")
                .font(.caption2)
                .foregroundColor(.white)
                .padding(4)
                .background(Color.black.opacity(0.7))
                .cornerRadius(6)
            
            if let frame = targetFrame {
                
                drawTextField(name: overlayManager.targetViewName, frame: frame)
                    .padding(4)
                    .background(Color.black.opacity(0.7))
                    .cornerRadius(6)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
    }
    
    /// 繪出文字資訊欄
    /// - Parameters:
    ///   - name: String
    ///   - frame: CGRect
    /// - Returns: View
    @ViewBuilder
    func drawTextField(name: String, frame: CGRect)  -> some View {
        
        VStack(alignment: .leading, spacing: 2) {
            
            Text(name)
                .font(.caption2)
                .foregroundColor(.yellow)
            
            Text("Target: x=\(Int(frame.minX)), y=\(Int(frame.minY))")
                .font(.caption2)
                .foregroundColor(.white)
            
            Text("Target: w=\(Int(frame.width)), h=\(Int(frame.height))")
                .font(.caption2)
                .foregroundColor(.white)
        }
    }
}
