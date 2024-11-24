//
//  AuthVeiwModel.swift
//  StudyMate
//
//  Created by Sarang Mistry on 10/23/24.
//
import SwiftUI
// importing Firebase auth
import FirebaseAuth

// final --> No inheritance
struct AuthDataResultModel{
    let uid: String
    let email: String?
    let photoURL: String?
    
    init(user:User){
        self.uid = user.uid
        self.email = user.email
        self.photoURL = user.photoURL?.absoluteString
    }
}

//
final class SignInEmailViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    
    // For creating users
    func createUser() async throws -> AuthDataResultModel{
        let authDataResult = try await Auth.auth().createUser(withEmail: self.email, password: self.password)
        //
        return AuthDataResultModel(user: authDataResult.user)
    }
    
    // for signin
    func signIn(){
        // Do validation here
        guard !email.isEmpty, !password.isEmpty else
        {
            print("No Email or password Found")
            return
        }
        Task{
            do{
                let returndUserData = try await self.createUser()
                print("success")
                print(returndUserData)
            }catch{
                print("error\(error)")
                
            }
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
