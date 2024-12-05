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
//                            print(vm.recentMessages)
                            for message in vm.recentMessages {
                                print("Username: \(message.username), FromID: \(message.fromID)")
                            }
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
                        //
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
                                Button(action: {
                                    fetchUserAndNavigate(username: recentMessage.username)
                                }) {
                                    VStack {
                                        HStack(spacing: 16) {
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
                                            
                                            VStack(alignment: .leading) {
                                                Text("\(recentMessage.username)")
                                                Text("\(recentMessage.text)")
                                                    .font(.system(size: 12))
                                                    .multilineTextAlignment(.leading)
                                            }
                                            
                                            Spacer()
                                            Text(timeAgoSince(recentMessage.timestamp))
                                        }
                                    }
                                }
                                Divider()
                            }

                            
                        }
                        
                        // Modify the NavigationLink inside the ForEach
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
    private func fetchUserAndNavigate(username: String) {
        fetchUserByUsername(username: username) { user in
            guard let user = user else {
                print("No user found with username: \(username)")
                return
            }
            DispatchQueue.main.async {
                self.selectedUser = user
                self.shouldNavigateToChatLogView = true
            }
        }
    }

    //
//    func fetchUserByUsername(username: String, completion: @escaping (OtherUser?) -> Void) {
//        Firestore.firestore().collection("users")
//            .whereField("username", isEqualTo: username)
//            .getDocuments { querySnapshot, error in
//                if let error = error {
//                    print("Error fetching user by username: \(error.localizedDescription)")
//                    completion(nil)
//                    return
//                }
//                
//                guard let documents = querySnapshot?.documents, let document = documents.first else {
//                    print("No user found with username: \(username)")
//                    completion(nil)
//                    return
//                }
//                
//                let data = document.data()
//                let userID = document.documentID
//                
//                let user = OtherUser(
//                    uid: userID,
//                    email: data["email"] as? String ?? "",
//                    firstName: data["firstName"] as? String ?? "",
//                    lastName: data["lastName"] as? String ?? "",
//                    major: data["major"] as? String ?? "",
//                    year: data["year"] as? String ?? "",
//                    profilePicture: data["profilePicture"] as? String ?? "",
//                    username: data["username"] as? String ?? ""
//                )
//                
//                completion(user)
//            }
//    }
    
    
    func fetchUserByUsername(username: String, completion: @escaping (OtherUser?) -> Void) {
        Firestore.firestore().collection("users")
            .whereField("username", isEqualTo: username)
            .getDocuments(source: .default){ querySnapshot, error in
                if let error = error {
                    print("Error fetching user by username: \(error.localizedDescription)")
                    completion(nil)
                    return
                }
                
                guard let documents = querySnapshot?.documents, let document = documents.first else {
                    print("No user found with username: \(username)")
                    completion(nil)
                    return
                }
                
                let data = document.data()
                let userID = document.documentID
                
                // Break down the initialization into smaller steps
                let email = data["email"] as? String ?? ""
                let firstName = data["firstName"] as? String ?? ""
                let lastName = data["lastName"] as? String ?? ""
                let major = data["major"] as? String ?? ""
                let year = data["year"] as? String ?? ""
                let profilePicture = data["profilePicture"] as? String ?? ""
                let username = data["username"] as? String ?? ""
                
                // Create the user object
                let user = OtherUser(
                    uid: userID,
                    email: email,
                    firstName: firstName,
                    lastName: lastName,
                    major: major,
                    year: year,
                    profilePicture: profilePicture,
                    username: username
                )
                
                completion(user)
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
