//
//  SignInView.swift
//  StudyMate
//
//  Created by Maddie Adair on 10/24/24.
//

import SwiftUI

struct SignInView: View {

    //@StateObject private var signInViewModel = SignInEmailViewModel()
    //@State private var username: String = ""

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
                                //signInViewModel.signIn()
                            }) {
                                Text("Login In")
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
                            Alert(title: Text("Invalid Input"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
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
        // Reset previous errors
        emailError = ""
        passwordError = ""
        
        // Check if fields are empty
        if email.isEmpty && password.isEmpty {
            alertMessage = "Please fill out all fields."
            showAlert = true
            return
        }
        if email.isEmpty {
            emailError = "Email is required"
            alertMessage = emailError
            showAlert = true
            return
        } else if !isValidEmail(email) {
            emailError = "Invalid email format"
            alertMessage = emailError
            showAlert = true
            return
        }
        
        if password.isEmpty {
            passwordError = "Password is required"
            alertMessage = passwordError
            showAlert = true
            return
        } else if password.count < 6 {
            passwordError = "Password must be at least 6 characters"
            alertMessage = passwordError
            showAlert = true
            return
        }
        
        if emailError.isEmpty && passwordError.isEmpty {
            // All validations passed
            //signInViewModel.email = email
            //signInViewModel.password = password
            print("Successfully login")
            print("The user entered:\(email) \(password)")
            //signInViewModel.signIn()
            
//            if signInViewModel.errorMessage.isEmpty {
//                print("successfully loged in")
//            }
//            else{
//                
//                alertMessage = signInViewModel.errorMessage
//                showAlert = true
//                
//            }
            
        } else {
            // Show alert if there are errors
            alertMessage = "Please correct the errors."
            showAlert = true
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
    // Helper function to validate email format
    func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: email)
    }
}

#Preview {
    SignInView()
}
