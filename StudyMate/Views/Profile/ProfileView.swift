//
//  ProfileView.swift
//  StudyMate
//
//  Created by Maddie Adair on 10/19/24.
//

import SwiftUI

struct ProfileView: View {
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
            
            
            VStack(spacing: 40) {
                RoundedRectangle(cornerRadius: 50,
                                 style: .continuous)
                .aspectRatio(1.4, contentMode: .fill)
                .overlay(
                    Image("profile")
                        .resizable()
                        .scaledToFill()
                        .offset(x: -30.0, y: 20.0)
                )
                .frame(width: 150, height: 150, alignment: .leading)
                .clipShape(RoundedRectangle(cornerRadius: 50,
                                            style: .continuous))
                
                VStack(alignment: .center, spacing: 50) {
                    VStack(spacing: 14) {
                        VStack(spacing: 6) {
                            Text("\(firstName) \(lastName)")
                            //                                .font(.system(size: 32, weight: .semibold))
                            
                            
                                .font(.custom("InstrumentSerif-Regular", size: 48))
                                .foregroundStyle(.black)
                            
                            Text("@\(username)")
                                .font(.system(size: 20, weight: .semibold))
                                .foregroundStyle(.black)
                        }
                        
                        Text("\(major) - \(year)")
                            .foregroundStyle(.black)
                    }
                    
                    VStack(spacing: 20) {
                        
                        
                        Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit.")
                            .foregroundStyle(.black)
                            .multilineTextAlignment(.center)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                    
                }
                .frame(maxWidth: .infinity)
                
                //                Spacer()
                
                VStack(spacing: 14) {
                    
                    NavigationLink(destination: EditProfileView(major: $major, year: $year, description: $description).navigationBarBackButtonHidden(true)) {
                        HStack {
                            Text("Edit Profile")
                                .foregroundStyle(.forest)
                                .fontWeight(.semibold)
                            
                            Spacer()

                            Image(systemName: "chevron.right")
                                .padding(6)
                                .foregroundStyle(.black)
                                .background(.blendMode(.multiply).opacity(0.2))
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
                                .background(.blendMode(.multiply).opacity(0.2))
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
                    
                    NavigationLink(destination: SignInView().navigationBarBackButtonHidden(true)) {
                        Text("Log Out")
                            .foregroundStyle(.beige)
                            .fontWeight(.semibold)
                    }
                    .frame(maxWidth: .infinity, maxHeight: 30, alignment: .leading)
                    .padding()
                    .background(.forest)
                    .cornerRadius(16)
                }
                .frame(maxWidth: .infinity)
                
                
                Spacer()
            }
            .padding(30)
            
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    ProfileView()
}
