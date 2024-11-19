//
//  SignUpView.swift
//  StudyMate
//
//  Created by Maddie Adair on 10/24/24.
//

import SwiftUI

struct Personal {
    var firstName: String = ""
    var lastName: String = ""
}

struct Credentials {
    var username: String = ""
    var email: String = ""
    var password: String = ""
    var confirmPassword: String = ""
}

struct Academic {
    var major: String = majors[0]
    var year: String = "Sophomore"
}

struct NewUserData {
    var personal: Personal = Personal()
    var credentials: Credentials = Credentials()
    var academic: Academic = Academic()
}

enum Steps {
    case personal
    case login
    case academic
    
    var title: String {
        switch self {
        case .personal: return "Personal"
        case .login: return "Login"
        case .academic: return "Academic"
        }
    }
    
    var next: Steps? {
        switch self {
        case .personal: return .login
        case .login: return .academic
        case .academic: return nil
        }
    }
    
    var previous: Steps? {
        switch self {
        case .personal: return nil
        case .login: return .personal
        case .academic: return .login
        }
    }
}

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

struct SignUpView: View {
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
                            .fill(currentStep == .login || currentStep == .academic ? .forest : .gray)
                            .frame(maxWidth: 100, maxHeight: 3)
                        RoundedRectangle(cornerRadius: 25)
                            .fill(currentStep == .academic ? .forest : .gray)
                            .frame(maxWidth: 100, maxHeight: 3)
                    }
                   
                }
                Spacer()
//                Image("collab3")
//                    .resizable()
//                    .scaledToFit()
//                    .frame(height: 175)
//
//                Spacer()
                
                
                VStack(spacing: 40) {
                    switch currentStep {
                    case .personal:
                        NameView(personal: $userObj.personal, showAlert: $showAlert)
                    case .login:
                        LoginView(credentials: $userObj.credentials, showAlert: $showAlert)
                    case .academic:
                        AcademicView(academic: $userObj.academic, showAlert: $showAlert)
                    }
                    
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
                                
                                
                            } else if currentStep.next != nil {
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
                    }
                    .frame(maxHeight: .infinity, alignment: .bottom)
                    
                }
            }
            .padding(30)
            
        }
        .navigationBarBackButtonHidden(true)
    }
    
    func validate () {
        errorMessage = ""
        
        var hasErrors = false
        
        if currentStep == .personal {
            if userObj.personal.firstName == "" || userObj.personal.lastName == "" {
                errorMessage = "Please fill out all fields."
                hasErrors = true
            }
        }
        
        else if currentStep == .login {
            var error1 = ""
            var error2 = ""
            
            if (userObj.credentials.username == "" || userObj.credentials.password == "" || userObj.credentials.confirmPassword == "") {
                error1 = "Please fill out all fields."
                hasErrors = true
            }
            if userObj.credentials.password != userObj.credentials.confirmPassword {
                error2 = "Passwords do not match."
                hasErrors = true
            }
            
            if (error1 != "" && error2 != ""){
                errorMessage = "Please fill out all fields and make sure passwords are the same."
            } else {
                errorMessage = error1 + error2
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
}

#Preview {
    SignUpView()
}
