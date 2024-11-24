//
//  SignInView.swift
//  StudyMate
//
//  Created by Maddie Adair on 10/14/24.
//

import SwiftUI

struct DrawingPaths: View {
    var body: some View {
        Path { path in
            //Top left
            path.move(to: CGPoint(x: 0, y: 0))
            //Left vertical bound
            path.addLine(to: CGPoint(x: 0, y: 350))
            //Curve
            path.addCurve(to: CGPoint(x: 440, y: 300), control1: CGPoint(x: 205, y: 450), control2: CGPoint(x: 250, y: 100))
            //Right vertical bound
            path.addLine(to: CGPoint(x: 450, y: 0))
        }
        .fill(.customBlue)
        .edgesIgnoringSafeArea(.top)
        
    }
}

struct SignInView: View {
    @StateObject private var signInViewModel = SignInEmailViewModel()
    @State private var username: String = ""
    @State private var password: String = ""
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.customPink.edgesIgnoringSafeArea(.all)
                DrawingPaths()
                VStack {
                    Text("Welcome Back!")
                        .font(.custom("AveriaGruesaLibre-Regular", size: 60))
                        .foregroundStyle(.customPink)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top, 30)
                    
                    Spacer()
                        .frame(height: 220)
                    
                    
                    VStack {
                        VStack(spacing: 25) {
                            VStack(spacing: 15) {
                                TextField("Email or Username", text: $username)
                                    .padding()
                                    .frame(maxWidth: .infinity, alignment: .center)
                                    .background(.white)
                                    .cornerRadius(16)
                                TextField("Password", text: $password)
                                    .padding()
                                    .frame(maxWidth: .infinity, alignment: .center)
                                    .background(.white)
                                    .cornerRadius(16)
                            }
                            
                            NavigationLink(destination: ForgotPasswordView()) {
                                Text("Forgot Password?")
                                    .foregroundStyle(.customBlue)
                                    .bold()
                                    .frame(maxWidth: .infinity, alignment: .trailing)
                            }
                            
                        }
                        
                        Spacer()
                            .frame(height: 60)
                        
                        
                        VStack(spacing: 40) {
                            
//                            NavigationLink(destination: MainView().navigationBarBackButtonHidden(true)) {
//                                Text("Sign In")
//                                    .bold()
//                                    .padding()
//                                    .frame(maxWidth: .infinity, alignment: .center)
//                                    .background(.customBlue)
//                                    .foregroundStyle(.customPink)
//                                    .clipShape(.capsule)
//                            }
                            
                            
                            Button(action: {
                                print("Sign In")
                                signInViewModel.signIn()
                                
                            }) {
                                Text("Sign In")
                                    .bold()
                                    .padding()
                                    .frame(maxWidth: .infinity, alignment: .center)
                                    .background(.customBlue)
                                    .foregroundStyle(.customPink)
                                    .clipShape(.capsule)
                            }
                            
                            HStack {
                                Text("Don't have an account?")
                                
                                NavigationLink(destination: CreateAccountView()) {
                                    Text("Sign Up")
                                        .foregroundStyle(.customBlue)
                                        .bold()
                                }
                                
                            }
                        }
                    }
                    Spacer()
                }
                .frame(maxWidth: 325)
            }
        }
    }
}

#Preview {
    SignInView()
}
