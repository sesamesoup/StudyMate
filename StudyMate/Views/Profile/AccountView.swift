//
//  AccountView.swift
//  StudyMate
//
//  Created by Maddie Adair on 10/24/24.
//

import SwiftUI

struct AccountView: View {
//    @StateObject private var prevPostModel = PrevPostViewModel()
    @Environment(\.dismiss) var dismiss
    
 
    @State private var firstName = "Jane"
    @State private var lastName = "Doe"
    @State private var major = majors[0]
    @State private var year = years[1]
    @State private var email = "janedoe@mail.com"
    @State private var description = "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
    @State private var username = "janedoe"
    @State private var password = "password"
    @State private var confirmPassword = "password"
    
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
                        NavigationLink(destination: EditProfileView(major: $major, year: $year, description: $description).navigationBarBackButtonHidden(true)) {
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
                            .background(.customGrey)
                            .overlay(
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke(.gray, lineWidth: 1)
                            )
                        }
                        
                        NavigationLink(destination: EditPersonalInfoView(firstName: $firstName, lastName: $lastName, username: $username, password: $password, confirmPassword: $confirmPassword, email: $email).navigationBarBackButtonHidden(true)) {
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
                            .background(.customGrey)
                            .overlay(
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke(.gray, lineWidth: 1)
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
            .padding(30)
        }
    }
}

#Preview {
    AccountView()
}
