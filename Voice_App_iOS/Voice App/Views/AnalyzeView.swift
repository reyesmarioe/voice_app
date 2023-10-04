//
//  AnalyzeView.swift
//  Voice App
//
//  Created by Sergey Prybysh on 9/23/23.
//

import SwiftUI

struct AnalyzeView: View {
    let action: () -> Void
    let isAnalyzing: Bool
    let isEnabled: Bool
    
    var body: some View {
        Button {
            withAnimation {
                action()
            }
        } label: {
            let text = isAnalyzing ? "Cancel" : "Analyze"
            if #available(iOS 17.0, *) {
                Label(text, systemImage: "bonjour")
                    .font(.largeTitle)
                    .symbolEffect(
                        .variableColor.iterative,
                        options: .repeating,
                        isActive: isAnalyzing)
            } else {
                Label(text, systemImage: "bonjour")
                    .font(.largeTitle)
            }
        }
        .foregroundColor(isEnabled ? (isAnalyzing ? .pink : .blue) : .gray)
        .disabled(!isEnabled)
    }
}

#Preview {
    AnalyzeView(action: {}, isAnalyzing: false, isEnabled: true)
}
