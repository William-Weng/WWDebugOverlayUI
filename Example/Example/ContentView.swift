//
//  ContentView.swift
//  Example
//
//  Created by William.Weng on 2026/4/17.
//

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
