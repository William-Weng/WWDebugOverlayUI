//
//  Constant.swift
//  WWDebugOverlayUI
//
//  Created by William.Weng on 2026/4/17.
//

import Foundation

// MARK: - 常數
public extension WWDebugOverlayUI {
        
    /// 表示「畫面 layout debug overlay」的顯示模式，每個 case 代表一種要畫出的輔助線類型。
    enum DebugOverlayMode {
        
        case bounds         /// 畫出 View 的 bounds 框線（外框）
        case centerLines    /// 畫出水平與垂直的中心線，用來確認 View 的對齊與中心位置
        case safeArea       /// 畫出 safe area 的範圍框線，用來觀察內容與安全區的關係
    }
}
