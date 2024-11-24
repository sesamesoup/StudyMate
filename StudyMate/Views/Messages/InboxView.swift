//
//  MessagesView.swift
//  StudyMate
//
//  Created by Maddie Adair on 10/19/24.
//

import SwiftUI

struct InboxView: View {
    @StateObject private var chatModel = ChatRequestModel()
    @StateObject private var chatsModel = ChatModel()

    var body: some View {
        ZStack {
            Color.lightBeige
                .ignoresSafeArea()
            VStack(alignment: .leading) {
                
                Text("Inbox")
                    .font(.custom("InstrumentSerif-Regular", size: 48))
                
                Spacer()
                    .frame(height: 50)
                
                if (chatsModel.chats.count > 0){
                    
                    VStack {
                        ForEach(chatsModel.chats) { chat in
                                ChatRow(chat: chat)
                            }
                        }
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

#Preview {
    InboxView()
}
