//
//  LogInView.swift
//  StudyMate
//
//  Created by Maddie Adair on 10/24/24.
//

import SwiftUI
import FirebaseAuth

struct LogInView: View {

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
    //MARK: - View Start
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
                    
                    // Stack for Login SignUp Forget Password Buttons
                    VStack(spacing: 30) {
                        Spacer()

                        // For Login Buttion
                        VStack(spacing: 30) {
                            Button(action: {
                                showSheet = true
                                
                            }) {
                                Text("Login")
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
                // LOGIN Sheet
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
    //------------------------------------End OF VIEW -----------------------------------------------
    
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
                    showSheet = false
                    navigateToHome = true
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
