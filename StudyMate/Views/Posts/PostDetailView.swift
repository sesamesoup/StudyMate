//
//  PostDetailView.swift
//  StudyMate
//
//  Created by Maddie Adair on 10/19/24.
//

import SwiftUI

import SwiftUI

struct PostDetailView: View {
    var post: Post
    @Environment(\.dismiss) var dismiss

    var body: some View {
        ZStack {
            Color.lightBeige
                .ignoresSafeArea()
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 60) {
                    VStack(spacing: 24) {
                        Text(post.title)
                        //                        .font(.system(size: 32, weight: .semibold))
                            .font(.custom("InstrumentSerif-Regular", size: 40))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.top, 40)
                        
                        VStack(spacing: 30) {
                            Text(post.subject)
                                .font(.system(size: 14))
                                .padding(10)
                                .background(.forest)
                                .foregroundStyle(.lightBeige)
                                .cornerRadius(16)
                            
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            HStack {
                                NavigationLink(destination: OtherProfileView(fullName: post.fullName, username: post.username, major: post.subject, year: "Sophomore", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.", profilePic: post.profilePic)){
                                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                                        .aspectRatio(1.2, contentMode: .fill)
                                        .overlay(
                                            AsyncImage(url: post.profilePic) { image in
                                                image
                                                    .resizable()
                                                    .scaledToFill()
                                                    .offset(x: -4.0, y: 0.0)
                                                
                                            } placeholder: {
                                                ProgressView()
                                            }
                                        )
                                }
                                .frame(width: 40, height: 40, alignment: .leading)
                                .clipShape(RoundedRectangle(cornerRadius: 10,
                                                            style: .continuous))
                                
                                
                                VStack(alignment: .leading, spacing: 6) {
                                    Text(post.fullName)
                                        .foregroundStyle(.black)
                                        .font(.system(size: 14, weight: .bold))
                                    Text("@\(post.username)")
                                        .font(.system(size: 14))
                                        .foregroundStyle(.black)
                                }
                                
                                Spacer()
                                
                                Text(post.formattedDT)
                                    .frame(alignment: .trailing)
                                    .foregroundStyle(.black)
                                    .font(.system(size: 14))
                                
                                
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                        }
                    }
                    
                    Text(post.description)
                    
                    ScrollView(.horizontal, showsIndicators: true) {
                        HStack() {
                            ForEach(post.image, id: \.self) { i in
                                AsyncImage(url: i) { image in
                                    image
                                        .resizable()
                                        .scaledToFill()
                                        .frame(height: 200)
                                    
                                } placeholder: {
                                    ProgressView()
                                }
                            }
                        }
                    }
                    
                    Spacer()
                    
                    NavigationLink(destination: NewMessageView(post: post)) {
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

#Preview {
    PostDetailView(post: postArr[0])
}

