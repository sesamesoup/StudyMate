//
//  PrevPostRow.swift
//  StudyMate
//
//  Created by Maddie Adair on 10/20/24.
//
import SwiftUI
import Firebase

struct PrevPostRow: View {
    var post: UserPost

    
    var body: some View {
        // go to deatil if clicked
        NavigationLink(destination: PrevPostDetailView(post: post)) {
            HStack {
                // Title and descriptiong
                VStack {
                    VStack(alignment: .leading, spacing: 6) {
                        Text(post.title)
                            .foregroundStyle(.black)
                            .font(.system(size: 14, weight: .semibold))
                            .frame(maxWidth: 130, alignment: .leading)
                            .lineLimit(1)
                            .truncationMode(.tail)
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
                
                Text(formatDate(from: post.createdAt))
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
    func formatDate(from timestamp: Timestamp) -> String {
        let date = timestamp.dateValue() // Convert Timestamp to Date
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM dd, yyyy" // Set the desired format
        return formatter.string(from: date)
    }
}

//#Preview {
//    PrevPostRow(post: PrevPost( title: "Example", description: "Example", datetime: "2024-10-20T18:06:05.299Z", subject: "Architecture", image: ["https://avatar.iran.liara.run/public/3"].compactMap { URL(string:$0) }))
//}
