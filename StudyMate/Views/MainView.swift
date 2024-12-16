//
//  HomeView.swift
//  StudyMate
//
//  Created by Maddie Adair on 10/19/24.
//

import SwiftUI

struct MainView: View {
    @State private var activeTabIndex = 0
    @State private var isAddPostViewPresented = false
    
    var body: some View {
        NavigationStack {
            TabView(selection: $activeTabIndex) {
                // Home Tab
                HomeView()
                    .tabItem {
                        VStack {
                            Image(systemName: activeTabIndex == 0 ? "house.fill" : "house")
                                .environment(\.symbolVariants, .none)
                            Text("Home")
                        }
                    }
                    .tag(0)
                
                // Add Post Tab
                Text("") // Placeholder to avoid direct view conflict
                    .tabItem {
                        VStack {
                            Image(systemName: activeTabIndex == 1 ? "plus.square.fill" : "plus.square")
                                .environment(\.symbolVariants, .none)
                            Text("Create Post")
                        }
                    }
                    .tag(1)
                
                // Inbox Tab
                InboxView()
                    .tabItem {
                        VStack {
                            Image(systemName: activeTabIndex == 2 ? "message.fill" : "message")
                                .environment(\.symbolVariants, .none)
                            Text("Chat")
                        }
                    }
                    .tag(2)
                
                // Profile Tab
                ProfileView()
                    .tabItem {
                        
                        VStack {
                            Image(systemName: activeTabIndex == 3 ? "person.fill" : "person")
                                .environment(\.symbolVariants, .none)
                            Text("Profile")
                        }
                    }
                    .tag(3)
            }
            .accentColor(.forest)
            .onChange(of: activeTabIndex) { newIndex in
                if newIndex == 1 { // When Add Post tab is selected
                    isAddPostViewPresented = true
                }
            }
            .sheet(isPresented: $isAddPostViewPresented) {
                AddPostView()
                    .interactiveDismissDisabled()
                    .onAppear() {
                        activeTabIndex = 0 // Return to Home tab after dismissing Add Post
                    }
            }
        }
    }
}

#Preview {
    MainView()
}
