//
//  PostHistoryView.swift
//  StudyMate
//
//  Created by Maddie Adair on 10/19/24.
//

import SwiftUI
import Firebase
import FirebaseAuth

struct PostHistoryView: View {
    //    @Binding var viewModel: ProfileViewModel
    @State private var postToDelete: UserPost?
    @State private var showDeleteAlert = false
    @ObservedObject var viewModel: ProfileViewModel
    @Environment(\.dismiss) var dismiss
    
    @Environment(\.verticalSizeClass) var verticalSizeClass: UserInterfaceSizeClass?
    
    @State var datas = ["Row 1", "Row 2", "Row 3"]
    
    
    var body: some View {
        ZStack {
            Color.lightBeige
                .ignoresSafeArea()
            
            VStack {
                Text("Post History")
                    .font(.custom("InstrumentSerif-Regular", size: 48))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, verticalSizeClass == .regular ? 40: 10)
                
                Spacer().frame(height: 50)
                
                // If user has not made any posts
                if viewModel.userPosts.isEmpty {
                    Text("You have no posts yet.")
                        .foregroundColor(.gray)
                        .padding()
                } else {
                    // Show list of posts made
                    List{
                        ForEach(viewModel.userPosts, id: \.id) { post in
                            HStack {
                                PrevPostRow(post: post)
                                    .swipeActions {
                                        Button(role: .destructive) {
                                            postToDelete = post
                                            showDeleteAlert = true
                                        } label: {
                                            Label("Delete", systemImage: "trash")
                                        }
                                    }
                                    .padding(6)
                                
                            }
                            .listRowSeparator(.hidden)
                            .listRowBackground(
                                Color.multiplyBeige
                            .cornerRadius(16)
                            )
                        }
                    }
                    .listStyle(.plain)
                    .listRowSpacing(10)
                    .alert("Delete Post", isPresented: $showDeleteAlert) {
                        Button("Cancel", role: .cancel) {}
                        Button("Delete", role: .destructive) {
                            if let postToDelete = postToDelete {
                                deletePost(postToDelete)
                            }
                        }
                    } message: {
                        Text("Are you sure you want to delete the post titled \"\(postToDelete?.title ?? "Unknown")\"?")
                    }
                }
                Spacer()
            }
            .padding(30)
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
        }
    }
    
    //
    func deletePost(_ post: UserPost) {
        guard let id = post.id else { return }
        
        // Delete from Firestore
        let db = Firestore.firestore()
        //
        guard let currentUserID = Auth.auth().currentUser?.uid else { return}
        db.collection("users").document(currentUserID).collection("posts").document(id).delete { error in
            if let error = error {
                print("Failed to delete post: \(error.localizedDescription)")
            } else {
                // Remove locally
                DispatchQueue.main.async {
                    self.viewModel.userPosts.removeAll { $0.id == id }
                    print("Succedssfully deleted post")
                }
            }
        }
    }
}
