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
                //.frame(maxWidth: .infinity)
                //.background(Color(red: 1.0, green: 0.75, blue: 0.80, opacity: 0.4))
            
        }
    }
}
