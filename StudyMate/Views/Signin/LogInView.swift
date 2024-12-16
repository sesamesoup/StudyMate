//
//  LogInView.swift
//  StudyMate
//
//  Created by Maddie Adair on 10/24/24.
//
//

import SwiftUI
import FirebaseAuth

struct LogInView: View {
    //    @State private var email: String = ""
    @Environment(\.dismiss) var dismiss
    //    @State private var showAlert = false
    @State private var email: String = ""
    @State private var password: String = ""
    // Pop Up errors
    @State private var showSheet = false
    @State private var showAlert = false
    @State private var alertMessage = ""
    // Error validation
    @State private var emailError = ""
    @State private var passwordError = ""
    
    // Var to programmatically navigate to HomeView
    @State private var navigateToHomeView = false
    
    // Landscape mode
    @Environment(\.verticalSizeClass) var verticalSizeClass: UserInterfaceSizeClass?
    
    var body: some View {
        ZStack {
            Color.lightBlue
                .ignoresSafeArea()
            
            // Portrait mode start
            if verticalSizeClass == .regular {
                VStack(spacing: 30) {
                    Spacer()
                    Image("login-art")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 200)
                    
                    Spacer()
                    
                    VStack(alignment: .leading, spacing: 50) {
                        Text("Log In")
                            .font(.custom("InstrumentSerif-Regular", size: 40))
                        
                        VStack(spacing: 30) {
                            TextField("Email", text: $email)
                                .autocapitalization(.none)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(.white)
                                .cornerRadius(16)
                            
                            SecureField("Password", text: $password)
                                .autocapitalization(.none)
                                .frame(maxWidth: .infinity)
                                .autocapitalization(.none)
                                .padding()
                                .background(.white)
                                .cornerRadius(16)
                            
                        }
                        
                        Spacer()
                        
                        // Validate user
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
                        
                        // Navigate to MainView once validated
                        NavigationLink(
                            destination: MainView().navigationBarBackButtonHidden(true),
                            isActive: $navigateToHomeView
                        ) {
                            EmptyView()
                        }.hidden()
                    }
                    
                }
                
                // Custom back bar
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
            
            // Landscape mode
            else {
                ScrollView {
                    VStack(alignment: .leading, spacing: 30) {
                        Text("Log In")
                            .font(.custom("InstrumentSerif-Regular", size: 40))
                        
                        VStack(spacing: 30) {
                            TextField("Email", text: $email)
                                .autocapitalization(.none)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(.white)
                                .cornerRadius(16)
                            
                            SecureField("Password", text: $password)
                                .autocapitalization(.none)
                                .frame(maxWidth: .infinity)
                                .autocapitalization(.none)
                                .padding()
                                .background(.white)
                                .cornerRadius(16)
                            
                        }
                        
                        Spacer()
                        
                        // Validate login
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
                        
                        // Navigate to Main once validated
                        NavigationLink(
                            destination: MainView().navigationBarBackButtonHidden(true),
                            isActive: $navigateToHomeView
                        ) {
                            EmptyView()
                        }.hidden()
                    }
                    
                }
                
                // Custom back bar
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
    
    
    //MARK: - Function to validate Login
    func validateLogin() {
        // Check if fields are empty
        email = email.trimmingCharacters(in: .whitespacesAndNewlines)
        password = password.trimmingCharacters(in: .whitespacesAndNewlines)
        // Empty fields
        if email.isEmpty || password.isEmpty {
            alertMessage = "Please fill out all fields."
            showAlert = true
            return
        }
        // email empty
        else if email.isEmpty {
            alertMessage = "Email is required"
            showAlert = true
            return
        }
        // Validate Email
        else if !isValidEmail(email) {
            alertMessage = "Invalid email format"
            showAlert = true
            return
        }
        // Password Empty
        else if password.isEmpty {
            alertMessage = "Password is required"
            showAlert = true
            return
        }
        // Validate Password
        else if let passwordError = validatePassword(password) {
            alertMessage = passwordError
            showAlert = true
            return
        }
        // All validation satisfied
        else {
            print("email\(email)")
            print("password\(password)")
            // Navigate to HomeScreen
            Task {
                let success = await loginUser()
                if success {
                    // Navigate to the home screen
                    print("Login successful!")
                    //                    showSheet = false
                    navigateToHomeView = true
                } else {
                    print("Login failed.")
                }
            }
        }
    }
    // Reset fields functions
    func resetFields() {
        email = ""
        password = ""
        showSheet = false
        showAlert = false
        alertMessage = ""
        emailError = ""
        passwordError = ""
    }
    // MARK: - Function To Login User
    func loginUser() async -> Bool {
        do {
            let _ = try await Auth.auth().signIn(withEmail: self.email, password: self.password)
            print("User signed in successfully!")
            return true
        } catch {
            print(error.localizedDescription)
            self.alertMessage = "Error signing in. Please try again."
            self.showAlert = true
            return false
        }
    }
    
    
    // MARK: - Helper function to validate Entries
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: email)
    }
    // Validationf for password
    func validatePassword(_ password: String) -> String? {
        // Check password length (minimum 8 characters)
        if password.count < 8 {
            return "Password must be at least 8 characters long."
        }
        
        // Check for at least one uppercase letter
        let uppercaseLetterRegex = ".*[A-Z]+.*"
        if !NSPredicate(format: "SELF MATCHES %@", uppercaseLetterRegex).evaluate(with: password) {
            return "Password must contain at least one uppercase letter."
        }
        
        // Check for at least one lowercase letter
        let lowercaseLetterRegex = ".*[a-z]+.*"
        if !NSPredicate(format: "SELF MATCHES %@", lowercaseLetterRegex).evaluate(with: password) {
            return "Password must contain at least one lowercase letter."
        }
        
        // Check for at least one number
        let numberRegex = ".*[0-9]+.*"
        if !NSPredicate(format: "SELF MATCHES %@", numberRegex).evaluate(with: password) {
            return "Password must contain at least one number."
        }
        
        // Check for at least one special character
        let specialCharacterRegex = ".*[!@#$%^&*(),.?\":{}|<>]+.*"
        if !NSPredicate(format: "SELF MATCHES %@", specialCharacterRegex).evaluate(with: password) {
            return "Password must contain at least one special character."
        }
        
        // Password is valid
        return nil
    }
    
}

#Preview {
    LogInView()
}
