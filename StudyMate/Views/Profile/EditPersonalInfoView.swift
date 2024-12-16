//
//  EditPersonalInfoView.swift
//  StudyMate
//
//  Created by Maddie Adair on 10/24/24.
//


import SwiftUI
import FirebaseAuth
import Firebase

struct EditPersonalInfoView: View {
    @Environment(\.dismiss) var dismiss
    @State var firstName: String
    @State var lastName: String
    @State var email: String
    
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var emailError = ""
    @State private var isSuccessAlert = false
    
    var body: some View {
        ZStack {
            Color.lightBeige
                .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 40) {
                    VStack(alignment: .center, spacing: 50) {
                        VStack(alignment: .leading, spacing: 22) {
                            // First Name
                            Text("First Name")
                                .fontWeight(.bold)
                            TextField("First Name", text: $firstName)
                                .autocapitalization(.none)
                                .padding()
                                .background(.customGrey)
                                .cornerRadius(16)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 16)
                                        .strokeBorder(.gray, lineWidth: 1)
                                )
                            
                            // Last Name
                            Text("Last Name")
                                .fontWeight(.bold)
                            TextField("Last Name", text: $lastName)
                                .autocapitalization(.none)
                                .padding()
                                .background(.customGrey)
                                .cornerRadius(16)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 16)
                                        .strokeBorder(.gray, lineWidth: 1)
                                )
                            
                            // Email
                            Text("Email")
                                .fontWeight(.bold)
                            TextField("Email", text: $email)
                                .autocapitalization(.none)
                                .keyboardType(.emailAddress)
                                .autocapitalization(.none)
                                .padding()
                                .background(.customGrey)
                                .cornerRadius(16)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 16)
                                        .strokeBorder(.gray, lineWidth: 1)
                                )
                        }
                    }
                    .frame(maxWidth: .infinity)
                    
                    // Confirm Button
                    Button(action: {
                        if validateInputs() {
                            updateUserProfile()
                        }
                    }) {
                        Text("Confirm")
                            .bold()
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .center)
                            .background(.forest)
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
                .padding(30)
            }
        }
    }
    
    // Validation Function
    private func validateInputs() -> Bool {
        if firstName.isEmpty || lastName.isEmpty || email.isEmpty {
            alertMessage = "All fields are required."
            isSuccessAlert = false
            showAlert = true
            return false
        }
        
        if !isValidEmail(email) {
            alertMessage = "Please enter a valid email address."
            isSuccessAlert = false
            showAlert = true
            return false
        }
        
        return true
    }
    
    // Email Validation Function
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: email)
    }
    
    // Update User Profile Function
    private func updateUserProfile() {
        guard let userID = Auth.auth().currentUser?.uid else { return }
        
        if email != Auth.auth().currentUser?.email {
            Auth.auth().currentUser?.updateEmail(to: email) { error in
                if let error = error {
                    alertMessage = "Error updating email: \(error.localizedDescription)"
                    isSuccessAlert = false
                    showAlert = true
                    return
                }
            }
        }
        
        let updatedData: [String: Any] = [
            "firstName": firstName,
            "lastName": lastName,
            "email": email
        ]
        
        Firestore.firestore().collection("users").document(userID).updateData(updatedData) { error in
            if let error = error {
                alertMessage = "Error updating profile: \(error.localizedDescription)"
                isSuccessAlert = false
                showAlert = true
                return
            }
            
            alertMessage = "Your profile has been updated successfully."
            isSuccessAlert = true
            showAlert = true
        }
    }
}
