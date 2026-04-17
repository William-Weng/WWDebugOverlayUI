# [WWDebugOverlayUI](https://swiftpackageindex.com/William-Weng)
![SwiftUI](https://img.shields.io/badge/SwiftUI-524520?logo=swift) [![Swift-6.1](https://img.shields.io/badge/Swift-6.1-orange.svg?style=flat)](https://developer.apple.com/swift/) [![iOS-17.0](https://img.shields.io/badge/iOS-17.0-pink.svg?style=flat)](https://developer.apple.com/swift/) ![TAG](https://img.shields.io/github/v/tag/William-Weng/WWDebugOverlayUI) [![Swift Package Manager-SUCCESS](https://img.shields.io/badge/Swift_Package_Manager-SUCCESS-blue.svg?style=flat)](https://developer.apple.com/swift/) [![LICENSE](https://img.shields.io/badge/LICENSE-MIT-yellow.svg?style=flat)](https://developer.apple.com/swift/)

## 🎉 [相關說明](https://developer.apple.com/swiftui/whats-new/)

- A Swift package that provides a quick and easy way to debug [SwiftUI](https://www.youtube.com/watch?v=6nJoVO0M3HI) view frames and global overlay positions.
- 一套用來在 [SwiftUI](https://medium.com/彼得潘的-swift-ios-app-開發問題解答集/利用-geometryreader-實現元件一樣大的排版-ecb033895d08) 中快速觀察 view frame 與全域 overlay 的除錯元件。

## 📷 [效果預覽](https://peterpanswift.github.io/iphone-bezels/)

![](https://github.com/user-attachments/assets/16d3c149-270b-4769-9002-c5c75e2b5214)

https://github.com/user-attachments/assets/4c7c3e04-5c5f-413f-beee-39266a218754

<div align="center">

**⭐ 覺得好用就給個 Star 吧！**

</div>

## ✨ 功能特色

- 點擊任意 view，即可回報該 view 的名稱與 global frame。
- 在畫面上顯示對應的除錯外框與資訊。
- 使用 SwiftUI `EnvironmentObject` 注入，整合簡單。
- 適合用來 debug layout、frame、hit testing 與 overlay 行為。

## 💿 [安裝方式](https://medium.com/彼得潘的-swift-ios-app-開發問題解答集/使用-spm-安裝第三方套件-xcode-11-新功能-2c4ffcf85b4b)

使用 **Swift Package Manager (SPM)**：

```swift
dependencies: [
    .package(url: "https://github.com/William-Weng/WWDebugOverlayUI", .upToNextMinor(from: "1.0.0"))
]
```

## 🍄 [設計思路](https://william-weng.github.io/)
這套元件的核心設計理念是：

- `DebugBox` 負責「點擊與量測」。
- `DebugOverlayManager` 負責「狀態管理」。
- `DebugGlobalOverlay` 負責「畫面顯示」。

這樣責任分離後，元件會比較容易維護，也比較適合放進 Swift Package 重用。

## 🐶 注意事項

- `DebugOverlayManager` 是 `@MainActor` 類別，所以應在主執行緒使用。
- `DebugBox` 依賴 `environmentObject`，所以使用前必須先注入 `DebugOverlayManager`。
- `DebugGlobalOverlay` 建議加上 `.allowsHitTesting(false)`，避免擋住底下互動元件。


## 🧲 內部參數

| 參數名稱 | 說明 |
|-----------|------|
| `name` | 傳給 overlay 顯示的名稱。 |
| `isSelected` | 是否顯示選取外框。 |
| `cornerRadius` | 選取外框圓角，預設 `8`。 |
| `selectedBorderColor` | 選取外框顏色，預設 `.yellow`。 |
| `selectedBorderWidth` | 選取外框線寬，預設 `3`。 |
| `onSelect` | 點擊時額外執行的動作。 |
| `content` | 包住的自訂內容。 |

## ⚡ 快速開始

### 1. 在 App root 建立 manager

```swift
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
```

### 2. 在畫面中使用 `DebugBox`

```swift
import SwiftUI
import WWDebugOverlayUI

struct ContentView: View {
    
    @EnvironmentObject private var overlayManager: WWDebugOverlayUI.DebugOverlayManager
    @State private var selectedName: String = "BlueBox"

    private let blueBoxName = "BlueBox"
    private let yellowBoxName = "YellowBox"
    private let greenBoxName = "GreenBox"
    
    var body: some View {
        
        VStack(spacing: 24) {
            
            Button("Toggle Global Overlay") {
                overlayManager.isGlobalOverlayVisible.toggle()
            }
            
            HStack(spacing: 24) {
                
                WWDebugOverlayUI.DebugBox(name: blueBoxName, isSelected: selectedName == blueBoxName, onSelect: { selectedName = blueBoxName }) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 8, style: .continuous)
                            .fill(.blue)
                        Text(blueBoxName)
                    }
                }
                
                WWDebugOverlayUI.DebugBox(name: yellowBoxName, isSelected: selectedName == yellowBoxName, onSelect: { selectedName = yellowBoxName }) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 8, style: .continuous)
                            .fill(.yellow)
                        Text(yellowBoxName)
                    }
                }
            }
            
            WWDebugOverlayUI.DebugBox(name: greenBoxName, isSelected: selectedName == greenBoxName, onSelect: { selectedName = greenBoxName }) {
                ZStack {
                    RoundedRectangle(cornerRadius: 8, style: .continuous)
                        .fill(.green)
                    Text(greenBoxName)
                }
            }
        }
        .padding()
    }
}
```
