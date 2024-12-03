//
//  SignUpView.swift
//  StudyMate
//
//  Created by Maddie Adair on 10/24/24.
//

import SwiftUI
// Data Structure

// Screen 1
struct Personal {
    var firstName: String = ""
    var lastName: String = ""
}

// Screen 2
struct Credentials {
    var username: String = ""
    var email: String = ""
    var password: String = ""
    var confirmPassword: String = ""
}

// Screen 3
struct ProfileIcon {
    var profilePicString: String = ""
}

// Screen 4
struct Academic {
    var major: String = majors[0]
    var year: String = "Sophomore"
}

// togther
struct NewUserData {
    var personal: Personal = Personal()
    var credentials: Credentials = Credentials()
    var academic: Academic = Academic()
    var pfp: ProfileIcon = ProfileIcon()
}

enum Steps {
    case personal
    case login
    case academic
    case pfp
    
    var title: String {
        switch self {
        case .personal: return "Personal"
        case .login: return "Login"
        case .academic: return "Academic"
        case .pfp: return "Profile Picture"
        }
    }
    
    var next: Steps? {
        switch self {
        case .personal: return .login
        case .login: return .pfp
        case .pfp: return .academic
        case .academic: return nil
        }
    }
    
    var previous: Steps? {
        switch self {
        case .personal: return nil
        case .login: return .personal
        case .pfp: return .login
        case .academic: return .pfp
        }
    }
}
// View models -------------------------------------------
struct NameView: View {
    @Binding var personal: Personal
    @Binding var showAlert: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 50) {
            VStack(alignment: .leading, spacing: 10) {
                Text("Create an account")
                    .font(.custom("InstrumentSerif-Regular", size: 40))
                
                Text("To get started, we'll need your name first.")
            }
            
            VStack(spacing: 20) {
                Text("First Name")
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                TextField("First Name", text: $personal.firstName)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(.white)
                    .cornerRadius(16)
                
                Text("Last Name")
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                TextField("Last Name", text: $personal.lastName)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(.white)
                    .cornerRadius(16)
            }
        }
    }
}

struct LoginView: View {
    @Binding var credentials: Credentials
    @Binding var showAlert: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 50) {
            VStack(alignment: .leading, spacing: 10) {
                Text("Username and Password")
                    .font(.custom("InstrumentSerif-Regular", size: 40))
                
                Text("Please enter a username and password for your account.")
                    .fixedSize(horizontal: false, vertical: true)
            }
            
            
            VStack(spacing: 20) {
                Text("Username")
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                TextField("Username", text: $credentials.username)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(.white)
                    .cornerRadius(16)
                Text("Email")
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                TextField("Email", text: $credentials.email)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(.white)
                    .cornerRadius(16)
                
                Text("Password")
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                SecureField("Password", text: $credentials.password)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(.white)
                    .cornerRadius(16)
                
                Text("Confirm Password")
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                SecureField("Confirm Password", text: $credentials.confirmPassword)
                    .textContentType(.newPassword)
                    .padding()
                    .background(.white)
                    .cornerRadius(16)
            }
        }
    }
}

struct AcademicView: View {
    @Binding var academic: Academic
    @Binding var showAlert: Bool
    
    
    var body: some View {
        VStack(alignment: .leading, spacing: 50) {
            VStack(alignment: .leading, spacing: 10) {
                Text("Year and Major")
                    .font(.custom("InstrumentSerif-Regular", size: 40))
                
                Text("Last step! To better cater suggestions for you, please select your current year and major.")
                    .fixedSize(horizontal: false, vertical: true)
            }
            
            
            VStack(alignment: .leading, spacing: 20) {
                Text("Year")
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Picker("-- Select a year --", selection: $academic.year) {
                    ForEach(years, id: \.self) {
                        Text($0)
                    }
                }
                .padding()
                .accentColor(.forest)
                .pickerStyle(.menu)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(.white)
                .cornerRadius(16)
                
                
                Text("Major")
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Picker("-- Select a major --", selection: $academic.major) {
                    ForEach(majors, id: \.self) {
                        Text($0)
                    }
                }
                .padding()
                .accentColor(.forest)
                .pickerStyle(.menu)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(.white)
                .cornerRadius(16)
                
            }
        }
    }
}

