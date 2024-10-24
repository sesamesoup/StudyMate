//
//  ChatRow.swift
//  StudyMate
//
//  Created by Maddie Adair on 10/21/24.
//

import SwiftUI

struct ChatRow: View {
    var chat: ChatElement

    
    var body: some View {
        NavigationLink(destination: ChatView(chat: chat).toolbar(.hidden, for: .tabBar)) {
            HStack {
                HStack(spacing: 14) {
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .aspectRatio(1.2, contentMode: .fill)
                        .overlay(
                            AsyncImage(url: chat.profilePic) { image in
                                image
                                    .resizable()
                                .scaledToFill()
                                .offset(x: -4.0, y: 0.0)
                                
                            } placeholder: {
                                ProgressView()
                            }
                           
                        )
                        .frame(width: 40, height: 40, alignment: .leading)
                        .clipShape(RoundedRectangle(cornerRadius: 10,
                                                    style: .continuous))
                    VStack(alignment: .leading, spacing: 6) {
                        Text(chat.fullName)
                            .foregroundStyle(.black)
                            .font(.system(size: 14, weight: .semibold))
                            .frame(maxWidth: 130, alignment: .leading)
                            .lineLimit(1)
                            .truncationMode(.tail)
                        Text(chat.messages[(chat.messages.count - 1)].data[0].message)
                            .font(.system(size: 12))
                            .foregroundStyle(.black)
                            .frame(maxWidth: 130, alignment: .leading)
                            .lineLimit(1)
                            .truncationMode(.tail)
                    }
                    
                    
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                Spacer()
                
                Text(chat.messages[0].formattedDT)
                    .frame(alignment: .trailing)
                    .foregroundStyle(.black)
                    .font(.system(size: 12))
                
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(.multiplyBeige)
        .cornerRadius(16)
    }
}
