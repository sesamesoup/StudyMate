//
//  CreateNewMessageView.swift
//  StudyMate
//
//  Created by Sarang Mistry on 12/4/24.
//

import SwiftUI

struct CreateNewMessageView: View {
    let didSelectNewUser : (OtherUser) -> ()
    @ObservedObject var createNewMessageViewModel = CreateNewMessageViewModel()
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        
        NavigationStack {
            ZStack {
                Color.lightBeige
                    .ignoresSafeArea()
                
                
                VStack(alignment: .leading) {
//                    Text("New Message")
//                        .font(.custom("InstrumentSerif-Regular", size: 48))
//                        .foregroundStyle(.forest)
                    
                    ScrollView {
                        VStack(alignment: .leading){
                            ForEach(createNewMessageViewModel.users) { user in
                                
                                // Button for each user
                                Button(action: {
                                    dismiss()
                                    didSelectNewUser(user)
                                }) {
                                    VStack {
                                        // User profile image
                                        HStack {
                                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                                .aspectRatio(1.2, contentMode: .fill)
                                            
                                                .overlay(
                                                    Image(user.profilePicture)
                                                        .resizable()
                                                        .scaledToFill()
                                                        .offset(x: -4.0, y: 0.0)
                                                )
                                                .frame(width: 40, height: 40, alignment: .leading)
                                                .clipShape(RoundedRectangle(cornerRadius: 10,
                                                                            style: .continuous))
                                            
                                            // User full name and username
                                            VStack(alignment: .leading, spacing: 6) {
                                                Text("\(user.firstName) \(user.lastName)")
                                                    .foregroundStyle(.black)
                                                    .font(.system(size: 14, weight: .semibold))
                                                    .frame(maxWidth: 130, alignment: .leading)
                                                    .lineLimit(1)
                                                    .truncationMode(.tail)
                                                
                                                // User username
                                                Text("@\(user.username)")
                                                    .foregroundStyle(.black)
                                                    .font(.system(size: 14))
                                                    .frame(maxWidth: 130, alignment: .leading)
                                                    .lineLimit(1)
                                                    .truncationMode(.tail)
                                                
                                            }
                                            
                                        }
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .padding()
                                        .background(.multiplyBeige)
                                        .cornerRadius(16)
                                        
                                    }
                                }
                            }
                        }
                    }
                }
                .navigationTitle("New Message")
                .navigationBarTitleDisplayMode(.inline)
                .padding(30)
                .toolbar {
                    ToolbarItemGroup(placement: .navigationBarLeading) {
                        Button {
                            dismiss()
                        } label: {
                            Text("Cancel")
                                .foregroundStyle(.forest)
                            
                        }
                    }
                }
            }
        }
    }
    
}


//#Preview {
//    CreateNewMessageView()
//}
