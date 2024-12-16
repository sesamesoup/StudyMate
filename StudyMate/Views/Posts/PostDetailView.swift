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
    @Environment(\.verticalSizeClass) var verticalSizeClass: UserInterfaceSizeClass?
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            Color.lightBeige
                .ignoresSafeArea()
            // -------------------  Scroll view -----------------------
            ScrollView(showsIndicators: false) {
                
                //
                VStack(alignment: .leading, spacing: 20) {
                    VStack(spacing: 24) {
                        // Title
                        Text(post.title.capitalized)
                            .font(.custom("InstrumentSerif-Regular", size: 40))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.top, verticalSizeClass == .regular ? 40: 10)
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
                                
                                // User image
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
                                
                                // Date created
                                Text("\(formatDate(from: post.createdAt))")
                                    .frame(alignment: .trailing)
                                    .foregroundStyle(.black)
                                    .font(.system(size: 14))
                                
                                
                            }
                            .padding(.vertical, 20)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        }
                    }
                    Spacer()
                    // Description
                    Text(post.description)
                    
                    Spacer()
                    
                    // Post image
                    AsyncImage(url: URL(string: post.image)) { phase in
                        if let image = phase.image {
                            image
                                .resizable()
                                .scaledToFit()
                        } else if phase.error != nil {
                            Text("No image available")
                        } else {
                            //                                        print("No image uploaded")
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    
                    
                    Spacer()
                    
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

