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
    
    //    func savePost(images: [UIImage]) async {
    //        // Getting th auth user
    //        guard let userID = Auth.auth().currentUser?.uid else {
    //            uploadError = "User not authenticated."
    //            print(uploadError ?? "Unknown error")
    //            return
    //        }
    //
    //        // Create a reference for Firebase Storage
    //        let storageRef = Storage.storage().reference()
    //        //print(storageRef.bucket)
    //
    //        var imageUrls: [String] = []
    //        let dispatchGroup = DispatchGroup() // To handle multiple uploads
    //
    //        for image in images {
    //            // Convert UIImage to Data
    //            guard let imageData = image.jpegData(compressionQuality: 0.8) else {
    //                print("Error converting image to data.")
    //                continue
    //            }
    //            print(type(of: imageData))
    //            // gets the data
    //            //print(imageData.isEmpty)
    //
    //            // Specify the file path for Firebase Storage
    ////            let fileRef = storageRef.child("users/\(UUID().uuidString).jpg")
    //            let fileRef = storageRef.child("users/abc.jpg")
    //
    //            // Begin the upload task
    ////            let metadata = StorageMetadata()
    ////            metadata.contentType = "image/jpeg" // Set correct Content-Type for image
    //            dispatchGroup.enter()
    //            fileRef.putData(imageData, metadata: nil) { metadata, error in
    //                if error != nil {
    //                    // Improved error handling: log full error
    //                    print("Unable toe upload the images")
    //                    print("Error uploading image to path: \(error!.localizedDescription)")
    //                    dispatchGroup.leave()
    //                    return
    //                }
    //
    //                // Successfully uploaded image, get the download URL
    //                fileRef.downloadURL { url, error in
    //                    if let error = error {
    //                        print("Error getting download URL for image: \(error.localizedDescription)")
    //                        dispatchGroup.leave()
    //                        return
    //                    }
    //
    //                    // Add the download URL to the list of image URLs
    //                    if let downloadURL = url {
    //                        imageUrls.append(downloadURL.absoluteString)
    //                    }
    //                    dispatchGroup.leave()
    //                }
    //            }
    //        }
    //
    //        // Once all uploads are finished, save the URLs to Firestore
    //        dispatchGroup.notify(queue: .main) {
    //            // Make sure we have URLs before saving to Firestore
    //            if imageUrls.isEmpty {
    //                print("No images were uploaded.")
    //                return
    //            }
    //
    //            // Generate a post ID for this post
    //            let postID = UUID().uuidString
    //
    //            // Add data to Firestore
    //            Task {
    //                do {
    //                    // Firestore reference
    //                    let _ = try await Firestore.firestore().collection("users")
    //                        .document(userID)
    //                        .collection("posts")
    //                        .document(postID)
    //                        .setData([
    //                            "id": postID,
    //                            "title": self.post.title,
    //                            "description": self.post.description,
    //                            "subject": self.post.subject,
    //                            "images": imageUrls,
    //                            "createdAt": self.post.createdAt
    //                        ])
    //                    print("Post successfully saved to Firestore.")
    //                } catch {
    //                    print("Error saving post to Firestore: \(error.localizedDescription)")
    //                }
    //            }
    //        }
    //    }
    
//    func savePost(images: [UIImage]) async {
//        guard let userID = Auth.auth().currentUser?.uid else {
//            uploadError = "User not authenticated."
//            print(uploadError ?? "Unknown error")
//            return
//        }
//        // Storage reference
//        let storageRef = Storage.storage().reference()
//        print("Storage reference initialized: \(storageRef)")
//        // to store the URL
//        var imageUrls: [String] = []
//        let dispatchGroup = DispatchGroup()
//        
//        for image in images {
//            guard let imageData = image.jpegData(compressionQuality: 0.8) else {
//                print("Error converting image to data.")
//                continue
//            }
//            
//            let fileRef = storageRef.child("users/\(userID)/\(UUID().uuidString).jpg")
//            dispatchGroup.enter()
//            
//            fileRef.putData(imageData, metadata: nil) { metadata, error in
//                if let error = error {
//                    print("Error uploading image: \(error.localizedDescription)")
//                    // Handle error (e.g., display error message, retry)
//                    dispatchGroup.leave()
//                    return
//                }
//                
//                fileRef.downloadURL { url, error in
//                    if let error = error {
//                        print("Error getting download URL: \(error.localizedDescription)")
//                        // Handle error (e.g., display error message, retry)
//                        dispatchGroup.leave()
//                        return
//                    }
//                    
//                    if let downloadURL = url {
//                        imageUrls.append(downloadURL.absoluteString)
//                    }
//                    dispatchGroup.leave()
//                }
//            }
//        }
//        
//        dispatchGroup.notify(queue: .main) {
//            if imageUrls.isEmpty {
//                print("No images were uploaded.")
//                return
//            }
//            
//            let postID = UUID().uuidString
//            
//            Task {
//                do {
//                    try await Firestore.firestore().collection("users")
//                        .document(userID)
//                        .collection("posts")
//                        .document(postID)
//                        .setData([
//                            //"id": postID,
//                            "title": self.post.title,
//                            "description": self.post.description,
//                            "subject": self.post.subject,
//                            "images": imageUrls,
//                            "createdAt": self.post.createdAt
//                        ])
//                    print("Post successfully saved to Firestore.")
//                } catch {
//                    print("Error saving post to Firestore: \(error.localizedDescription)")
//                    // Handle error (e.g., display error message)
//                }
//            }
//        }
//    }
//    
//    
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

