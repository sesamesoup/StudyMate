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
    // Getting the view model
    @StateObject private var viewModel = ProfileViewModel()
    @AppStorage("navigateToHome") var navigateToHome: Bool = false
    @State private var profileIcon = "girl1"



    var body: some View {
        ZStack {
            Color.lightBeige
                .ignoresSafeArea()
            
            // Main Stack
            VStack(spacing: 40) {
                RoundedRectangle(cornerRadius: 50,
                                 style: .continuous)
                .aspectRatio(1.4, contentMode: .fill)
                // profile picture
                .overlay(
                    Image(viewModel.userProfile?.profilePicture ?? "person.circle.fill")
                        .resizable()
                        .scaledToFill()
                        .offset(x: -30.0, y: 20.0)
                )
                .frame(width: 150, height: 150, alignment: .leading)
                .clipShape(RoundedRectangle(cornerRadius: 50,
                                            style: .continuous))
                
                // ------ First, Last, user, subject and year
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
                    
                    
                }
                .frame(maxWidth: .infinity)
                //----------------------------------------------------
                //                Spacer()
                
                VStack(spacing: 20) {
                    // --------------- Account View --------------------
                    NavigationLink(destination: AccountView(viewModel:viewModel).navigationBarBackButtonHidden(true)) {
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
                    // ---------------------- Post History -----------------------------------------
                    NavigationLink(destination: PostHistoryView(viewModel:viewModel).navigationBarBackButtonHidden(true)) {
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

                    //------------------ Logout -------------------
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
                    //------------------------------------------------
                }
                .frame(maxWidth: .infinity)
                
                
                Spacer()
            }
            .padding(30)
            .onAppear {
                Task {
                    if let userID = Auth.auth().currentUser?.uid {
                        await viewModel.fetchUserProfile(userID: userID)
                        print(viewModel.userProfile as Any)
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
