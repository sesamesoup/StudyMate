//
//  AuthVeiwModel.swift
//  StudyMate
//
//  Created by Sarang Mistry on 10/23/24.
//
import SwiftUI
import FirebaseAuth

// final --> No inheritance
struct AuthDataResultModel{
    let uid: String
    let email: String?
    //let photoURL: String?
    
    init(user:User){
        self.uid = user.uid
        self.email = user.email
    }
}

//
class SignInEmailViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var errorMessage: String = ""
    
    // For creating users
    func createUser() async throws -> AuthDataResultModel{
        let authDataResult = try await Auth.auth().createUser(withEmail: self.email, password: self.password)
        //
        return AuthDataResultModel(user: authDataResult.user)
    }
    
    func signIn() async -> Bool {
        // Do validation here
        guard !email.isEmpty, !password.isEmpty else {
            print("No Email or password Found")
            return false
        }
        
        do {
            let returnedUserData = try await self.createUser()
            print("success")
            print(returnedUserData)
            
            return true
        } catch {
            print("error \(error)")
            return false
        }
    }

    
    // To Get authenticated user
    func getAuthenticatedUser() throws -> AuthDataResultModel{
        // not async casue it check the locally
        guard let user = Auth.auth().currentUser else{
            // Do something here
            throw URLError(.badServerResponse)
        }
        return AuthDataResultModel(user: user)
    }
}
