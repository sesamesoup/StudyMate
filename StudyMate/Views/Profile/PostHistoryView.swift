//
//  PostHistoryView.swift
//  StudyMate
//
//  Created by Maddie Adair on 10/19/24.
//

import SwiftUI

struct PostHistoryView: View {
//    @StateObject private var prevPostModel = PrevPostViewModel()
    @Environment(\.dismiss) var dismiss

    var body: some View {
        ZStack {
            Color.lightBeige
                .ignoresSafeArea()
            
            ScrollView(showsIndicators: false) {
                VStack {
                    Text("Post History")
                    //                    .font(.system(size: 32, weight: .semibold))
                    
                        .font(.custom("InstrumentSerif-Regular", size: 48))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top, 40)
                    
                    Spacer()
                        .frame(height: 50)
                    
                    VStack(spacing: 25) {
                        ForEach(prevPosts, id: \.id) { post in
                            PrevPostRow(post: post)
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

#Preview {
    PostHistoryView()
}
