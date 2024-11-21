//
//  SignInView.swift
//  StudyMate
//
//  Created by Maddie Adair on 10/24/24.
//

import SwiftUI

struct SignInView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var showSheet = false
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var emailError = ""
    @State private var passwordError = ""
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.forest
                    .ignoresSafeArea()
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
                    
                    
                    VStack(spacing: 30) {
                        Spacer()

                        VStack(spacing: 30) {
                            Button(action: {
                                showSheet = true
                            }) {
                                Text("Sign In")
                                    .bold()
                                    .padding()
                                    .frame(maxWidth: .infinity, alignment: .center)
                                    .background(.beige)
                                    .foregroundStyle(.forest)
                                    .cornerRadius(16)
                            }
                            
                            NavigationLink(destination: ForgotPasswordView()) {
                                Text("Forgot your password?")
                                    .foregroundStyle(.beige)
                                    .frame(maxWidth: .infinity, alignment: .center)
                            }
                        }
                            
                            Spacer()
                            
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
                .sheet(isPresented: $showSheet, onDismiss: { resetFields() }) {
                    VStack(spacing: 40) {
                        Spacer()
                        VStack( alignment: .leading, spacing: 20) {
                            TextField("Email", text: $email)
                                .padding()
                                .background(.white)
                                .cornerRadius(16)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 16)
                                        .strokeBorder(emailError != "" ? .red : .forest, lineWidth: 1)
                                )
                            
                            SecureField("Password", text: $password)
                                .padding()
                                .background(.white)
                                .cornerRadius(16)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 16)
                                        .strokeBorder(passwordError != "" ? .red : .forest, lineWidth: 1)
                                )
                        }
                        Button(action: {
                            validateLogin()
                        }) {
                            Text("Log In")
                                .bold()
                                .padding()
                                .frame(maxWidth: .infinity, alignment: .center)
                                .background(.forest)
                                .foregroundStyle(.beige)
                                .cornerRadius(16)
                        }
                        .alert(isPresented: $showAlert) {
                            Alert(title: Text("Invalid Input"), message: Text("Please fill out all fields."), dismissButton: .default(Text("OK")))
                        }
                    }
                    .padding()
                    .presentationBackground(.beige)
                    //                .interactiveDismissDisabled()
                    .presentationDetents([.fraction(0.4)])
                    .presentationCornerRadius(30)
                    
                }
            }
        }
    }
    
    func validateLogin() {
        if email == "" || password == "" {
            alertMessage = "Please enter all fields."
            if email == "" {
                emailError = "* Required"
            }
            if password == "" {
                passwordError = "* Required"
            }
            showAlert = true
        } else {
            emailError = ""
            passwordError = ""
            showAlert = false
        }
    }
    
    func resetFields() {
        email = ""
        password = ""
        showSheet = false
        showAlert = false
        alertMessage = ""
        emailError = ""
        passwordError = ""
    }
}

#Preview {
    SignInView()
}
