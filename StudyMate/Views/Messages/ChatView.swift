//
//  ChatView.swift
//  StudyMate
//
//  Created by Maddie Adair on 10/21/24.
//

import SwiftUI
import PhotosUI

struct CustomFrameModifier : ViewModifier {
    var from : String
    
    @ViewBuilder func body(content: Content) -> some View {
        if from  == "self" {
            content.frame(maxWidth: 400, alignment: .trailing)
        } else {
            content.frame(maxWidth: 400, alignment: .leading)
        }
    }
}

struct ChatView: View {
    var chat: ChatElement
    @Environment(\.dismiss) var dismiss
    @State private var message: String = ""
    
    @State private var selectedItems = [PhotosPickerItem]()
    @State private var selectedImages = [Image]()
    
    var body: some View {
        ZStack {
            Color.lightBeige
                .ignoresSafeArea()
            
           
                VStack {
                    HStack {
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
                                .font(.system(size: 16, weight: .semibold))
                                .frame(maxWidth: 130, alignment: .leading)
                                .lineLimit(1)
                                .truncationMode(.tail)
                            Text("@\(chat.username)")
                                .font(.system(size: 14))
                                .foregroundStyle(.black)
                                .frame(maxWidth: 130, alignment: .leading)
                                .lineLimit(1)
                                .truncationMode(.tail)
                        }
                        
                        Spacer()
                        
                        NavigationLink(destination: MediaView(fullName: chat.fullName, username: chat.username, profilePic: chat.profilePic).toolbar(.hidden, for: .tabBar)){
                            Image(systemName: "photo.fill")
                                .resizable()
                                .scaledToFit()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 20, height: 20)
                                .padding(8)
                                .background(.forest)
                                .cornerRadius(12)
                                .foregroundStyle(.beige)
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom, 30)
                    
                    Divider()
                    
                    Spacer()
                        .frame(height: 30)
                    
                    ScrollView(showsIndicators: false) {
                        
                        VStack(spacing: 16) {
                            Text(chat.messages[0].data[0].formattedDT)
                                .fontWeight(.semibold)

                            VStack(alignment: .leading, spacing: 2) {
                                Text("In reply to:")
                                    .fontWeight(.semibold)
                                    .underline()
                                Text("\(chat.title)")
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding()
                            .background(.forest)
                            .cornerRadius(16)
                            .foregroundStyle(.beige)
                            
                            ForEach(chat.messages, id: \.dateTime) { day in
                                if (day.formattedDT != chat.messages[0].data[0].formattedDT) {
                                    Text(day.formattedDT)
                                        .fontWeight(.semibold)
                                }
                                ForEach(day.data) { msg in
                                    VStack(alignment: .leading, spacing: 6) {
                                        Text(msg.message)
                                        Text(msg.timeString)
                                            .font(.system(size: 14))
                                            .foregroundStyle(.gray)
                                    }
//                                    .frame(maxWidth: 500, alignment: .leading)
                                    .padding()
                                    .background(msg.from == "self" ? .lightGreen : .lightBlue)
                                    .cornerRadius(16)
                                    .modifier(CustomFrameModifier(from: msg.from))

                                }
                            }
                        }
                    }
                    
                    Spacer()
                    
                    HStack(spacing: 16) {
                        PhotosPicker(selection: $selectedItems, matching: .any(of: [.screenshots, .images])) {
                      
                                Image(systemName: "plus")
                                    .resizable()
                                    .scaledToFit()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 15, height: 15)
                            .foregroundStyle(.forest)
                        }
                        .onChange(of: selectedItems) {
                            Task {
                                selectedImages.removeAll()
                                
                                for item in selectedItems {
                                    if let image = try? await item.loadTransferable(type: Image.self) {
                                        selectedImages.append(image)
                                    }
                                }
                            }
                        }
                        TextField("Enter a message...", text: $message)
                        //                            .accentColor(.forest)
                            .padding()
                            .background(.multiplyBeige)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .cornerRadius(16)
                        Button {
                            print("Image tapped!")
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
//                    .frame(maxHeight: .infinity, alignment: .bottom)
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
}

//#Preview {
//    ChatView()
//}
