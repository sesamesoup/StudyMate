//
//  StudyMateApp.swift
//  StudyMate
//
//  Created by Maddie Adair on 10/12/24.
//

import SwiftUI
import Firebase
//
@main
struct StudyMateApp: App {
    // Without the app delegate
//    init () {
//        FirebaseApp.configure()
//        print("Firebase initialized")
//    }
    
    // Using app delegate
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some Scene {
        WindowGroup {
//            ContentView()
            SplashScreen()
        }
    }
}
//
//Using app Delaegate use to host the root of the app

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        print("Firebase initialized")
        return true
    }
}

