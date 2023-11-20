//
//  SecondaryButton.swift
//  Voice App
//
//  Created by Sergey Prybysh on 10/17/23.
//

import SwiftUI

enum SecondaryButtonType {
    case stop
    case cancel
    case record
    case none
    case close
    
    var title: String {
        switch self {
        case .stop:
            return "STOP"
        case .cancel:
            return "CANCEL"
        case .record:
            return "RECORD"
        case .none:
            return "NONE"
        case .close:
            return "Close"
        }
    }
}

struct SecondaryButton: View {
    let type: SecondaryButtonType
    let action: () -> Void
        
    var body: some View {
        Button {
            action()
        } label: {
            Text(type.title)
        }
        .foregroundColor(.white)
        .font(.system(size: 13, weight: .semibold))
        .padding(.horizontal, 12)
        .padding(.vertical, 4)
        .background(Capsule().fill(Color.white.opacity(0.3)))
        .overlay(Capsule().stroke(Color.white, lineWidth: 1))
    }
}

