//
//  MessagesView.swift
//  StudyMate
//
//  Created by Maddie Adair on 10/19/24.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore
import Firebase

//struct InboxView: View {
//    // Imbox View
//    @StateObject private var chatModel = ChatRequestModel()
//    @StateObject private var chatsModel = ChatModel()
//
//    var body: some View {
//        ZStack {
//            Color.lightBeige
//                .ignoresSafeArea()
//            // Main stack
//            VStack(alignment: .leading) {
//                
//                Text("Inbox")
//                    .font(.custom("InstrumentSerif-Regular", size: 48))
//                
//                Spacer()
//                    .frame(height: 50)
//                
//                if (chatsModel.chats.count > 0){
//                    
//                    VStack {
//                        ForEach(chatsModel.chats) { chat in
//                                ChatRow(chat: chat)
//                            }
//                        }
//                    }
//                else {
//                    Text("Nothing here to see!")
//                        .frame(maxWidth: .infinity, alignment: .leading)
//                }
//                
//                Spacer()
//                
//            }
//            .padding(30)
//            
//        }
//    }
//}

//


struct InboxView: View {
    // Creating ViewModel
    @ObservedObject private var vm = MainMessageViewModel()
    // Imbox View
    //
    @State var shouldNavigateToChatLogView: Bool = false
    //
    @State var selectedUser: OtherUser?
    //
    @State var showNewMessage: Bool = false
    
    var body: some View {
        ZStack {
            Color.lightBeige
                .ignoresSafeArea()
            // Main stack
            VStack(alignment: .leading) {
                //===============================================
                VStack {
                    HStack {
                        Text("Inbox")
                            .font(.custom("InstrumentSerif-Regular", size: 48))
                        // Chat log here
                        
                        NavigationLink(
                            destination: ChatLogView(chatUser: self.selectedUser ?? OtherUser()),
                            isActive: $shouldNavigateToChatLogView
                        ) {
                            EmptyView() // NavigationLink needs a content closure, even if it's empty
                        }
                        
                        Button(action: {
                            showNewMessage.toggle() // Show the new message screen
                        }) {
                            Spacer()
                            Text("New Message button")
                                .bold()
                                .padding()
                                .frame(maxWidth: 200, alignment: .center)
                                .background(Color.forest) // Ensure `.forest` is a valid color
                                .foregroundColor(Color.beige) // Ensure `.beige` is a valid color
                                .cornerRadius(16)
                        }
                        .fullScreenCover(isPresented: $showNewMessage) {
                            CreateNewMessageView(didSelectNewUser: { user in
                                print("didSelectNewUser: \(user.email)")
                                self.selectedUser = user
                                self.shouldNavigateToChatLogView = true // Trigger NavigationLink
                            })
                        }


                    }
                }
                //===============================================
                Spacer()
                    .frame(height: 50)
                // --------------------- If chat found ---------------------------
                if (!vm.recentMessages.isEmpty){
                    ScrollView() {
                        VStack {
                            ForEach(vm.recentMessages) { recentMessage in
                                // Row
                                NavigationLink{
                                    //Text("Destination")
                                    //ChatLogView(selectedUser)
                                } label:{
                                    
                                    VStack {
                                        HStack(spacing:16){
//                                            Image(systemName: "person.fill")
//                                            Image(recentMessage.profileImage)
//                                                .font(.system(size: 32))
                                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                                .aspectRatio(1.2, contentMode: .fill)
                                                .overlay(
                                                    Image(recentMessage.profileImage)
                                                        .resizable()
                                                        .scaledToFill()
                                                        .offset(x: -4.0, y: 0.0)
                                                )
                                                .frame(width: 40, height: 40, alignment: .leading)
                                                .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))

                                            //
                                            VStack(alignment: .leading){
                                                Text("\(recentMessage.username)")
                                                Text("\(recentMessage.text)")
                                                    .font(.system(size: 12))
                                                    .multilineTextAlignment(.leading)
                                            }
                                            
                                            Spacer()
//                                            Text("Date Last sent")
                                            Text(timeAgoSince(recentMessage.timestamp))
                                        }
                                    }
                                }
                                Divider()
                            }
                            
                        }
                    }
                    .scrollIndicators(.hidden)
                }
                // --------------------- If no chat found ----------------------------
                else {
                    Text("Start a new message by clicking on the plus icon!")
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                
                Spacer()
                
            }
            .padding(30)
            
        }
    }
    //
    func timeAgoSince(_ timestamp: Timestamp) -> String {
        let date = timestamp.dateValue() // Convert Timestamp to Date
        let now = Date()
        let calendar = Calendar.current
        
        let components = calendar.dateComponents([.minute, .hour, .day], from: date, to: now)
        
        if let day = components.day, day > 0 {
            return day == 1 ? "1 day ago" : "\(day) days ago"
        } else if let hour = components.hour, hour > 0 {
            return hour == 1 ? "1 hour ago" : "\(hour) hours ago"
        } else if let minute = components.minute, minute > 0 {
            return minute == 1 ? "1 minute ago" : "\(minute) minutes ago"
        } else {
            return "Just now"
        }
    }
}

// ==============================================================



//#Preview {
//    InboxView()
//}
