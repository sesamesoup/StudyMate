//
//  ForgotPasswordView.swift
//  StudyMate
//
//  Created by Maddie Adair on 10/14/24.
//

import SwiftUI
import FirebaseAuth
struct ForgotPasswordView: View {
//    @State private var email: String = ""
    @Environment(\.dismiss) var dismiss
//    @State private var showAlert = false
    @State private var email = ""
    @State private var alertMessage = ""
    @State private var showAlert = false

    
    @Environment(\.verticalSizeClass) var verticalSizeClass: UserInterfaceSizeClass?

    var body: some View {
        ZStack {
            Color.lightBlue
                .ignoresSafeArea()
            
            if verticalSizeClass == .regular {
                
                VStack(spacing: 40) {
                    Spacer()
                    Image("collab3")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 175)
                    
                    Spacer()
                    
                    VStack(alignment: .leading, spacing: 50) {
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Forgot your password?")
                                .font(.custom("InstrumentSerif-Regular", size: 40))
                            
                            Text("No worries! Just enter the email address associated with your account and we’ll send you a link to reset your password.")
                                .fixedSize(horizontal: false, vertical: true)
                        }
                        
                        VStack(spacing: 30) {
                            TextField("Email", text: $email)
                                .autocapitalization(.none)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(.white)
                                .cornerRadius(16)
                            
                            Button(action: {
                                if email.isEmpty {
                                    alertMessage = "Please enter your email."
                                    showAlert = true
                                }
                                else if !isValidEmail(email) {
                                    alertMessage = "Please enter a valid email address."
                                    showAlert = true
                                }
                                else {
                                    forgotPassword(email: email) { result in
                                        switch result {
                                        case .success:
                                            alertMessage = "Password reset email sent successfully."
                                        case .failure(let error):
                                            alertMessage = "Error: \(error.localizedDescription)"
                                        }
                                        showAlert = true
                                    }
                                }
                            }) {
                                Text("Submit")
                                    .bold()
                                    .padding()
                                    .frame(maxWidth: .infinity, alignment: .center)
                                    .background(.forest)
                                    .foregroundStyle(.beige)
                                    .cornerRadius(16)
                            }
                            
                        }
                        
                        Spacer()
                    }
                    
                }
                .alert(isPresented: $showAlert) {
                    Alert(title: Text("Forgot Password"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
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
            
            else {
                ScrollView {
                    
                    VStack(alignment: .leading, spacing: 40) {
                        Image("collab3")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 150, alignment: .leading)
                        
                        VStack(alignment: .leading, spacing: 50) {
                            VStack(alignment: .leading, spacing: 20) {
                                Text("Forgot your password?")
                                    .font(.custom("InstrumentSerif-Regular", size: 40))
                                
                                Text("No worries! Just enter the email address associated with your account and we’ll send you a link to reset your password.")
                                    .fixedSize(horizontal: false, vertical: true)
                            }
                            
                            VStack(spacing: 30) {
                                TextField("Email", text: $email)
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(.white)
                                    .cornerRadius(16)
                                
                                Button(action: {
                                    if email.isEmpty {
                                        alertMessage = "Please enter your email."
                                        showAlert = true
                                    }
                                    else if !isValidEmail(email) {
                                        alertMessage = "Please enter a valid email address."
                                        showAlert = true
                                    }
                                    else {
                                        forgotPassword(email: email) { result in
                                            switch result {
                                            case .success:
                                                alertMessage = "Password reset email sent successfully."
                                            case .failure(let error):
                                                alertMessage = "Error: \(error.localizedDescription)"
                                            }
                                            showAlert = true
                                        }
                                    }
                                }) {
                                    Text("Submit")
                                        .bold()
                                        .padding()
                                        .frame(maxWidth: .infinity, alignment: .center)
                                        .background(.forest)
                                        .foregroundStyle(.beige)
                                        .cornerRadius(16)
                                }
                                
                            }
                            
                            Spacer()
                        }
                    }
                    
                }
                .alert(isPresented: $showAlert) {
                    Alert(title: Text("Forgot Password"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
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
    }
    //
    func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }

    // Forget password
    func forgotPassword(email: String, completion: @escaping (Result<Void, Error>) -> Void) {
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if let error = error {
                completion(.failure(error)) // Pass the error to the completion handler
            } else {
                completion(.success(())) // Indicate success
            }
        }
    }

}

#Preview {
    ForgotPasswordView()
}
