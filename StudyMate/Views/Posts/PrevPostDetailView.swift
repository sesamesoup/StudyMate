//
//  PrevPostDetailView.swift
//  StudyMate
//
//  Created by Maddie Adair on 10/20/24.
//

import SwiftUI
import Firebase
struct PrevPostDetailView: View {
    var post: UserPost
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
                        
                        // alignment: .leading, spacing: 16
                        HStack() {
                            Text(post.subject)
                                .font(.system(size: 14))
                                .padding(10)
                                .background(.forest)
                                .foregroundStyle(.lightBeige)
                                .cornerRadius(16)
                            
                            Spacer()
                            
                            Text(formatDate(from: post.createdAt))
                                .frame(alignment: .trailing)
                                .foregroundStyle(.black)
                                .font(.system(size: 14))
                                                        
                            
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    
                    Text(post.description)
                    
                    ScrollView(.horizontal, showsIndicators: true) {
                        HStack {
                            ForEach(post.images, id: \.self) { imageUrlString in
                                if let imageUrl = URL(string: imageUrlString) {
                                    AsyncImage(url: imageUrl) { image in
                                        image
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 200, height: 200) // Adjust width and height as needed
                                            .clipShape(RoundedRectangle(cornerRadius: 10)) // Optional: Add styling
                                    } placeholder: {
                                        ProgressView()
                                            .frame(width: 200, height: 200) // Match the size for consistency
                                    }
                                } else {
                                    // Fallback for invalid URLs
                                    Text("Invalid URL")
                                        .frame(width: 200, height: 200)
                                        .background(Color.gray.opacity(0.3))
                                        .foregroundColor(.red)
                                        .clipShape(RoundedRectangle(cornerRadius: 10)) // Optional styling
                                }
                            }
                        }
                    }

                    
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
    func formatDate(from timestamp: Timestamp) -> String {
        let date = timestamp.dateValue() // Convert Timestamp to Date
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM dd, yyyy" // Set the desired format
        return formatter.string(from: date)
    }
}

