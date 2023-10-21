//
//  MicView.swift
//  Voice App
//
//  Created by Sergey Prybysh on 9/22/23.
//

import SwiftUI

struct RippleAnimationView: View {    
    let isActive: Bool
    let size: CGSize

    var body: some View {
        Circle()
            .fill(Color.red)
            .frame(width: size.width, height: size.height)
            .overlay(
                Circle()
                    .stroke(Color.white.opacity(0.5), lineWidth: 5)
                    .scaleEffect(isActive ? 4.0 : 1.0 )
                    .opacity(isActive ? 0 : 1.0)
                    .animation(
                        isActive ? Animation.easeOut(duration: 1.8).repeatForever(autoreverses: false) : .default,
                        value: isActive)
            )
    }
}
