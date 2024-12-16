//
//  ChatLogView.swift
//  StudyMate
//
//  Created by Sarang Mistry on 12/4/24.
//

import SwiftUI
import Firebase
import FirebaseAuth
struct ChatLogView:View{
    //
    
    init(chatUser: OtherUser){
        self.chatUser = chatUser
        self.chatLogVM = .init(recieverUser: chatUser)
        print("getting ToID UserID")
        print(chatLogVM.recieverUser?.uid as Any)
        
        
    }
    @ObservedObject var chatLogVM : ChatLogViewModel
    //
    let chatUser : OtherUser?
    //    @State var chatText = ""
    //
    @Environment(\.dismiss) var dismiss
    
    
    var body: some View{
        ZStack {
            Color.lightBeige
                .ignoresSafeArea()
            
            
            VStack {
                HStack(spacing: 20) {
                    
                    // Recipient Profile Image
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .aspectRatio(1.2, contentMode: .fill)
                        .overlay(
                            Image(chatUser?.profilePicture ?? "girl1")
                                    .resizable()
                                    .scaledToFill()
                                    .offset(x: -4.0, y: 0.0)
                            
                        )
                        .frame(width: 40, height: 40, alignment: .leading)
                        .clipShape(RoundedRectangle(cornerRadius: 10,
                                                    style: .continuous))
                    
                    VStack(alignment: .leading, spacing: 6) {
                        
                        // Recipient Full Name
                        Text("\(chatUser?.firstName ?? "Jane") \(chatUser?.lastName ?? "Doe")")
                            .foregroundStyle(.black)
                            .font(.system(size: 16, weight: .semibold))
                            .frame(maxWidth: 130, alignment: .leading)
                            .lineLimit(1)

                        // Recipient Username
                        Text("@\(chatUser?.username ?? "Chat")")
                            .font(.system(size: 14))
                            .foregroundStyle(.black)
                            .frame(maxWidth: 130, alignment: .leading)
                            .lineLimit(1)
                            .truncationMode(.tail)
                    }
                    
                    Spacer()
                    
                    
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom, 30)
                
                Divider()
                
                Spacer()
                    .frame(height: 30)
                
                ScrollView(showsIndicators: false) {
                    
                    VStack(spacing: 16) {
                        
                        // Render each chat message
                        ForEach(chatLogVM.chatMessages) { message in
                            VStack{

                                // If the user is the current user then bubble is blue
                                if message.fromID == Auth.auth().currentUser?.uid {
                                    HStack {
                                        Spacer()
                                        HStack{
                                            Text(message.text)
                                        }
                                        .padding()
                                        .background(.lightBlue)
                                        .foregroundColor(.black)
                                        .cornerRadius(8)
                                    }
                                    .padding(.top, 8)
                                }
                                // green bubble if recipient
                                else{
                                    HStack {
                                        HStack{
                                            Text(message.text)
                                        }
                                        .padding()
                                        .background(.lightGreen)
                                        .foregroundColor(.black)
                                        .cornerRadius(8)
                                        Spacer()
                                    }
                                    .padding(.top, 8)
                                }
                            }
                        }
                    }
                }
                
                Spacer()
                
                // Text Field to send a new message
                HStack(spacing: 16) {
                    TextField("Enter a message...", text: $chatLogVM.chatText, axis: .vertical)
                        .padding()
                        .background(.multiplyBeige)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .cornerRadius(16)
                    Button {
                        chatLogVM.handelSendMessage()
                        chatLogVM.chatText = ""
                    } label: {
                        Image(systemName: "paperplane")
                        //                                        .resizable()
                        //                                        .scaledToFit()
                        //                                        .aspectRatio(contentMode: .fit)
                            .frame(width: 20, height: 20, alignment: .trailing)
                            .padding(10)
                            .background(.forest)
                            .foregroundStyle(.beige)
                            .clipShape(Capsule())
                        
                    }
                }
                .padding(.top, 30)
                //                                    .frame(maxHeight: .infinity, alignment: .bottom)
            }
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: {
                        dismiss()
                    }) {
                        HStack(spacing: 10) {
                            Image(systemName: "arrow.left")
                                .foregroundStyle(.forest)
                            
                            Text("Back")
                                .foregroundStyle(.forest)
                        }
                        
                    }
                }
            }
            .padding(30)
        }
        
        
    }
    
    
    func formatDate(from timestamp: Timestamp) -> String {
        let date = timestamp.dateValue() // Convert Timestamp to Date
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM dd, yyyy" // Set the desired format
        return formatter.string(from: date)
    }
    
}
//#Preview {
//    ChatLogView()
//}
