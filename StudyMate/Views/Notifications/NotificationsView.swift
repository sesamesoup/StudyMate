//
//  NotificationsView.swift
//  StudyMate
//
//  Created by Maddie Adair on 10/19/24.
//

import SwiftUI

struct NotificationsView: View {
    @State var shouldPresentSheet = false
    @StateObject private var chatModel = ChatRequestModel()
    @StateObject private var suggestedModel = PostViewModel()
    @State var showingPopup = false
    
    var body: some View {
            ZStack {
                Color.lightBeige
                    .ignoresSafeArea()
                
                ScrollView {
                VStack(alignment: .leading) {
                    
                    Text("Notifications")
                        .font(.custom("InstrumentSerif-Regular", size: 48))
                    
                    Spacer()
                        .frame(height: 50)
                    
                    if (chatModel.chats.count > 0 || suggestedModel.suggestedPosts.count > 0){
                        VStack(spacing: 50) {
                            VStack(spacing: 25) {
                                if (chatModel.chats.count > 0){
                                    
                                    HStack {
                                        Text("Chat Requests")
                                            .font(.system(size: 24, weight: .medium))
                                        Spacer()
                                        
                                        Button(action: {
                                            chatModel.chats.removeAll()
                                        }) {
                                            Text("Dismiss All")
                                                .bold()
                                                .font(.system(size: 12))
                                                .padding(8)
                                                .background(.forest)
                                                .clipShape(.capsule)
                                                .foregroundStyle(.beige)
                                            
                                        }
                                    }
                                }
                                VStack {
                                    ForEach(chatModel.chats, id: \.id) { request in
                                        RequestRow(request: request)
                                    }
                                }
                            }
                            
                            
                            
                            if (suggestedModel.suggestedPosts.count > 0){
                                VStack(spacing: 25) {
                                    HStack {
                                        Text("Suggested for you")
                                            .font(.system(size: 24, weight: .medium))
                                        Spacer()
                                        Button(action: {
                                            suggestedModel.suggestedPosts.removeAll()
                                        }) {
                                            Text("Dismiss All")
                                                .bold()
                                                .font(.system(size: 12))
                                                .padding(8)
                                                .background(.forest)
                                                .clipShape(.capsule)
                                                .foregroundStyle(.beige)
                                        }
                                    }
                                    
                                    VStack {
                                        ForEach(suggestedModel.suggestedPosts.prefix(3), id: \.id) { post in
                                            NavigationLink(destination: Text("Second view")) {
                                                PostRow(post: post)
                                            }
                                        }
                                    }
                                }
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Spacer()
                        
                    }
                    else {
                        Text("Nothing here to see!")
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    
                    
                    Spacer()
                    
                }
                .padding(30)
                
            }
        }
        
    }
}

#Preview {
    NotificationsView()
}
