//
//  MicCircleView.swift
//  Voice App
//
//  Created by Sergey Prybysh on 9/26/23.
//

import SwiftUI

struct MicCircleView: View {
    let action: () -> Void
    let isRecording: Bool
    let isEnabled: Bool
    
    var body: some View {
        Button {
            withAnimation {
                action()
            }
        } label: {
            if #available(iOS 17.0, *) {
                Image(systemName: "mic.circle")
                    .resizable()
                    .frame(width: 60, height: 60, alignment: .center)
                    .scaleEffect(!isRecording ? 1.0 : 1.3)
                    .symbolEffect(
                        .pulse,
                        options: .repeating,
                        isActive: isRecording)
            } else {
                Image(systemName: "mic.circle")
                    .resizable()
                    .frame(width: 60, height: 60, alignment: .center)
                    .scaleEffect(!isRecording ? 1.0 : 1.3)
            }
        }
        .foregroundColor(isEnabled ? (isRecording ? .pink : .blue) : .gray)
        .disabled(!isEnabled)
    }
}

#Preview {
    MicCircleView(action: {}, isRecording: false, isEnabled: true)
}
