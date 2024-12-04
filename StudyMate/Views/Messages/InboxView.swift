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
struct ChatUser{
    let uid, email, firstName, lastName, major, year,profilePicture: String
}


class MainMessageViewModel: ObservableObject {
    @Published var errorMessage: String = ""
    @Published var chatUser: ChatUser?
    init(){
    // fetch the current user
        fetchCurrentUser()
    }
    func fetchCurrentUser(){
        guard let userId = Auth.auth().currentUser?.uid else {
            print("Unable to fetch current user")
            return
        }
        // Getting the current user
        Firestore.firestore().collection("users").document(userId).getDocument { (snapshot, error) in
            if let error = error  {
                print("Error fetching current user: \(error)")
                return
            }
            guard let data = snapshot?.data() else {
                print("No data found")
                return
            }
            print(data)
            //
            self.chatUser = ChatUser(uid: userId, email: data["email"] as? String ?? "", firstName: data["firstName"] as? String ?? "", lastName: data["lastName"] as? String ?? "", major: data["major"] as? String ?? "", year: data["year"] as? String ?? "", profilePicture: data["profilePicture"] as? String ?? "")
        }
    }
    
    
}

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
                            destination: ChatLogView(chatUser: selectedUser),
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
                // If chat found
                if (true){
                    ScrollView() {
                        VStack {
                            ForEach(0..<10, id: \.self) { num in
                                // Row
                                NavigationLink{
                                    //Text("Destination")
                                    //ChatLogView(selectedUser)
                                } label:{
                                    
                                    VStack {
                                        HStack(spacing:16){
                                            Image(systemName: "person.fill")
                                                .font(.system(size: 32))
                                            //
                                            VStack(alignment: .leading){
                                                Text("Username")
                                                Text("MessageSent")
                                            }
                                            
                                            Spacer()
                                            Text("Date Last sent")
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
                    Text("Nothing here to see!")
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                
                Spacer()
                
            }
            .padding(30)
            
        }
    }
}

// ==============================================================

struct ChatLogView:View{
    //
    let chatUser : OtherUser?
    
    //
    var body: some View{
        ScrollView{
            ForEach(0..<10){ i in
                Text("Fack message for now")
                
            }
        }
        .navigationTitle(chatUser?.username ?? "Chat")
        .navigationBarTitleDisplayMode(.inline)
    }
    
}

//#Preview {
//    InboxView()
//}
