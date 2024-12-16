//
//  PostRow.swift
//  StudyMate
//
//  Created by Maddie Adair on 10/20/24.
//
import SwiftUI
import Firebase

struct PostRow: View {
    var post: AllUserPosts

    
    var body: some View {
        NavigationLink(destination: PostDetailView(post: post).toolbar(.hidden, for: .tabBar)) {
            HStack {
                HStack(spacing: 14) {
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .aspectRatio(1.2, contentMode: .fill)

                        .overlay(
                            Image(post.userInfo.profilePicture)
                                .resizable()
                                .scaledToFill()
                                .offset(x: -4.0, y: 0.0)
                        )
                        .frame(width: 40, height: 40, alignment: .leading)
                        .clipShape(RoundedRectangle(cornerRadius: 10,
                                                    style: .continuous))
                    // Post Title
                    VStack(alignment: .leading, spacing: 6) {
                        Text(post.title.capitalized)
                            .foregroundStyle(.black)
                            .font(.system(size: 14, weight: .semibold))
                            .frame(maxWidth: 130, alignment: .leading)
                            .lineLimit(1)
                            .truncationMode(.tail)
                        // Post Descriptions
                        Text(post.description)
                            .font(.system(size: 12))
                            .foregroundStyle(.black)
                            .frame(maxWidth: 130, alignment: .leading)
                            .lineLimit(1)
                            .truncationMode(.tail)
                    }
                    
                    
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                Spacer()
                
                Text("\(formatDate(from: post.createdAt))")
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
    //
    func formatDate(from timestamp: Timestamp) -> String {
        let date = timestamp.dateValue() // Convert Timestamp to Date
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM dd, yyyy" // Set the desired format
        return formatter.string(from: date)
    }
}
