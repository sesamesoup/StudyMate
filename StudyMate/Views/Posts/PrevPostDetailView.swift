//
//  PrevPostDetailView.swift
//  StudyMate
//
//  Created by Maddie Adair on 10/20/24.
//

import SwiftUI

struct PrevPostDetailView: View {
    var post: PrevPost
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
                            
                            Text(post.formattedDT)
                                .frame(alignment: .trailing)
                                .foregroundStyle(.black)
                                .font(.system(size: 14))
                                                        
                            
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    
                    Text(post.description)
                    
                    ScrollView(.horizontal, showsIndicators: true) {
                        HStack() {
                            ForEach(post.image, id: \.self) { i in
                                AsyncImage(url: i) { image in
                                    image
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: .infinity, height: 200)
                                    
                                } placeholder: {
                                    ProgressView()
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
}

#Preview {
    PrevPostDetailView(post: prevPosts[4])
}

