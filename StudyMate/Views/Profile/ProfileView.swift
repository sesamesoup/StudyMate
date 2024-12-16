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
    
    @Environment(\.verticalSizeClass) var verticalSizeClass: UserInterfaceSizeClass?
    @State private var navigateToHomeView = false
    
    
    var body: some View {
        ZStack {
            Color.lightBeige
                .ignoresSafeArea()
            
            
            // Portrait View
            if verticalSizeClass == .regular {
                
                // Main Stack
                VStack(spacing: 40) {
                    VStack {
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
                    }
                    
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
                            }
                            .frame(maxWidth: .infinity, maxHeight: 30, alignment: .leading)
                            .padding()
                            .background(.customGrey)
                            .cornerRadius(16)
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
                            }
                            .frame(maxWidth: .infinity, maxHeight: 30, alignment: .leading)
                            .padding()
                            .background(.customGrey)
                            .cornerRadius(16)
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
                        
                        // Navigate to WelcomeView once logged out
                        NavigationLink(
                            destination: WelcomeView().navigationBarBackButtonHidden(true),
                            isActive: $navigateToHomeView
                        ) {
                            EmptyView()
                        }.hidden()
                        
                    }
                    .frame(maxWidth: .infinity)
                    
                    
                    Spacer()
                }
                .padding(30)
                
                // Get user data
                .onAppear {
                    Task {
                        if let userID = Auth.auth().currentUser?.uid {
                            await viewModel.fetchUserProfile(userID: userID)
                            print(viewModel.userProfile as Any)
                        }
                    }
                }
            }
            
            // Landscape view
            else {
                HStack(spacing: 30) {
                    
                    // Main Stack
                    VStack {
                        RoundedRectangle(cornerRadius: 30,
                                         style: .continuous)
                        .aspectRatio(1.4, contentMode: .fill)
                        // profile picture
                        .overlay(
                            Image(viewModel.userProfile?.profilePicture ?? "person.circle.fill")
                                .resizable()
                                .scaledToFill()
                                .offset(x: -20.0, y: 10.0)
                        )
                        .frame(width: 100, height: 100, alignment: .leading)
                        .clipShape(RoundedRectangle(cornerRadius: 30,
                                                    style: .continuous))
                        
                        // ------ First, Last, user, subject and year
                        VStack(alignment: .center, spacing: 50) {
                            VStack(spacing: 14) {
                                VStack(spacing: 6) {
                                    Text("\(viewModel.userProfile?.firstName ?? "FirstName") \(viewModel.userProfile?.lastName ?? "LastName")")
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
                    }
                    
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
                            }
                            .frame(maxWidth: .infinity, maxHeight: 30, alignment: .leading)
                            .padding()
                            .background(.customGrey)
                            .cornerRadius(16)
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
                                
                            }
                            .frame(maxWidth: .infinity, maxHeight: 30, alignment: .leading)
                            .padding()
                            .background(.customGrey)
                            .cornerRadius(16)
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
                        
                        NavigationLink(
                            destination: WelcomeView().navigationBarBackButtonHidden(true),
                            isActive: $navigateToHomeView
                        ) {
                            EmptyView()
                        }.hidden()
                        //------------------------------------------------
                    }
                    .frame(maxWidth: .infinity)
                    
                    
                }
                .padding(30)
                
                // Fetch User Data
                .onAppear {
                    Task {
                        if let userID = Auth.auth().currentUser?.uid {
                            await viewModel.fetchUserProfile(userID: userID)
                            print(viewModel.userProfile as Any)
                        }
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
            navigateToHomeView = true
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