struct PictureView: View {
    @State private var imgArr: [[String]] = [["girl1", "girl2", "girl3"], ["girl4", "girl5", "girl6"], ["guy1", "guy2", "guy3"], ["guy4", "guy5", "guy6"]]
    
    @Binding var profileIcon: ProfileIcon
    @Binding var showAlert: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 50) {
            VStack(alignment: .leading, spacing: 10) {
                Text("Profile Picture")
                    .font(.custom("InstrumentSerif-Regular", size: 40))
                
                Text("Please choose a profile picture.")
                    .fixedSize(horizontal: false, vertical: true)
            }
            
            ScrollView {
                VStack(spacing: 20) {
                    ForEach(imgArr, id: \.self) { arr in
                        HStack(spacing: 20) {
                            ForEach(arr, id: \.self) { img in
                                Button {
                                    profileIcon.profilePicString = img
                                } label: {
                                    RoundedRectangle(cornerRadius: 32,
                                                     style: .continuous)
                                    .aspectRatio(1.4, contentMode: .fill)
                                    .overlay(
                                        Image(img)
                                            .resizable()
                                            .scaledToFill()
                                            .offset(x: -20.0, y: 15.0)

                                    )
                                    .frame(width: 100, height: 100, alignment: .leading)
                                    .clipShape(RoundedRectangle(cornerRadius: 32, style: .continuous))
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 32)
                                            .strokeBorder(profileIcon.profilePicString != img ? Color.clear : Color.forest, lineWidth: 4)

                                    )
                                    
                                }
                            }
                        }
                    }
                }
            }
            .frame(maxWidth: .infinity)
        }
    }
}


// Main Sign Uew View
struct SignUpView: View {
    //
    @StateObject private var signInViewModel = SignInEmailViewModel()
    //
    @State private var userObj = NewUserData()
    @State private var currentStep: Steps = .personal
    @State private var showAlert = false
    @State private var errorMessage = ""
    
