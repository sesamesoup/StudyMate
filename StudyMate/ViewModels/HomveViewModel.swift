//
//  HomveViewModel.swift
//  StudyMate
//
//  Created by Sarang Mistry on 12/3/24.
//

import Foundation
import Firebase
import FirebaseAuth

struct UserInfo: Identifiable {
    var id: String // userID (Firestore document ID of the user)
    var username: String // Username of the user
    var firstName: String // First name of the user
    var lastName: String // Last name of the user
    var email: String // Email address of the user
    var profilePicture: String // Profile picture URL of the user
    var year: String // Year (if available, optional field)
    var major: String // Major (if available, optional field)
}

//
struct AllUserPosts: Identifiable {
    var id: String // postID (Auto-generated Firestore document ID)
    var createdAt: Timestamp // Timestamp when the post was created
    var description: String // Description of the post
    var image: String // Image URL
//    var images: [String] // Array of image URLs
    var subject: String // Subject of the post
    var title: String // Title of the post
    var userInfo: UserInfo // Associated user information
}




func loadPostsForOtherUsers(completion: @escaping ([AllUserPosts]) -> Void) {
    // getthing the current user
    guard let currentUserID = Auth.auth().currentUser?.uid else {
        print("No user is logged in.")
        completion([])
        return
    }
    // connecting to firebase
    let db = Firestore.firestore()
    
    // Accessing documents of Users
    db.collection("users").getDocuments(source: .default) { (userSnapshot, error) in
        if let error = error {
            print("Error fetching users: \(error)")
            completion([])
            return
        }
        // Creating list of posts
        var posts: [AllUserPosts] = []
        // getting usr documents from the snapshot
        guard let userDocuments = userSnapshot?.documents else {
            completion([])
            return
        }
        
        // Filter out the current user's data
        let otherUsers = userDocuments.filter { $0.documentID != currentUserID }
        
        let dispatchGroup = DispatchGroup()
        // Iterating to other usrs
        for userDoc in otherUsers {
            let userID = userDoc.documentID
            let userData = userDoc.data()
            
            let userInfo = UserInfo(
                id: userID,
                username: userData["username"] as? String ?? "",
                firstName: userData["firstName"] as? String ?? "",
                lastName: userData["lastName"] as? String ?? "",
                email: userData["email"] as? String ?? "",
                profilePicture: userData["profilePicture"] as? String ?? "",
                year: userData["year"] as? String ?? "",
                major: userData["major"] as? String ?? ""
            )
            
            dispatchGroup.enter()
            
            // Fetch posts for the current user
            db.collection("users").document(userID).collection("posts").getDocuments(source: .default) { (postSnapshot, error) in
                if let error = error {
                    print("Error fetching posts for user \(userID): \(error)")
                    dispatchGroup.leave()
                    return
                }
                
                guard let postDocuments = postSnapshot?.documents, !postDocuments.isEmpty else {
                    // Skip this user if they don't have posts
                    dispatchGroup.leave()
                    return
                }
                // for each postDocs of a user
                for postDoc in postDocuments {
                    let postData = postDoc.data()
                    let post = AllUserPosts(
                        id: postDoc.documentID,
                        createdAt: postData["createdAt"] as? Timestamp ?? Timestamp(),
                        description: postData["description"] as? String ?? "",
                        image: postData["image"] as? String ?? "",
//                        images: postData["images"] as? [String] ?? [],
                        subject: postData["subject"] as? String ?? "",
                        title: postData["title"] as? String ?? "",
                        userInfo: userInfo
                    )
                    posts.append(post)
                }
                
                dispatchGroup.leave()
            }
        }
        
        dispatchGroup.notify(queue: .main) {
            completion(posts)
        }
    }
}
