//
//  Voice_AppApp.swift
//  Voice App
//
//  Created by Sergey Prybysh on 9/22/23.
//

import SwiftUI

@main
struct VoiceApp: App {
    var body: some Scene {
        WindowGroup {
            MainView(viewModel: MainViewModel())
                .frame(maxWidth: .infinity)
                .edgesIgnoringSafeArea(.all)
                .background(
                    LinearGradient(gradient: Gradient(
                        colors: [Color.lightBlue, Color.darkBlue]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing))
            
        }
    }
}
