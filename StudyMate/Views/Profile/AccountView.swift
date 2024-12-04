//
//  AccountView.swift
//  StudyMate
//
//  Created by Maddie Adair on 10/24/24.
//

import SwiftUI

struct AccountView: View {
    @ObservedObject var viewModel: ProfileViewModel
    @Environment(\.dismiss) var dismiss
    
    
    var body: some View {
        ZStack {
            Color.lightBeige
                .ignoresSafeArea()
            
            ScrollView(showsIndicators: false) {
                VStack {
                    Text("Account")
                    //                    .font(.system(size: 32, weight: .semibold))
                    
                        .font(.custom("InstrumentSerif-Regular", size: 48))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top, 40)
                    
                    Spacer()
                        .frame(height: 50)
                    
                    
                    
                    VStack(spacing: 25) {
                        // Edit Profile Navigation Link
                        NavigationLink(destination: EditProfileView(major: viewModel.userProfile!.major, year: viewModel.userProfile!.year, profileIcon: viewModel.userProfile!.profilePicture).navigationBarBackButtonHidden(true)) {
                            HStack {
                                Text("Edit Profile")
                                    .foregroundStyle(.forest)
                                    .fontWeight(.semibold)
                                
                                Spacer()
                                
                                Image(systemName: "chevron.right")
                                    .padding(6)
                                    .foregroundStyle(.black)
                                    .clipShape(Capsule())
                            }
                            .frame(maxWidth: .infinity, maxHeight: 30, alignment: .leading)
                            .padding()
                            .cornerRadius(16)
                            .background(Color.customGrey)
                            .overlay(
                                RoundedRectangle(cornerRadius: 16)
                                    .strokeBorder(Color.gray, lineWidth: 1)
                            )
                        }
                        
                        // Edit Personal Information Navigation Link
                        NavigationLink(destination: EditPersonalInfoView(
                            firstName: viewModel.userProfile?.firstName ?? "",
                            lastName: viewModel.userProfile?.lastName ?? "",
                            email: viewModel.userProfile?.email ?? ""
                        ).navigationBarBackButtonHidden(true)) {
                            HStack {
                                Text("Personal Information")
                                    .foregroundStyle(.forest)
                                    .fontWeight(.semibold)
                                
                                Spacer()
                                
                                Image(systemName: "chevron.right")
                                    .padding(6)
                                    .foregroundStyle(.black)
                                    .clipShape(Capsule())
                            }
                            .frame(maxWidth: .infinity, maxHeight: 30, alignment: .leading)
                            .padding()
                            .cornerRadius(16)
                            .background(Color.customGrey)
                            .overlay(
                                RoundedRectangle(cornerRadius: 16)
                                    .strokeBorder(Color.gray, lineWidth: 1)
                            )
                        }
                        
                        // Reset Password Navigation Link
                        NavigationLink(destination: PasswordView().navigationBarBackButtonHidden(true)) {
                            HStack {
                                Text("Reset Password")
                                    .foregroundStyle(.forest)
                                    .fontWeight(.semibold)
                                
                                Spacer()
                                
                                Image(systemName: "chevron.right")
                                    .padding(6)
                                    .foregroundStyle(.black)
                                    .clipShape(Capsule())
                            }
                            .frame(maxWidth: .infinity, maxHeight: 30, alignment: .leading)
                            .padding()
                            .cornerRadius(16)
                            .background(Color.customGrey)
                            .overlay(
                                RoundedRectangle(cornerRadius: 16)
                                    .strokeBorder(Color.gray, lineWidth: 1)
                            )
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
//            .onAppear() {
//                copyProfileIcon = viewModel.userProfile?.profilePicture ?? ""
//            }
            .padding(30)
        }
    }
}
