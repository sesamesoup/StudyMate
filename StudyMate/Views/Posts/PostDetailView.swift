//
//  PostDetailView.swift
//  StudyMate
//
//  Created by Maddie Adair on 10/19/24.
//

import SwiftUI

import SwiftUI
import Firebase

struct PostDetailView: View {
    var post: AllUserPosts
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            Color.lightBeige
                .ignoresSafeArea()
            // -------------------  Scroll view -----------------------
            ScrollView(showsIndicators: false) {
                
                //
                VStack(alignment: .leading, spacing: 60) {
                    VStack(spacing: 24) {
                        // Title
                        Text(post.title.capitalized)
                            .font(.custom("InstrumentSerif-Regular", size: 40))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.top, 40)
                        // subject
                        VStack(spacing: 30) {
                            Text(post.subject.capitalized)
                                .font(.system(size: 14))
                                .padding(10)
                                .background(.forest)
                                .foregroundStyle(.lightBeige)
                                .cornerRadius(16)
                            
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            HStack {
                                RoundedRectangle(cornerRadius: 10, style: .continuous)
                                    .aspectRatio(1.2, contentMode: .fill)
                                
                                    .overlay(
                                        Image(post.userInfo.profilePicture)
                                            .resizable()
                                            .scaledToFill()
                                            .offset(x: -4.0, y: 0.0)
                                    )
                                    .frame(width: 40, height: 40, alignment: .leading)
                                    .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                                
                                
                                // fistName lastName and Username
                                VStack(alignment: .leading, spacing: 6) {
                                    Text("\(post.userInfo.firstName) \(post.userInfo.lastName)")
                                        .foregroundStyle(.black)
                                        .font(.system(size: 14, weight: .bold))
                                    Text("@\(post.userInfo.username)")
                                        .font(.system(size: 14))
                                        .foregroundStyle(.black)
                                }
                                //
                                Spacer()
                                
                                Text("\(formatDate(from: post.createdAt))")
                                    .frame(alignment: .trailing)
                                    .foregroundStyle(.black)
                                    .font(.system(size: 14))
                                
                                
                            }
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .leading)
                        }
                    }
                    // Fix the descriptions part
                    Text(post.description)
                    // If not empty render the images
                    if !post.images.isEmpty {
                        ScrollView(.horizontal, showsIndicators: true) {
                            // HStack for images
                            HStack {
                                ForEach(post.images, id: \.self) { imageUrlString in
                                    // Convert to url
                                    if let imageUrl = URL(string: imageUrlString) {
                                        AsyncImage(url: imageUrl) { image in
                                            image
                                                .resizable()
                                                .scaledToFill()
                                                .frame(height: 200)
                                        } placeholder: {
                                            ProgressView()
                                        }
                                    } else {
                                        // Fallback for invalid URLs
                                        Text("Invalid URL")
                                            .frame(height: 200)
                                            .foregroundColor(.red)
                                    }
                                }
                            }
                            
                        }
                    }
                    
                    Spacer()
                    // Message Part Here
//                    NavigationLink(destination: NewMessageView(post: post)) {
//                        HStack(spacing: 12) {
//                            Text("Message")
//                                .bold()
//                            
//                            Image(systemName: "paperplane")
//                                .resizable()
//                                .scaledToFit()
//                                .aspectRatio(contentMode: .fit)
//                                .frame(width: 15, height: 15)
//                        }
//                        .padding()
//                        .background(.forest)
//                        .clipShape(.capsule)
//                        .foregroundStyle(.beige)
//                        .frame(maxWidth: .infinity, alignment: .trailing)
//                    }
                    HStack(spacing: 12) {
                        Text("Message")
                            .bold()
                        
                        Image(systemName: "paperplane")
                            .resizable()
                            .scaledToFit()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 15, height: 15)
                    }
                    .padding()
                    .background(.forest)
                    .clipShape(.capsule)
                    .foregroundStyle(.beige)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                }
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
    //
    func formatDate(from timestamp: Timestamp) -> String {
        let date = timestamp.dateValue() // Convert Timestamp to Date
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM dd, yyyy" // Set the desired format
        return formatter.string(from: date)
    }
}

//#Preview {
//    PostDetailView(post: postArr[0])
//}

