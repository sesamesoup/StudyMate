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
    @Environment(\.verticalSizeClass) var verticalSizeClass: UserInterfaceSizeClass?
    
    var body: some View {
        ZStack {
            Color.lightBeige
                .ignoresSafeArea()
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 20) {
                    VStack(spacing: 24) {
                        Text(post.title)
                            .font(.custom("InstrumentSerif-Regular", size: 40))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.top, verticalSizeClass == .regular ? 40: 10)
                        
                        HStack() {
                            // Subject
                            Text(post.subject)
                                .font(.system(size: 14))
                                .padding(10)
                                .background(.forest)
                                .foregroundStyle(.lightBeige)
                                .cornerRadius(16)
                            
                            Spacer()
                            
                            // Date Created
                            Text(formatDate(from: post.createdAt))
                                .frame(alignment: .trailing)
                                .foregroundStyle(.black)
                                .font(.system(size: 14))
                            
                            
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    Spacer()
                    // Description
                    Text(post.description)
                    
                    Spacer()
                    // Post Image
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
    func formatDate(from timestamp: Timestamp) -> String {
        let date = timestamp.dateValue() // Convert Timestamp to Date
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM dd, yyyy" // Set the desired format
        return formatter.string(from: date)
    }
}

