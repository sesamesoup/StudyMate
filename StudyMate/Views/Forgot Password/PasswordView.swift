//
//  PasswordView.swift
//  StudyMate
//
//  Created by Sarang Mistry on 11/23/24.
//
//

import SwiftUI
import Firebase
import FirebaseAuth

struct PasswordView: View {
    //
    @Environment(\.dismiss) var dismiss
    //
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @State private var showAlert: Bool = false
    @State private var alertMessage: String = ""
    @State private var isSuccessAlert: Bool = false
    
    var body: some View {
        ZStack {
            Color.lightBeige
                .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 40) {
                    VStack(alignment: .leading, spacing: 22) {
                        Text("Password")
                            .fontWeight(.bold)
                        
                        SecureField("Enter Password", text: $password)
                            .padding()
                            .background(.customGrey)
                            .cornerRadius(16)
                            .overlay(
                                RoundedRectangle(cornerRadius: 16)
                                    .strokeBorder(.gray, lineWidth: 1)
                            )
                        
                        Text("Confirm Password")
                            .fontWeight(.bold)
                        
                        SecureField("Re-enter Password", text: $confirmPassword)
                            .padding()
                            .background(.customGrey)
                            .cornerRadius(16)
                            .overlay(
                                RoundedRectangle(cornerRadius: 16)
                                    .strokeBorder(.gray, lineWidth: 1)
                            )
                    }
                    .frame(maxWidth: .infinity)
                    
                    Button(action: {
                        validatePasswords()
                    }) {
                        Text("Confirm")
                            .bold()
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .center)
                            .background(Color.forest)
                            .foregroundStyle(.beige)
                            .cornerRadius(16)
                    }
                    .alert(isPresented: $showAlert) {
                        Alert(
                            title: Text(isSuccessAlert ? "Success" : "Invalid Input"),
                            message: Text(alertMessage),
                            dismissButton: .default(Text("OK"))
                        )
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(30)
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
                        Text("Cancel")
                            .foregroundStyle(.forest)
                    }
                }
            }
        }
    }
    
    // Validation for passwords
    private func validatePasswords() {
        if password.isEmpty || confirmPassword.isEmpty {
            alertMessage = "Please fill out both fields."
            isSuccessAlert = false
            showAlert = true
        } else if password.count < 6 {
            alertMessage = "Password must be at least 6 characters long."
            isSuccessAlert = false
            showAlert = true
        } else if password != confirmPassword {
            alertMessage = "Passwords do not match."
            isSuccessAlert = false
            showAlert = true
        } else {
            updatePassword()
        }
    }
    
    // Function to update password in Firebase
    private func updatePassword() {
        guard let user = Auth.auth().currentUser else {
            alertMessage = "No authenticated user found."
            isSuccessAlert = false
            showAlert = true
            return
        }
        
        user.updatePassword(to: password) { error in
            if let error = error {
                alertMessage = "Error updating password: \(error.localizedDescription)"
                isSuccessAlert = false
            } else {
                alertMessage = "Password updated successfully!"
                isSuccessAlert = true
            }
            showAlert = true
        }
    }
}
