//
//  ProfileModel.swift
//  StudyMate
//
//  Created by Sarang Mistry on 12/3/24.
//

import Foundation

struct UserProfile: Identifiable, Codable {
    var id: String // The user ID (matches the Firestore document ID)
    var email: String
    var firstName: String
    var lastName: String
    var major: String
    var password: String
    var profilePicture: String
    var username: String
    var year: String
}


import Firebase
@MainActor
class ProfileViewModel: ObservableObject {
    @Published var userProfile: UserProfile? // The fetched user profile
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    
    // fetching users entire profile
    func fetchUserProfile(userID: String) async {
        isLoading = true
        errorMessage = nil
        
        do {
            let document = try await Firestore.firestore().collection("users").document(userID).getDocument()
            if let data = document.data() {
                self.userProfile = UserProfile(
                    id: userID,
                    email: data["email"] as? String ?? "",
                    firstName: data["firstName"] as? String ?? "",
                    lastName: data["lastName"] as? String ?? "",
                    major: data["major"] as? String ?? "",
                    password: data["password"] as? String ?? "",
                    profilePicture: data["profilePicture"] as? String ?? "",
                    username: data["username"] as? String ?? "",
                    year: data["year"] as? String ?? ""
                )
            } else {
                errorMessage = "No data found for this user."
                print(errorMessage as Any)
            }
        } catch {
            errorMessage = "Failed to fetch profile data: \(error.localizedDescription)"
        }
        
        isLoading = false
    }
    // Update User Selection
    
}
