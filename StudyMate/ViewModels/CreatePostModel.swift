//
//  CreatePostModel.swift
//  StudyMate
//
//  Created by Sarang Mistry on 12/3/24.
//

import Foundation
import SwiftUI
import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage


struct Post2: Identifiable, Codable {
    var id: String = UUID().uuidString // Unique identifier for the post
    var title: String
    var description: String
    var subject: String
    var images: [String] // URLs of uploaded images
    var createdAt: Date = Date() // Timestamp for when the post was created
}

// Add Post View Model
@MainActor
class AddPostViewModel: ObservableObject {
    @Published var post: Post2 = Post2(title: "", description: "", subject: "", images: [])
    @Published var isUploading: Bool = false
    @Published var uploadError: String? = nil
    
    //--------------------------------------------------------------------------------------------
    // Function to upload images to Firebase Storage and return their URLs
    func uploadImagesToStorage(images: [UIImage], userID: String) async throws -> [String] {
        let storageRef = Storage.storage().reference()
        var imageUrls: [String] = []
        let dispatchGroup = DispatchGroup()
        
        for image in images {
            guard let imageData = image.jpegData(compressionQuality: 0.8) else {
                print("Error converting image to data.")
                continue
            }
            // get the path ref
            let fileRef = storageRef.child("users/\(userID)/\(UUID().uuidString).jpg")
            dispatchGroup.enter()
            // add the data to storage
            fileRef.putData(imageData, metadata: nil) { metadata, error in
                if let error = error {
                    print("Error uploading image: \(error.localizedDescription)")
                    dispatchGroup.leave()
                    return
                }
                // get the URL
                fileRef.downloadURL { url, error in
                    if let error = error {
                        print("Error getting download URL: \(error.localizedDescription)")
                        dispatchGroup.leave()
                        return
                    }
                    // if success add to the image url string
                    if let downloadURL = url {
                        imageUrls.append(downloadURL.absoluteString)
                    }
                    dispatchGroup.leave()
                }
            }
        }
        
        // Wait for all uploads to complete
        dispatchGroup.wait()
        
        if imageUrls.isEmpty {
            throw NSError(domain: "UploadError", code: -1, userInfo: [NSLocalizedDescriptionKey: "No images were uploaded."])
        }
        
        return imageUrls
    }
    
    // Function to save post to Firestore
    func savePostToFirestore(userID: String, post: Post2, imageUrls: [String]) async {
        let postID = UUID().uuidString
        
        do {
            try await Firestore.firestore().collection("users")
                .document(userID)
                .collection("posts")
                .document(postID)
                .setData([
                    "title": post.title,
                    "description": post.description,
                    "subject": post.subject,
                    "images": imageUrls,
                    "createdAt": post.createdAt
                ])
            print("Post successfully saved to Firestore.")
        } catch {
            print("Error saving post to Firestore: \(error.localizedDescription)")
        }
    }
    
    // Wrapper function to handle the process based on images parameter
    func savePost(images: [UIImage]) async {
        guard let userID = Auth.auth().currentUser?.uid else {
            print("User not authenticated.")
            return
        }
        
        do {
            let imageUrls: [String]
            
            if !images.isEmpty {
                imageUrls = try await uploadImagesToStorage(images: images, userID: userID)
            } else {
                imageUrls = [] // No images, pass an empty array
                print("No images selected. DB")
            }
            
            await savePostToFirestore(userID: userID, post: post, imageUrls: imageUrls)
        } catch {
            print("Error during post save process: \(error.localizedDescription)")
        }
    }

}

