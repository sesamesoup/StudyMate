//
//  HomeView.swift
//  StudyMate
//
//  Created by Maddie Adair on 10/19/24.
//

import SwiftUI
//
//struct MainView: View {
//    @State private var activeTabIndex = 0
//    //
//    @State private var isAddPostViewPresented = false
//    var body: some View {
//        
//        NavigationStack {
//            VStack {
//                TabView(selection: $activeTabIndex) {
//                    // Change this
//                    MorePostsView()
//                        .tabItem {
//                            if (activeTabIndex == 0){
//                                Image(systemName: "house.fill")
//                                    .environment(\.symbolVariants, .none)
//                            } else {
//                                Image(systemName: "house")
//                                    .environment(\.symbolVariants, .none)
//                            }
//                        }.tag(0)
//                        .onAppear { self.activeTabIndex = 0 }
//                    
//                    // changing to add post View
////                    AddPostView()
//                    Button {
//                        isAddPostViewPresented = true // Toggle the modal presentation
//                    } label: {
//                        if activeTabIndex == 1 {
//                            Image(systemName: "plus.square.fill")
//                                .environment(\.symbolVariants, .none)
//                        } else {
//                            Image(systemName: "plus.square")
//                                .environment(\.symbolVariants, .none)
//                        }
//                    }
//                    .tag(1) // Ensure the tag remains to maintain tab selection
//                    .onAppear { self.activeTabIndex = 1 }
//                    .fullScreenCover(isPresented: $isAddPostViewPresented) {
//                        AddPostView()
//                            .onDisappear {
//                                // Optional: Add any actions to perform after dismissing
//                                print("AddPostView dismissed")
//                            }
//                    }
//
//                        .tabItem {
//                            if (activeTabIndex == 1){
//                                Image(systemName: "plus.square.fill")
//                                    .environment(\.symbolVariants, .none)
//                            } else {
//                                Image(systemName: "plus.square")
//                                    .environment(\.symbolVariants, .none)
//                            }
//                        }.tag(1)
//                        .onAppear { self.activeTabIndex = 1 }
//                    
//                    InboxView()
//                        .tabItem {
//                            if (activeTabIndex == 2){
//                                Image(systemName: "message.fill")
//                                    .environment(\.symbolVariants, .none)
//                            } else {
//                                Image(systemName: "message")
//                                    .environment(\.symbolVariants, .none)
//                            }
//                        }.tag(2)
//                        .onAppear { self.activeTabIndex = 2 }
//                    
//                    ProfileView()
//                        .tabItem {
//                            if (activeTabIndex == 3){
//                                Image(systemName: "person.fill")
//                                    .environment(\.symbolVariants, .none)
//                            } else {
//                                Image(systemName: "person")
//                                    .environment(\.symbolVariants, .none)
//                            }
//                        }.tag(3)
//                        .onAppear { self.activeTabIndex = 3 }
//                }
//                .accentColor(.forest)
//            }
//            .navigationBarBackButtonHidden(true)
//        }
//
//    }
//
//}

//struct MainView: View {
//    @State private var activeTabIndex = 0
//    @State private var isAddPostViewPresented = false
//    
//    var body: some View {
//        NavigationStack {
//            VStack {
//                TabView(selection: $activeTabIndex) {
//                    // Home Tab
//                    MorePostsView()
//                        .tabItem {
//                            Image(systemName: activeTabIndex == 0 ? "house.fill" : "house")
//                                .environment(\.symbolVariants, .none)
//                        }
//                        .tag(0)
//                        .onAppear { self.activeTabIndex = 0 }
//                    
//                    // Add Post Tab (Button + Modal)
//                    Button {
//                        isAddPostViewPresented = true
//                    } label: {
//                        Image(systemName: activeTabIndex == 1 ? "plus.square.fill" : "plus.square")
//                            .environment(\.symbolVariants, .none)
//                    }
//                    .tag(1)
//                    .tabItem {
//                        Image(systemName: activeTabIndex == 1 ? "plus.square.fill" : "plus.square")
//                            .environment(\.symbolVariants, .none)
//                    }
//                    .onAppear { self.activeTabIndex = 1 }
//                    .fullScreenCover(isPresented: $isAddPostViewPresented) {
//                        AddPostView()
//                            .onDisappear {
//                                print("AddPostView dismissed")
//                            }
//                    }
//                    
//                    // Inbox Tab
//                    InboxView()
//                        .tabItem {
//                            Image(systemName: activeTabIndex == 2 ? "message.fill" : "message")
//                                .environment(\.symbolVariants, .none)
//                        }
//                        .tag(2)
//                        .onAppear { self.activeTabIndex = 2 }
//                    
//                    // Profile Tab
//                    ProfileView()
//                        .tabItem {
//                            Image(systemName: activeTabIndex == 3 ? "person.fill" : "person")
//                                .environment(\.symbolVariants, .none)
//                        }
//                        .tag(3)
//                        .onAppear { self.activeTabIndex = 3 }
//                }
//                .accentColor(.forest)
//            }
//            .navigationBarBackButtonHidden(true)
//        }
//    }
//}
//
struct MainView: View {
    @State private var activeTabIndex = 2
    @State private var isAddPostViewPresented = false
    
    var body: some View {
        NavigationStack {
            TabView(selection: $activeTabIndex) {
                // Home Tab
                MorePostsView()
                    .tabItem {
                        Image(systemName: activeTabIndex == 0 ? "house.fill" : "house")
                            .environment(\.symbolVariants, .none)
                    }
                    .tag(0)
                
                // Add Post Tab
                Text("") // Placeholder to avoid direct view conflict
                    .tabItem {
                        Image(systemName: activeTabIndex == 1 ? "plus.square.fill" : "plus.square")
                            .environment(\.symbolVariants, .none)
                    }
                    .tag(1)
                
                // Inbox Tab
                InboxView()
                    .tabItem {
                        Image(systemName: activeTabIndex == 2 ? "message.fill" : "message")
                            .environment(\.symbolVariants, .none)
                    }
                    .tag(2)
                
                // Profile Tab
                ProfileView()
                    .tabItem {
                        Image(systemName: activeTabIndex == 3 ? "person.fill" : "person")
                            .environment(\.symbolVariants, .none)
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
