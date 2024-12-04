//
//  NewMessageView.swift
//  StudyMate
//
//  Created by Maddie Adair on 10/24/24.
//


import SwiftUI
import PhotosUI
//
//struct NewMessageView: View {
//    var post: Post
//    @Environment(\.dismiss) var dismiss
//    @State private var message: String = ""
//    
//    @State private var selectedItems = [PhotosPickerItem]()
//    @State private var selectedImages = [Image]()
//    
//    var body: some View {
//        ZStack {
//            Color.lightBeige
//                .ignoresSafeArea()
//            
//           
//                VStack {
//                    HStack {
//                        RoundedRectangle(cornerRadius: 10, style: .continuous)
//                            .aspectRatio(1.2, contentMode: .fill)
//                            .overlay(
//                                AsyncImage(url: post.profilePic) { image in
//                                    image
//                                        .resizable()
//                                        .scaledToFill()
//                                        .offset(x: -4.0, y: 0.0)
//                                    
//                                } placeholder: {
//                                    ProgressView()
//                                }
//                                
//                            )
//                            .frame(width: 40, height: 40, alignment: .leading)
//                            .clipShape(RoundedRectangle(cornerRadius: 10,
//                                                        style: .continuous))
//                        
//                        VStack(alignment: .leading, spacing: 6) {
//                            Text(post.fullName)
//                                .foregroundStyle(.black)
//                                .font(.system(size: 16, weight: .semibold))
//                                .frame(maxWidth: 130, alignment: .leading)
//                                .lineLimit(1)
//                                .truncationMode(.tail)
//                            Text("@\(post.username)")
//                                .font(.system(size: 14))
//                                .foregroundStyle(.black)
//                                .frame(maxWidth: 130, alignment: .leading)
//                                .lineLimit(1)
//                                .truncationMode(.tail)
//                        }
//                        
//                        Spacer()
//                        
//                        NavigationLink(destination: MediaView(fullName: post.fullName, username: post.username, profilePic: post.profilePic).toolbar(.hidden, for: .tabBar)){
//                            Image(systemName: "photo.fill")
//                                .resizable()
//                                .scaledToFit()
//                                .aspectRatio(contentMode: .fit)
//                                .frame(width: 20, height: 20)
//                                .padding(8)
//                                .background(.forest)
//                                .cornerRadius(12)
//                                .foregroundStyle(.beige)
//                        }
//                    }
//                    .frame(maxWidth: .infinity, alignment: .leading)
//                    .padding(.bottom, 30)
//                    
//                    Divider()
//                    
//                    Spacer()
//                        .frame(height: 30)
//                    
//                    ScrollView(showsIndicators: false) {
//                        
//                        Text("")
//                    }
//                    
//                    Spacer()
//                    
//                    HStack(spacing: 16) {
//                        PhotosPicker(selection: $selectedItems, matching: .any(of: [.screenshots, .images])) {
//                      
//                                Image(systemName: "plus")
//                                    .resizable()
//                                    .scaledToFit()
//                                    .aspectRatio(contentMode: .fit)
//                                    .frame(width: 15, height: 15)
//                            .foregroundStyle(.forest)
//                        }
//                        .onChange(of: selectedItems) {
//                            Task {
//                                selectedImages.removeAll()
//                                
//                                for item in selectedItems {
//                                    if let image = try? await item.loadTransferable(type: Image.self) {
//                                        selectedImages.append(image)
//                                    }
//                                }
//                            }
//                        }
//                        TextField("Enter a message...", text: $message)
//                        //                            .accentColor(.forest)
//                            .padding()
//                            .background(.multiplyBeige)
//                            .frame(maxWidth: .infinity, alignment: .leading)
//                            .cornerRadius(16)
//                        Button {
//                            print("Image tapped!")
//                        } label: {
//                            Image(systemName: "paperplane")
//                            //                                        .resizable()
//                            //                                        .scaledToFit()
//                            //                                        .aspectRatio(contentMode: .fit)
//                                .frame(width: 20, height: 20, alignment: .trailing)
//                                .padding(10)
//                                .background(.forest)
//                                .foregroundStyle(.beige)
//                                .clipShape(Capsule())
//
//                        }
//                    }
////                    .frame(maxHeight: .infinity, alignment: .bottom)
//                }
//                .navigationBarBackButtonHidden(true)
//                .toolbar {
//                    ToolbarItem(placement: .topBarLeading) {
//                        Button(action: {
//                            dismiss()
//                        }) {
//                            HStack(spacing: 10) {
//                                Image(systemName: "arrow.left")
//                                    .foregroundStyle(.forest)
//                                
//                                Text("Back")
//                                    .foregroundStyle(.forest)
//                            }
//                            
//                        }
//                    }
//                }
//                .padding(30)
//            }
//            
//        
//    }
//}

//#Preview {
//    NewMessageView()
//}
