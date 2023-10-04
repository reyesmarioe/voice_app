//
//  MicView.swift
//  Voice App
//
//  Created by Sergey Prybysh on 9/22/23.
//

import SwiftUI

struct MicView: View {    
    let action: () -> Void
    let isRecording: Bool
    let isEnabled: Bool
    
    var body: some View {
        Button {
            withAnimation {
                action()
            }
        } label: {
            let text = isRecording ? "Stop" : "Record"
            if #available(iOS 17.0, *) {
                Label(text,systemImage: "waveform.and.mic")
                    .font(.largeTitle)
                    .symbolEffect(
                        .variableColor.iterative,
                        options: .repeating,
                        isActive: isRecording)
            } else {
                Label(text, systemImage: "waveform.and.mic")
                    .font(.largeTitle)
            }
        }
        .foregroundColor(isEnabled ? (isRecording ? .pink : .blue) : .gray)
        .disabled(!isEnabled)
    }
}

#Preview {
    MicView(action: {}, isRecording: false, isEnabled: true)
}
