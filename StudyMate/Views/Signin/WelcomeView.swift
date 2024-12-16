//
//  LogInView.swift
//  StudyMate
//
//  Created by Maddie Adair on 10/24/24.
//

import SwiftUI
import FirebaseAuth

struct WelcomeView: View {
    
    //@State private var navigateToHome = false
    @AppStorage("navigateToHome") var navigateToHome: Bool = false
    // Required fields
    @State private var email: String = ""
    @State private var password: String = ""
    // Pop Up errors
    @State private var showSheet = false
    @State private var showAlert = false
    @State private var alertMessage = ""
    // Error validation
    @State private var emailError = ""
    @State private var passwordError = ""
    
    // Landscape mode
    @Environment(\.verticalSizeClass) var verticalSizeClass: UserInterfaceSizeClass?
    
    @State private var navigateToHomeView = false
    
    
    //MARK: - View Start
    var body: some View {
        NavigationStack {
            ZStack {
                Color.forest
                    .ignoresSafeArea()
                
                if verticalSizeClass == .regular {
                    VStack(alignment: .center) {
                        Spacer()
                        
                        VStack(spacing: 40) {
                            Spacer()
                            
                            Image("collab")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 200)
                            
                            VStack(spacing: 10) {
                                Text("Welcome Back!")
                                    .font(.custom("InstrumentSerif-Regular", size: 60))
                                    .foregroundStyle(.beige)
                                
                                Text("Nice to see you again.")
                                    .foregroundStyle(.beige)
                            }
                        }
                        
                        Spacer()
                        
                        // Stack for Login SignUp Forget Password Buttons
                        VStack(spacing: 30) {
                            Spacer()
                            
                            // For Login Buttion
                            VStack(spacing: 30) {
                                NavigationLink(destination: LogInView()) {
                                    Text("Log In")
                                        .bold()
                                        .padding()
                                        .frame(maxWidth: .infinity, alignment: .center)
                                        .background(.beige)
                                        .foregroundStyle(.forest)
                                        .cornerRadius(16)
                                }
                                
                                // Forgetp Password View
                                NavigationLink(destination: ForgotPasswordView()) {
                                    Text("Forgot your password?")
                                        .foregroundStyle(.beige)
                                        .frame(maxWidth: .infinity, alignment: .center)
                                }
                            }
                            
                            Spacer()
                            // Sign UP if dont have an account
                            HStack {
                                Text("Don't have an account?")
                                    .foregroundStyle(.beige)
                                NavigationLink(destination: SignUpView()) {
                                    Text("Sign Up")
                                        .foregroundStyle(.beige)
                                        .bold()
                                }
                            }
                            
                        }
                        
                        Spacer()
                        
                    }
                    .padding(30)
                }
                
                // Landscape View
                else {
                    HStack(spacing: 40) {
                        VStack(spacing: 40) {
                            Spacer()
                            
                            Image("collab")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 125)
                            
                            VStack(spacing: 10) {
                                Text("Welcome Back!")
                                    .font(.custom("InstrumentSerif-Regular", size: 50))
                                    .foregroundStyle(.beige)
                                
                                Text("Nice to see you again.")
                                    .foregroundStyle(.beige)
                            }
                        }
                        
                        // Stack for Login SignUp Forget Password Buttons
                        VStack {
                            Spacer()
                            
                            // For Login Buttion
                            VStack(spacing: 30) {
                                NavigationLink(destination: LogInView()) {
                                    Text("Log In")
                                        .bold()
                                        .padding()
                                        .frame(maxWidth: 300, alignment: .center)
                                        .background(.beige)
                                        .foregroundStyle(.forest)
                                        .cornerRadius(16)
                                }
                                
                                // Forgetp Password View
                                NavigationLink(destination: ForgotPasswordView()) {
                                    Text("Forgot your password?")
                                        .foregroundStyle(.beige)
                                        .frame(maxWidth: .infinity, alignment: .center)
                                }
                            }
                            
                            Spacer()
                            // Sign UP if dont have an account
                            HStack {
                                Text("Don't have an account?")
                                    .foregroundStyle(.beige)
                                NavigationLink(destination: SignUpView()) {
                                    Text("Sign Up")
                                        .foregroundStyle(.beige)
                                        .bold()
                                }
                            }
                            
                            Spacer()
                            
                            
                        }
                        
                        
                    }
                    .padding(30)
                    
                }
            }
        }
    }
    //------------------------------------End OF VIEW -----------------------------------------------
    
    
    
    
}

#Preview {
    LogInView()
}
