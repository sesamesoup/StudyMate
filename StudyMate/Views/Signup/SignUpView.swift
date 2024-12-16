//
//  SignUpView.swift
//  StudyMate
//
//  Created by Maddie Adair on 10/24/24.
//

import SwiftUI
import FirebaseFirestore
import FirebaseAuth
// Data Structure


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
                // First Name
                Text("First Name")
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                TextField("First Name", text: $personal.firstName)
                    .autocapitalization(.none)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(.white)
                    .cornerRadius(16)
                // Last Name
                Text("Last Name")
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                TextField("Last Name", text: $personal.lastName)
                    .autocapitalization(.none)
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
                    .autocapitalization(.none)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(.white)
                    .cornerRadius(16)
                Text("Email")
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                TextField("Email", text: $credentials.email)
                    .autocapitalization(.none)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(.white)
                    .cornerRadius(16)
                
                Text("Password")
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                SecureField("Password", text: $credentials.password)
                    .autocapitalization(.none)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(.white)
                    .cornerRadius(16)
                
                Text("Confirm Password")
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                SecureField("Confirm Password", text: $credentials.confirmPassword)
                    .autocapitalization(.none)
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
    @State private var imgArr: [String] = ["girl1", "girl2", "girl3", "girl4", "girl5", "girl6", "guy1", "guy2", "guy3", "guy4", "guy5", "guy6"]
    
    
    @Binding var profileIcon: ProfileIcon
    @Binding var showAlert: Bool
    
    
    private let size: CGFloat = 100
        private let padding: CGFloat = 20
    
    var body: some View {
        VStack(alignment: .leading, spacing: 50) {
            VStack(alignment: .leading, spacing: 10) {
                Text("Profile Picture")
                    .font(.custom("InstrumentSerif-Regular", size: 40))
                
                Text("Please choose a profile picture.")
                    .fixedSize(horizontal: false, vertical: true)
            }
            
            // Dynamic ScrollView Grid for profile picture selection
            ScrollView {
                LazyVGrid(
                    columns: [GridItem(.adaptive(minimum: size))],
                    spacing: padding)
                {
                    ForEach(imgArr, id: \.self) { img in
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
                    .padding(padding)
                }
                .frame(maxWidth: .infinity)
            }
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
    
    // Var to navigate to HomeView
    @State private var navigateToHomeView = false
    
    // Landscape mode
    @Environment(\.verticalSizeClass) var verticalSizeClass: UserInterfaceSizeClass?
    
    var body: some View {
        ZStack {
            Color.lightBlue
                .ignoresSafeArea()
            
            
            ScrollView {
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
                            NavigationLink(destination: WelcomeView().navigationBarBackButtonHidden(true)
                            ) {
                                Image(systemName: "arrow.left")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 20)
                                    .foregroundStyle(.forest)
                                
                            }
                        }
                        
                        // Progress bar
                        HStack(spacing: 10) {
                            RoundedRectangle(cornerRadius: 25)
                                .fill(.forest)
                                .frame(maxWidth: .infinity, maxHeight: 3)
                            RoundedRectangle(cornerRadius: 25)
                                .fill(currentStep == .login || currentStep == .academic || currentStep == .pfp ? .forest : .gray)
                                .frame(maxWidth: .infinity, maxHeight: 3)
                            RoundedRectangle(cornerRadius: 25)
                                .fill(currentStep == .login || currentStep == .academic || currentStep == .pfp ? .forest : .gray)
                                .frame(maxWidth: .infinity, maxHeight: 3)
                            RoundedRectangle(cornerRadius: 25)
                                .fill(currentStep == .academic ? .forest : .gray)
                                .frame(maxWidth: .infinity, maxHeight: 3)
                        }
                        .frame(maxWidth: .infinity)
                        
                    }
                    
                    Spacer()
                    
                    
                    VStack(spacing: 30) {
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
                                validate()
                                print("The current step was\(currentStep)")
                            }) {
                                
                                // Last step reached to sign up
                                if currentStep == .academic {
                                    Text("Sign Up")
                                        .frame(maxWidth: .infinity, alignment: .bottom)
                                        .bold()
                                        .padding()
                                        .background(.forest)
                                        .foregroundStyle(.beige)
                                        .cornerRadius(16)
                                    
                                // Keep going to the next step until you reach the last step
                                } else if currentStep.next != nil && currentStep != .academic {
                                    Text("Next")
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
                            
                            // Programmaticaly navigate to Main View once sign up is completed
                            NavigationLink(
                                destination: MainView().navigationBarBackButtonHidden(true),
                                isActive: $navigateToHomeView
                            ) {
                                EmptyView()
                            }
                        }
                        .frame(alignment: .bottom)
                        
                    }
                }
                .padding(30)
            }
            
        }
        .navigationBarBackButtonHidden(true)
    }
    
    func validate () {
        errorMessage = ""
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
            else {
                if let nextStep = currentStep.next {
                    currentStep = nextStep
                    //
                    return
                }
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
                return
            }
            // Validating email --- Call backend to check if the usernmae is taken
            else if !isValidEmail(userObj.credentials.email) {
                errorMessage = "Invalid email format"
                showAlert = true
                return
            }
            
            // Validate password
            else if let passwordError = validatePassword(userObj.credentials.password) {
                errorMessage = passwordError
                showAlert = true
                return
            }
            
            // Check if passwords match
            else if userObj.credentials.password != userObj.credentials.confirmPassword {
                errorMessage = "Passwords do not match."
                showAlert = true
                return
            }
            
            // All is validated
            else {
                signInViewModel.email = userObj.credentials.email
                signInViewModel.password = userObj.credentials.password
                
                // Perform sign-in asynchronously
                Task {
                    let success = await signInViewModel.signIn()
                    
                    // Get the current user after sign-in
                    if let currentUser = Auth.auth().currentUser {
                        let userID = currentUser.uid
                        print("User ID: \(userID)")
                        
                        if success {
                            let userData: [String: Any] = [
                                "email": signInViewModel.email,
                                "password": signInViewModel.password,
                                "username": userObj.credentials.username,
                                "firstName": userObj.personal.firstName,
                                "lastName": userObj.personal.lastName
                            ]
                            
                            saveUserDataToFirestore(userID: userID, userData: userData) { isSuccess, errorMessage in
                                if let errorMessage = errorMessage {
                                    self.errorMessage = errorMessage
                                    self.showAlert = true
                                } else if isSuccess {
                                    // Successfully saved, navigate to the homepage or next step
                                    self.currentStep = .pfp
                                    return
                                }
                            }
                        } else {
                            self.errorMessage = "Login failed, please try again."
                            self.showAlert = true
                        }
                    } else {
                        print("No user is currently signed in.")
                        self.errorMessage = "Failed to authenticate user."
                        self.showAlert = true
                    }
                }
            }
            
            
            // call the auth
        }
        
        // Profile page setup
        else if currentStep == .pfp {
            if userObj.pfp.profilePicString == "" {
                errorMessage = "Please choose a profile picture."
                showAlert = true
                return
            }
            else{
                currentStep = .academic
                return
            }
        }
        
        // Academic setup
        else if currentStep == .academic {
            print("Year: \(userObj.academic.year)")
            print("Major: \(userObj.academic.major)")
            // validate data
            if userObj.academic.major == "" {
                errorMessage = "Please enter your major."
                showAlert = true
                return
            }
            else if userObj.academic.year.isEmpty{
                errorMessage = "Please enter your year."
                showAlert = true
                return
            }
            else{
                if let currentUser = Auth.auth().currentUser {
                    let userID = currentUser.uid
                    print("User ID: \(userID)")
                    
                    
                    let userData: [String: Any] = [
                        "profilePicture": userObj.pfp.profilePicString,
                        "major": userObj.academic.major,
                        "year": userObj.academic.year
                    ]
                    
                    saveUserDataToFirestore(userID: userID, userData: userData) { isSuccess, errorMessage in
                        if let errorMessage = errorMessage {
                            self.errorMessage = errorMessage
                            self.showAlert = true
                        } else if isSuccess {
                            navigateToHomeView = true
                            if let nextStep = currentStep.next {
                                currentStep = nextStep
                            }
                            else{
                                print("problem completing academic View")
                            }
                            return
                        }
                    }
                } else {
                    print("No user is currently signed in.")
                    self.errorMessage = "Failed to authenticate user."
                    self.showAlert = true
                }
            }
            
        }
        //
        else {
            //
            print("in else of all if for views in SignUpView")
        }
    }
    //-------------------------------------------------------------------------------------------
    func saveUserDataToFirestore(
        userID: String,
        userData: [String: Any],
        completion: @escaping (Bool, String?) -> Void
    ) {
        Firestore.firestore().collection("users").document(userID).setData(userData, merge: true) { error in
            if let error = error {
                completion(false, "Failed to save user data: \(error.localizedDescription)")
            } else {
                completion(true, nil)
            }
        }
    }
    //-------------------------------------------------------------------------------------------
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
