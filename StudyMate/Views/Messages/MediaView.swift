//
//  MediaView.swift
//  StudyMate
//
//  Created by Maddie Adair on 10/21/24.
//

import SwiftUI

struct MediaView: View {
    var fullName: String
    var username: String
    var profilePic: URL
    
    @Environment(\.dismiss) var dismiss
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    
    var body: some View {
        ZStack {
            Color.lightBeige
                .ignoresSafeArea()
            
            VStack {
                HStack(spacing: 14) {
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .aspectRatio(1.2, contentMode: .fill)
                        .overlay(
                            AsyncImage(url: profilePic) { image in
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
                        Text(fullName)
                            .foregroundStyle(.black)
                            .font(.system(size: 16, weight: .semibold))
                            .frame(maxWidth: 130, alignment: .leading)
                            .lineLimit(1)
                            .truncationMode(.tail)
                        Text("@\(username)")
                            .font(.system(size: 14))
                            .foregroundStyle(.black)
                            .frame(maxWidth: 130, alignment: .leading)
                            .lineLimit(1)
                            .truncationMode(.tail)
                    }
                    
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom, 30)
                
                Divider()
                
                Spacer()
                    .frame(height: 30)
                
                ScrollView(showsIndicators: false) {
                    
                    VStack(alignment: .leading, spacing: 20) {
                        Text("Media")
                            .font(.system(size: 24, weight: .semibold))
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        LazyVGrid(columns: columns, spacing: 20) {
                            ForEach(0..<6, id: \.self) { i in
                                AsyncImage(url: URL(string:"https://picsum.photos/200")) { image in
                                    image
                                        .resizable()
                                        .scaledToFill()
                                        .frame(maxWidth: 300, maxHeight: 300)
                                        .cornerRadius(20)
                                    
                                } placeholder: {
                                    ProgressView()
                                }
                            }
                        }
                        
                        
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
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
}
