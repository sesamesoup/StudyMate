//
//  ContentView.swift
//  StudyMate
//
//  Created by Maddie Adair on 10/12/24.
//

import SwiftUI
import FirebaseAuth

struct ContentView: View {
    @AppStorage("navigateToHome") var navigateToHome: Bool = false
    @State private var isAuthenticated: Bool = false
    var body: some View {
        VStack {
            if isAuthenticated {
                MainView()
            } else {
                WelcomeView()
            }
        }
        .onAppear {
            checkAuthentication()
        }
    }
    private func checkAuthentication() {
        // Check Firebase's current user
        if Auth.auth().currentUser != nil {
            print(Auth.auth().currentUser!.email!)
            isAuthenticated = true
        } else {
            isAuthenticated = false
        }
    }
}

#Preview {
    ContentView()
}
