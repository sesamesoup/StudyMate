//
//  PostHistoryView.swift
//  StudyMate
//
//  Created by Maddie Adair on 10/19/24.
//

import SwiftUI

struct PostHistoryView: View {
//    @Binding var viewModel: ProfileViewModel
    @ObservedObject var viewModel: ProfileViewModel
    @Environment(\.dismiss) var dismiss

    var body: some View {
        ZStack {
            Color.lightBeige
                .ignoresSafeArea()
            
            ScrollView(showsIndicators: false) {
                VStack {
                    Text("Post History")
                        .font(.custom("InstrumentSerif-Regular", size: 48))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top, 40)
                    
                    Spacer()
                        .frame(height: 50)
                    //
                    if viewModel.userPosts.isEmpty {
                        // add Style
                        Text("You no post yet.")
                    }
                    else{
                        VStack(spacing: 25) {
                            ForEach(viewModel.userPosts, id: \.id) { post in
                                PrevPostRow(post:post)
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
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
            .onAppear {
                Task {
                    await viewModel.fetchCurrentUserPosts()
                }
            }
            .padding(30)
        }
    }
}
