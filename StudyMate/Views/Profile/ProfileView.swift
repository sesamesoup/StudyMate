//
//  ProfileView.swift
//  StudyMate
//
//  Created by Maddie Adair on 10/19/24.
//

import SwiftUI
import FirebaseAuth

struct ProfileView: View {
    //
    //
    @StateObject private var viewModel = ProfileViewModel()
    @AppStorage("navigateToHome") var navigateToHome: Bool = false
    //
//    @State private var firstName = "Jane"
//    @State private var lastName = "Doe"
//    @State private var major = majors[0]
//    @State private var year = years[1]
    @State private var profileIcon = "girl1"
//    @State private var email = "janedoe@mail.com"
//    @State private var description = "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
//    @State private var username = "janedoe"
//    @State private var password = "password"
//    @State private var confirmPassword = "password"


    var body: some View {
        ZStack {
            Color.lightBeige
                .ignoresSafeArea()
            
            
            VStack(spacing: 40) {
                RoundedRectangle(cornerRadius: 50,
                                 style: .continuous)
                .aspectRatio(1.4, contentMode: .fill)
                .overlay(
                    Image(viewModel.userProfile?.profilePicture ?? "person.circle.fill")
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
                            Text("\(viewModel.userProfile?.firstName ?? "FirstName") \(viewModel.userProfile?.lastName ?? "LastName")")
                            //                                .font(.system(size: 32, weight: .semibold))
                            
                            
                                .font(.custom("InstrumentSerif-Regular", size: 48))
                                .foregroundStyle(.black)
                            
                            Text("@\(viewModel.userProfile?.username ?? "--")")
                                .font(.system(size: 20, weight: .semibold))
                                .foregroundStyle(.black)
                        }
                        
                        Text("\(viewModel.userProfile?.major ?? "Major") - \(viewModel.userProfile?.year ?? "--")")
                            .foregroundStyle(.black)
                    }
                    
//                    VStack(spacing: 20) {
//                        
//                        
//                        Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit.")a
//                            .foregroundStyle(.black)
//                            .multilineTextAlignment(.center)
//                            .fixedSize(horizontal: false, vertical: true)
//                    }
                    
                }
                .frame(maxWidth: .infinity)
                
                //                Spacer()
                
                VStack(spacing: 20) {
                    
                    NavigationLink(destination: AccountView(profileIcon: $profileIcon).navigationBarBackButtonHidden(true)) {
                        HStack {
                            Text("Account")
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
                                .strokeBorder(.gray, lineWidth: 1)
                        )
                    }
                    
                    NavigationLink(destination: PostHistoryView().navigationBarBackButtonHidden(true)) {
                        HStack {
                            Text("Post History")
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
//                    NavigationLink(destination: LogInView().navigationBarBackButtonHidden(true)) {
//                        Text("Log Out")
//                            .foregroundStyle(.beige)
//                            .fontWeight(.semibold)
//                    }
                    Button(action: {
                        logOutUser()
                    }) {
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
            .onAppear {
                Task {
                    if let userID = Auth.auth().currentUser?.uid {
                        await viewModel.fetchUserProfile(userID: userID)
                        print(viewModel.userProfile)
                    }
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
    //
    func logOutUser() {
        do {
            try Auth.auth().signOut()
            print("User logged out successfully.")
            
            // Navigate to the Login View (Reset app state if necessary)
            navigateToHome = false
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
            //errorMessage = "Failed to log out. Please try again."
            //showAlert = true
        }
    }

}

#Preview {
    ProfileView()
}
