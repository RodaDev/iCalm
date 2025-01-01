//
//  iCalmApp.swift
//  iCalm
//
//  Created by Rodevelop on 28.09.2022.
//

import SwiftUI
import FirebaseCore

@main
struct iCalmApp: App {
    
    init() {
        FirebaseApp.configure()
      }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    return true
  }
}
