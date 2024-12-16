//
//  CreateNewMessageViewModel.swift
//  StudyMate
//
//  Created by Maddie Adair on 12/5/24.
//
import Firebase
import FirebaseAuth
import FirebaseFirestore

struct OtherUser: Identifiable {
    var id: String { uid } // `id` conforms to Identifiable protocol
    let uid: String // Document ID (user ID)
    let email, firstName, lastName, major, year, profilePicture, username: String
    
    init(documentId: String, data: [String: Any]) {
        self.uid = documentId // Use document ID as uid
        self.email = data["email"] as? String ?? ""
        self.firstName = data["firstName"] as? String ?? ""
        self.lastName = data["lastName"] as? String ?? ""
        self.major = data["major"] as? String ?? ""
        self.year = data["year"] as? String ?? ""
        self.profilePicture = data["profilePicture"] as? String ?? ""
        self.username = data["username"] as? String ?? ""
    }
    init() {
        self.uid = "" // Use document ID as uid
        self.email = ""
        self.firstName = ""
        self.lastName = ""
        self.major =  ""
        self.year = ""
        self.profilePicture =  ""
        self.username =  ""
    }
    // For the detail post
    init(fromPost post: AllUserPosts) {
        self.uid = post.userInfo.id
        self.email = post.userInfo.email
        self.firstName = post.userInfo.firstName
        self.lastName = post.userInfo.lastName
        self.major = post.userInfo.major
        self.year = post.userInfo.year
        self.profilePicture = post.userInfo.profilePicture
        self.username = post.userInfo.username
    }
    //
    init(uid: String, email: String, firstName: String, lastName: String, major: String, year: String, profilePicture: String, username: String) {
        self.uid = uid
        self.email = email
        self.firstName = firstName
        self.lastName = lastName
        self.major = major
        self.year = year
        self.profilePicture = profilePicture
        self.username = username
    }
}


class CreateNewMessageViewModel: ObservableObject {
    @Published var users = [OtherUser]()
    @Published var errorMessage = ""
    
    init() {
        fetchAllUsers()
    }
    
    
    private func fetchAllUsers() {
        guard let currentUserId = Auth.auth().currentUser?.uid else {
            self.errorMessage = "No logged-in user found."
            print("No logged-in user found.")
            return
        }
        
        Firestore.firestore().collection("users")
            .getDocuments { snapshot, error in
                if let error = error {
                    self.errorMessage = "Failed to fetch users: \(error.localizedDescription)"
                    print("Failed to fetch users: \(error)")
                    return
                }
                
                guard let documents = snapshot?.documents else {
                    self.errorMessage = "No documents found"
                    print("No documents found")
                    return
                }
                
                // Filter out the current user and map to OtherUser
                self.users = documents.compactMap { document in
                    if document.documentID == currentUserId {
                        return nil // Skip current user
                    }
                    return OtherUser(documentId: document.documentID, data: document.data())
                }
                
                //                print("Fetched users (excluding current): \(self.users)")
                print("Fetched users (excluding current): in Create New Message View")
            }
    }
}