    var body: some View {
        ZStack {
            Color.lightBlue
                .ignoresSafeArea()
            
            
            VStack(spacing: 30) {
                HStack(spacing: 20) {
                    if let previousStep = currentStep.previous {
                        Button(action: {
                            currentStep = previousStep
                        }) {
                            Image(systemName: "arrow.left")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20)
                                .foregroundStyle(.forest)
                        }
                        
                    } else if currentStep == .personal {
                        NavigationLink(destination: SignInView()        .navigationBarBackButtonHidden(true)
                        ) {
                            Image(systemName: "arrow.left")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20)
                                .foregroundStyle(.forest)
                            
                        }
                    }
                    HStack(spacing: 10) {
                        RoundedRectangle(cornerRadius: 25)
                            .fill(.forest)
                            .frame(maxWidth: 100, maxHeight: 3)
                        RoundedRectangle(cornerRadius: 25)
                            .fill(currentStep == .login || currentStep == .academic || currentStep == .pfp ? .forest : .gray)
                            .frame(maxWidth: 100, maxHeight: 3)
                        RoundedRectangle(cornerRadius: 25)
                            .fill(currentStep == .login || currentStep == .academic || currentStep == .pfp ? .forest : .gray)
                            .frame(maxWidth: 100, maxHeight: 3)
                        RoundedRectangle(cornerRadius: 25)
                            .fill(currentStep == .academic ? .forest : .gray)
                            .frame(maxWidth: 100, maxHeight: 3)
                    }
                    
                }
                
                Spacer()

                
                VStack(spacing: 40) {
                    switch currentStep {
                    case .personal:
                        NameView(personal: $userObj.personal, showAlert: $showAlert)
                    case .login:
                        LoginView(credentials: $userObj.credentials, showAlert: $showAlert)
                    case .academic:
                        AcademicView(academic: $userObj.academic, showAlert: $showAlert)
                    case .pfp:
                        PictureView(profileIcon: $userObj.pfp, showAlert: $showAlert)
                    }
                    
                    Spacer()
                    
                    
                    HStack {
                        Button(action: {
                            if currentStep.next != nil {
                                validate()
                            }
                        }) {
                            
                            if currentStep == .academic {
                                NavigationLink(destination: MainView().navigationBarBackButtonHidden(true)) {
                                    Text("Complete")
                                        .frame(maxWidth: .infinity, alignment: .bottom)
                                        .bold()
                                        .padding()
                                        .background(.forest)
                                        .foregroundStyle(.beige)
                                        .cornerRadius(16)
                                }
                                
                                
                            } else if currentStep.next != nil && currentStep != .login {
                                Text("Next")
                                    .frame(maxWidth: .infinity, alignment: .bottom)
                                    .bold()
                                    .padding()
                                    .background(.forest)
                                    .foregroundStyle(.beige)
                                    .cornerRadius(16)
                                
                            }
                            else if currentStep == .login {
                                Text("Sign Up")
                                    .frame(maxWidth: .infinity, alignment: .bottom)
                                    .bold()
                                    .padding()
                                    .background(.forest)
                                    .foregroundStyle(.beige)
                                    .cornerRadius(16)
                                
                            }
                            
                        }
                        .alert(isPresented: $showAlert) {
                            Alert(title: Text("Invalid Input"), message: Text(errorMessage), dismissButton: .default(Text("OK")))
                        }
                    }
                    .frame(alignment: .bottom)
                                        
                }
            }
            .padding(30)
            
        }
        .navigationBarBackButtonHidden(true)
    }
    
    func validate () {
        errorMessage = ""
        
        var hasErrors = false
        // Personal view
        if currentStep == .personal {
            userObj.personal.firstName = userObj.personal.firstName.trimmingCharacters(in: .whitespacesAndNewlines)
            userObj.personal.lastName = userObj.personal.lastName.trimmingCharacters(in: .whitespacesAndNewlines)
            
            // if empty
            if userObj.personal.firstName == "" || userObj.personal.lastName == "" {
                errorMessage = "Please fill out all fields."
                //hasErrors = true
                showAlert = true
                return
                //return
            }
            // Validate first name
            else if !isValidName(userObj.personal.firstName) {
                errorMessage = "First name must contain only alphabetic characters."
                //hasErrors = true
                showAlert = true
                return
            }
            
            // Validate last name
            else if !isValidName(userObj.personal.lastName) {
                errorMessage = "Last name must contain only alphabetic characters."
                showAlert = true
                return
            }
        }
        
        // Login View
        else if currentStep == .login {
            // Removing whitespaces
            userObj.credentials.username = userObj.credentials.username.trimmingCharacters(in: .whitespacesAndNewlines)
            userObj.credentials.password = userObj.credentials.password.trimmingCharacters(in: .whitespacesAndNewlines)
            userObj.credentials.confirmPassword = userObj.credentials.confirmPassword.trimmingCharacters(in: .whitespacesAndNewlines)
            userObj.credentials.email = userObj.credentials.email.trimmingCharacters(in: .whitespacesAndNewlines)
            
            // Check for empty fields
            if userObj.credentials.username.isEmpty ||
                userObj.credentials.password.isEmpty ||
                userObj.credentials.confirmPassword.isEmpty ||
                userObj.credentials.email.isEmpty {
                errorMessage = "Please fill out all fields."
                showAlert = true
                hasErrors = true
                return
            }
            // Validating email
            else if !isValidEmail(userObj.credentials.email) {
                errorMessage = "Invalid email format"
                showAlert = true
                return
            }
            
            // Validate password
            else if let passwordError = validatePassword(userObj.credentials.password) {
                errorMessage = passwordError
                showAlert = true
                hasErrors = true
                return
            }
            
            // Check if passwords match
            else if userObj.credentials.password != userObj.credentials.confirmPassword {
                errorMessage = "Passwords do not match."
                showAlert = true
                hasErrors = true
                return
            }
            
            // all is validate
            signInViewModel.email = userObj.credentials.email
            signInViewModel.password = userObj.credentials.password
            // if return true go to the next one else show error message
            signInViewModel.signIn()
            // add user to the user table
            
            // call the auth
        }

        
        else if currentStep == .pfp {
            if userObj.pfp.profilePicString == "" {
                errorMessage = "Please choose a profile picture."
                hasErrors = true
            }
        }
        
        if hasErrors {
            showAlert = true
        }
        else {
            if let nextStep = currentStep.next {
                currentStep = nextStep
            }
        }
    }
    // Validate name
    func isValidName(_ name: String) -> Bool {
        let nameRegex = "^[A-Za-z]+$"
        return NSPredicate(format: "SELF MATCHES %@", nameRegex).evaluate(with: name)
    }
    // Fucntion to validate email
    func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: email)
    }
    // Fucntion to validate password
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
// View models end -------------------------------------------
// Preview
#Preview {
    SignUpView()
}
