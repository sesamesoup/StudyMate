//
//  EditPersonalInfoView.swift
//  StudyMate
//
//  Created by Maddie Adair on 10/24/24.
//


import SwiftUI

struct EditPersonalInfoView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var firstName: String
    @Binding var lastName: String
    @Binding var username: String
    @Binding var password: String
    @Binding var confirmPassword: String
    @Binding var email: String

    
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var emailError = ""
    @State private var passwordError = ""
    
    var body: some View {
        ZStack {
            Color.lightBeige
                .ignoresSafeArea()
            
            ScrollView {
            VStack(spacing: 40) {
            
                VStack(alignment: .center, spacing: 50) {
                    VStack(alignment: .leading, spacing: 14) {
                        
                        Text("First Name")
                            .fontWeight(.bold)
                        TextField("First Name", text: $firstName)
                            .padding()
                            .cornerRadius(16)
                            .background(.customGrey)
                            .overlay(
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke(.gray, lineWidth: 1)
                            )
                        
                        Text("Last Name")
                            .fontWeight(.bold)
                        TextField("Last Name", text: $lastName)
                            .padding()
                            .cornerRadius(16)
                            .background(.customGrey)
                            .overlay(
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke(.gray, lineWidth: 1)
                            )
                        
                        Text("Email")
                            .fontWeight(.bold)
                        TextField("Email", text: $email)
                            .padding()
                            .cornerRadius(16)
                            .background(.customGrey)
                            .overlay(
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke(.gray, lineWidth: 1)
                            )
                        
                        
                        Text("Username")
                            .fontWeight(.bold)
                        TextField("Username", text: $username)
                            .padding()
                            .cornerRadius(16)
                            .background(.customGrey)
                            .overlay(
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke(.gray, lineWidth: 1)
                            )
                        
                        Text("Password")
                            .fontWeight(.bold)
                        SecureField("Password", text: $password)
                            .padding()
                            .cornerRadius(16)
                            .background(.customGrey)
                            .overlay(
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke(.gray, lineWidth: 1)
                            )
                        
                        Text("Confirm Password")
                            .fontWeight(.bold)
                        SecureField("Confirm Password", text: $confirmPassword)
                            .padding()
                            .cornerRadius(16)
                            .background(.customGrey)
                            .overlay(
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke(.gray, lineWidth: 1)
                            )
                    }
                    
                }
                .frame(maxWidth: .infinity)
                            
                Button(action: {
//                    validateLogin()
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
                    Alert(title: Text("Invalid Input"), message: Text("Please fill out all fields."), dismissButton: .default(Text("OK")))
                }
                
                
                Spacer()
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
            .padding(30)
        }
    }
    
//    func validateLogin() {
//        if email == "" || password == "" {
//            alertMessage = "Please enter all fields."
//            if email == "" {
//                emailError = "* Required"
//            }
//            if password == "" {
//                passwordError = "* Required"
//            }
//            showAlert = true
//        } else {
//            emailError = ""
//            passwordError = ""
//            showAlert = false
//        }
//    }
}

#Preview {
    EditPersonalInfoView(firstName: .constant("Jane"), lastName: .constant("Doe"), username: .constant("janedoe"), password: .constant("password"), confirmPassword: .constant("password"), email: .constant("janedoe@email.com"))
}
