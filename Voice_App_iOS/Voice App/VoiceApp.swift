//
//  Voice_AppApp.swift
//  Voice App
//
//  Created by Sergey Prybysh on 9/22/23.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}

@main
struct VoiceApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
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
