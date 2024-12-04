//
//  HomeView.swift
//  StudyMate
//
//  Created by Maddie Adair on 10/19/24.
//

import SwiftUI

struct MainView: View {
    @State private var activeTabIndex = 0
    //
    var body: some View {
        
        NavigationStack {
            VStack {
                TabView(selection: $activeTabIndex) {
                    // Change this
                    MorePostsView()
                        .tabItem {
                            if (activeTabIndex == 0){
                                Image(systemName: "house.fill")
                                    .environment(\.symbolVariants, .none)
                            } else {
                                Image(systemName: "house")
                                    .environment(\.symbolVariants, .none)
                            }
                        }.tag(0)
                        .onAppear { self.activeTabIndex = 0 }
                    
                    // changing to add post View
                    AddPostView()
                        .tabItem {
                            if (activeTabIndex == 1){
                                Image(systemName: "plus.square.fill")
                                    .environment(\.symbolVariants, .none)
                            } else {
                                Image(systemName: "plus.square")
                                    .environment(\.symbolVariants, .none)
                            }
                        }.tag(1)
                        .onAppear { self.activeTabIndex = 1 }
                    
                    InboxView()
                        .tabItem {
                            if (activeTabIndex == 2){
                                Image(systemName: "message.fill")
                                    .environment(\.symbolVariants, .none)
                            } else {
                                Image(systemName: "message")
                                    .environment(\.symbolVariants, .none)
                            }
                        }.tag(2)
                        .onAppear { self.activeTabIndex = 2 }
                    
                    ProfileView()
                        .tabItem {
                            if (activeTabIndex == 3){
                                Image(systemName: "person.fill")
                                    .environment(\.symbolVariants, .none)
                            } else {
                                Image(systemName: "person")
                                    .environment(\.symbolVariants, .none)
                            }
                        }.tag(3)
                        .onAppear { self.activeTabIndex = 3 }
                }
                .accentColor(.forest)
            }
            .navigationBarBackButtonHidden(true)
        }

    }

}

#Preview {
    MainView()
}
