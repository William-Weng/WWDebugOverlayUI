//
//  DebugBox.swift
//  WWDebugOverlayUI
//
//  Created by William.Weng on 2026/4/17.
//

import SwiftUI

// MARK: - 可點擊的除錯元件
public extension WWDebugOverlayUI {
    
    /// 這個元件會包住你傳入的內容，並在點擊時回報自己的名稱與全域 frame 給 `DebugOverlayManager`。適合拿來做 debug overlay 的互動範例或測試元件。
    struct DebugBox<Content: View>: View {
        
        @EnvironmentObject private var overlayManager: DebugOverlayManager
        @State private var frame: CGRect = .zero
        
        public let name: String
        public let isSelected: Bool
        public let onSelect: () -> Void
        public let cornerRadius: CGFloat
        public let selectedBorderColor: Color
        public let selectedBorderWidth: CGFloat
        public let content: Content
        
        /// 建立一個可點擊的除錯元件。
        /// - Parameters:
        ///   - name: 傳給 overlay 顯示的名稱。
        ///   - isSelected: 是否顯示選取外框。
        ///   - cornerRadius: 選取外框的圓角半徑。
        ///   - selectedBorderColor: 選取外框的顏色。
        ///   - selectedBorderWidth: 選取外框的線寬。
        ///   - onSelect: 點擊時額外執行的動作。
        ///   - content: 元件內部顯示的內容。
        public init(name: String, isSelected: Bool, cornerRadius: CGFloat = 8, selectedBorderColor: Color = .yellow, selectedBorderWidth: CGFloat = 3, onSelect: @escaping () -> Void, @ViewBuilder content: () -> Content) {
            self.name = name
            self.isSelected = isSelected
            self.cornerRadius = cornerRadius
            self.selectedBorderColor = selectedBorderColor
            self.selectedBorderWidth = selectedBorderWidth
            self.onSelect = onSelect
            self.content = content()
        }
        
        public var body: some View {
            content
                .contentShape(Rectangle())
                .background {
                    GeometryReader { proxy in
                        Color.clear
                            .onAppear { frame = proxy.frame(in: .global) }
                            .onChange(of: proxy.size) { _ in frame = proxy.frame(in: .global) }
                    }
                }
                .onTapGesture {
                    onSelect()
                    overlayManager.select(viewName: name, frame: frame)
                }
        }
    }
}
