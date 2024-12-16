//
//  AddPostView.swift
//  StudyMate
//
//  Created by Maddie Adair on 10/19/24.
//

import SwiftUI
import PhotosUI
import FirebaseStorage
import FirebaseFirestore
import FirebaseAuth

enum ActiveAlert {
    case inputError, postError, success
}

struct AddPostView: View {
    
    @State private var title: String = ""
    @State private var description: String = ""
    @State private var majorSelection = majors[0]

    // Image Selection
    @State private var selectedImage: UIImage?
    @State private var selectedItem: PhotosPickerItem?
    
    @State private var showSheet: Bool = false
    
    // Alerts
    @State private var showAlert: Bool = false
    @State private var activeAlert: ActiveAlert = .inputError
    @State private var showCancelAlert: Bool = false
    
    // Dimiss Sheet
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            Color.lightBeige
                .ignoresSafeArea()
            ScrollView(.vertical, showsIndicators: true) {
                VStack(alignment: .leading, spacing: 70) {
                    
                    HStack {
                        Button("Cancel") {
                            showCancelAlert = true
                            
                        }
                        // Alert for cancel
                        .alert("Are you sure you want to cancel?", isPresented: $showCancelAlert) {
                            Button("Cancel", role: .destructive) {
                                resetAllFields() // Reset the fields
                                dismiss()// the view if model
                            }
                            Button("Keep Editing", role: .cancel) {
                                // Keep editing
                            }
                        }
                        .foregroundStyle(.forest)
                        
                        Spacer()
                            .foregroundStyle(.forest)
                        
                        Spacer()
                        
                        Button("Confirm") {
                            print("Confirm")
                            uploadPhotos()
                        }
                        .foregroundStyle(.forest)
                        // Input Error, Upload Error, and Success alerts
                        .alert(isPresented: $showAlert) {
                            switch activeAlert {
                            case .inputError:
                                return Alert(title: Text("Error"), message: Text("Please fill out all required fields"), dismissButton: .default(Text("OK")))
                            case .postError:
                                return Alert(title: Text("Error"), message: Text("Error uploading post. Please try again."), dismissButton: .default(Text("OK")))
                            case .success:
                                return Alert(title: Text("Success"), message: Text("Your post has been successfully saved."), dismissButton: .default(Text("OK"), action: {
                                    resetAllFields()
                                    dismiss() // Dismiss the view after confirming
                                }))
                            }
                        }
                    }
                    
                    Text("New Post")
                        .font(.custom("InstrumentSerif-Regular", size: 48))
                        .foregroundStyle(.forest)
                    
                    VStack(spacing: 30) {
                        VStack(alignment: .leading, spacing: 20) {
                            HStack {
                                Text("*")
                                    .foregroundStyle(Color.red)
                                    .bold()
                                Text("Title")
                                    .bold()
                            }
                            
                            // Title
                            TextField(text: $title, prompt: Text("Some Title...")) {
                                Text(title)
                            }
                            .frame(maxWidth: .infinity, maxHeight: 30, alignment: .leading)
                            .padding()
                            .accentColor(.black)
                            .background(.customGrey)
                            .cornerRadius(16)
                            .overlay(
                                RoundedRectangle(cornerRadius: 16)
                                    .strokeBorder(.black, lineWidth: 1)
                            )
                        }
                        
                        // Subject
                        VStack(alignment: .leading, spacing: 20) {
                            HStack {
                                Text("*")
                                    .foregroundStyle(Color.red)
                                    .bold()
                                Text("Subject")
                                    .bold()
                            }
                            
                            Picker("Subject", selection: $majorSelection)
                            {
                                ForEach(majors, id: \.self) {
                                    Text($0)
                                }
                            }
                            .pickerStyle(.menu)
                            .accentColor(.black)
                            .frame(maxWidth: .infinity, maxHeight: 30, alignment: .leading)
                            .padding()
                            .background(.customGrey)
                            .cornerRadius(16)
                            .overlay(
                                RoundedRectangle(cornerRadius: 16)
                                    .strokeBorder(.black, lineWidth: 1)
                            )
                        }
                        
                        // Description
                        VStack(alignment: .leading, spacing: 20) {
                            HStack {
                                Text("*")
                                    .foregroundStyle(Color.red)
                                    .bold()
                                Text("Description")
                                    .bold()
                            }
                            TextField(text: $description, prompt: Text("Lorem Ipsum..."), axis: .vertical) {
                                Text(description)
                            }
                            
                            .frame(height: 300, alignment: .topLeading)
                            .padding()
                            .accentColor(.black)
                            .background(.customGrey)
                            .cornerRadius(16)
                            .overlay(
                                RoundedRectangle(cornerRadius: 16)
                                    .strokeBorder(.black, lineWidth: 1)
                            )
                        }
                        
                        // Image picker
                        PhotosPicker(selection: $selectedItem, matching: .any(of: [.screenshots, .images])) {
                            HStack(spacing: 12) {
                                Text("Add Image")
                                    .bold()
                                
                                Image(systemName: "photo.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 15, height: 15)
                            }
                            .padding()
                            .background(.forest)
                            .clipShape(.capsule)
                            .foregroundStyle(.beige)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            
                            // Attempt to load image
                            .onChange(of: selectedItem) {
                                Task {
                                    if let imageData = try? await selectedItem?.loadTransferable(type: Data.self) {
                                        selectedImage = UIImage(data: imageData)
                                    } else {
                                        print("Failed")
                                    }
                                }
                            }
                        }
                        
                        Divider()
                        
                        // Show selected image
                        if selectedImage != nil {
                            Image(uiImage: selectedImage!)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 300, height: 300)
                        }
                        
                        
                    }
                    
                }
                
            }
            .padding(30)
        }
        .navigationBarBackButtonHidden(true)
    }
    
    func resetAllFields() {
        title = ""
        description = ""
        selectedImage = nil
        majorSelection = majors[0]
        showAlert = false
    }
    
    
    func uploadPhotos() {
        // If title and description are empty, show error alert
        if (title.isEmpty || description.isEmpty) {
            activeAlert = .inputError
            showAlert = true
            return
        }

        guard let userID = Auth.auth().currentUser?.uid else {
            print("User not authenticated.")
            return
        }

        // Create random post ID and timestamp
        let postID = UUID().uuidString
        let timestamp = Timestamp(date: Date())

        if let selectedImage = selectedImage {
            // Create a storage reference
            let storageRef = Storage.storage().reference()

            // Turn image into data
            guard let imageData = selectedImage.jpegData(compressionQuality: 0.8) else {
                print("Failed to convert image to data.")
                return
            }

            // Specify file path and name
            let path = "users/\(userID)/\(UUID().uuidString).jpg"
            let fileRef = storageRef.child(path)

            // Create file metadata including the content type
            let metadata = StorageMetadata()
            metadata.contentType = "image/jpeg"

            // Upload data
            fileRef.putData(imageData, metadata: metadata) { metadata, error in
                if let error = error {
                    print("Error uploading image: \(error.localizedDescription)")
                    return
                }

                // Retrieve the download URL
                fileRef.downloadURL { url, error in
                    if let error = error {
                        print("Error retrieving download URL: \(error.localizedDescription)")
                        return
                    }

                    guard let url = url else {
                        print("Download URL is nil.")
                        return
                    }

                    // Save post data in Firestore
                    savePostToFirestore(userID: userID, postID: postID, timestamp: timestamp, imageUrl: url.absoluteString)
                }
            }
        } else {
            // Save post with empty image field
            savePostToFirestore(userID: userID, postID: postID, timestamp: timestamp, imageUrl: "")
        }
    }

    private func savePostToFirestore(userID: String, postID: String, timestamp: Timestamp, imageUrl: String) {
        let db = Firestore.firestore()
        db.collection("users")
            .document(userID)
            .collection("posts")
            .document(postID)
            .setData([
                "title": title,
                "description": description,
                "subject": majorSelection,
                "image": imageUrl,
                "createdAt": timestamp
            ]) { error in
                if let error = error {
                    print("Error saving post: \(error.localizedDescription)")
                    activeAlert = .postError
                    showAlert = true
                } else {
                    print("Post successfully saved.")
                    activeAlert = .success
                    showAlert = true
                }
            }
    }
}

#Preview {
    AddPostView()
}
