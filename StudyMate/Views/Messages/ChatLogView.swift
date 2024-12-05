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
    var body: some View{
        VStack {
            // scroll View
            ScrollView{
                // Proxy
                ScrollViewReader{ scrollViewProxy in
                    
                    VStack{
                        ForEach(chatLogVM.chatMessages){ message in
                            VStack{
                                if message.fromID == Auth.auth().currentUser?.uid {
                                    HStack {
                                        Spacer()
                                        HStack{
                                            Text(message.text)
                                        }
                                        .padding()
                                        .background(.blue)
                                        .foregroundColor(.white)
                                        .cornerRadius(8)
                                    }
                                    .padding(.horizontal)
                                    .padding(.top, 8)
                                }
                                else{
                                    HStack {
                                        
                                        HStack{
                                            Text(message.text)
                                        }
                                        .padding()
                                        .background(.green)
                                        .foregroundColor(.white)
                                        .cornerRadius(8)
                                        Spacer()
                                    }
                                    .padding(.horizontal)
                                    .padding(.top, 8)
                                }
                            }
                            
                        }
                        HStack{Spacer()}
                            .id("Empty")
                    }
                    .onReceive(chatLogVM.$count) { _ in
                        withAnimation(.easeOut(duration: 0.5)){
                            scrollViewProxy.scrollTo("Empty", anchor: .bottom)
                        }
                       
                    }
                }
            }
            .background(Color.lightBeige)
            .navigationTitle(chatUser?.username ?? "Chat")
//            .navigationBarItems(trailing: Button(action: {
//                chatLogVM.count+=1
//            }, label: {
//                Text("count\(chatLogVM.count)")
//            }))
            .navigationBarTitleDisplayMode(.inline)
            //
            HStack(spacing:12){               //
                TextField("Type your message...", text: $chatLogVM.chatText )
                    .padding(10)
                    .background(Color.gray.opacity(0.2)) // Add a light background
                    .cornerRadius(15) // Rounded corners
                    .overlay(
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(Color.gray, lineWidth: 1) // Border
                    )
                    //.autocorrectionDisabled(true) // Disable autocorrect
                    .textInputAutocapitalization(.none)
                Button {
                    //
                    print("Do the send action")
                    chatLogVM.handelSendMessage()
                    chatLogVM.chatText = ""
                } label: {
                    Text("Send")
                        .foregroundStyle(.white)
                }
                .padding(.horizontal)
                .padding(.vertical, 8)
                .background(Color.blue)
                .cornerRadius(8)

            }
            .padding(.vertical, 8)
            .padding(.horizontal)
            
        }
//        .onAppear() {
//            
//        }
    }
    
}
//#Preview {
//    ChatLogView()
//}
