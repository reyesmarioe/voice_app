//
//  ActionButton.swift
//  Voice App
//
//  Created by Sergey Prybysh on 10/10/23.
//

import SwiftUI

enum ActionButtonType {
    case analyzer
    case recorder
    
    var systemName: String {
        switch self {
        case .analyzer:
            return "bonjour"
        case .recorder:
            return "mic"
        }
    }
}

struct ActionButton: View {
    var isActive: Bool
    let type: ActionButtonType
    let action: () -> Void
    
    @State var scale = 1.0
    
    var body: some View {
        Button {
            action()
        } label: {
            Image(systemName: type.systemName)
                .foregroundColor(.white)
                .font(.system(size: 50))
        }
        .padding(30)
        .background(Circle().fill(Color.backgroundBlue))
        .padding(5)
        .background(Circle().fill(Color.white.opacity(0.5)))
        .scaleEffect(scale)
        .animation(Animation.easeInOut(duration: 1.3).repeatForever(), value: scale)
        .onAppear {
            scale = 1.1
        }
    }
}
