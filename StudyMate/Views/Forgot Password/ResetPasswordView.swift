//
//  ResetPasswordView.swift
//  StudyMate
//
//  Created by Maddie Adair on 10/14/24.
//

import SwiftUI

struct ResetPasswordView: View {
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @Environment(\.dismiss) var dismiss
    @State private var showAlert = false
    
    @State private var passwordError: String = ""
    @State private var confirmPasswordError: String = ""
    @State private var alertMessage: String = ""
    
    var body: some View {
        ZStack {
            Color.lightBlue
                .ignoresSafeArea()
            
            
            VStack(spacing: 40) {
                Spacer()
                Image("collab3")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 175)
                
                Spacer()
                
                VStack(alignment: .leading, spacing: 50) {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Reset Password")
                            .font(.custom("InstrumentSerif-Regular", size: 40))
                        
                        Text("Enter a new password below to change your password.")
                            .fixedSize(horizontal: false, vertical: true)
                    }
                    
                    VStack(spacing: 30) {
                        VStack(spacing: 20) {
                            SecureField("Password", text: $password)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(.white)
                                .cornerRadius(16)
                                .overlay(passwordError != "" ?
                                         RoundedRectangle(cornerRadius: 16)
                                    .stroke(.red, lineWidth: 1) : nil
                                )
                            
                            if passwordError != "" {
                                Text(passwordError)
                                    .foregroundStyle(.red)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                            
                            SecureField("Confirm Password", text: $confirmPassword)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(.white)
                                .cornerRadius(16)
                                .overlay(passwordError != "" ?
                                         RoundedRectangle(cornerRadius: 16)
                                    .stroke(.red, lineWidth: 1) : nil
                                )
                            
                            if confirmPasswordError != "" {
                                Text(confirmPasswordError)
                                    .foregroundStyle(.red)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                        }
                        NavigationLink(destination: SignInView().navigationBarBackButtonHidden(true)) {
                            Text("Reset")
                                .bold()
                                .padding()
                                .frame(maxWidth: .infinity, alignment: .center)
                                .background(.forest)
                                .foregroundStyle(.beige)
                                .cornerRadius(16)
                        }
                        
//                        Button(action: {
//                            validate()
//                        }) {
//                            Text("Reset")
//                                .bold()
//                                .padding()
//                                .frame(maxWidth: .infinity, alignment: .center)
//                                .background(.forest)
//                                .foregroundStyle(.beige)
//                                .cornerRadius(16)
//                        }
//                        .alert(isPresented: $showAlert) {
//                            Alert(title: Text("Invalid Input"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
//                        }
                        
                    }
                    
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
    
    func validate() {
        passwordError = ""
        confirmPasswordError = ""
        
        if password == "" || confirmPassword == "" {
            alertMessage = "Please enter all fields."
            if password == "" {
                passwordError = "* Required"
            }
            if confirmPassword == "" {
                confirmPasswordError = "* Required"
            }
            showAlert = true
        } else if password != confirmPassword {
            alertMessage = "Please make sure your passwords match."
            passwordError = "Does not match"
            confirmPasswordError = "Does not match"
        }
        else {
            alertMessage = ""
            passwordError = ""
            confirmPasswordError = ""
            showAlert = false
        }
    }
}

#Preview {
    ResetPasswordView()
}
