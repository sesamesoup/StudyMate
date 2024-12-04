//
//  AddPostView.swift
//  StudyMate
//
//  Created by Maddie Adair on 10/19/24.
//

import SwiftUI
import PhotosUI
import Firebase
import FirebaseStorage
import UIKit

struct AddPostView: View {
    //
    @StateObject private var addPostViewModel = AddPostViewModel()
    //
    @Environment(\.dismiss) private var dismiss
    
    @State private var title: String = ""
    @State private var errorMessage: String = ""
    @State private var description: String = ""
//    @State private var subject: String = ""
    @State private var showAlert: Bool = false
    @State private var showCancelAlert: Bool = false
    @State private var selectedItems = [PhotosPickerItem]()
    @State private var selectedImages = [UIImage]()
    @State private var majorSelection = majors[0]
    
    var body: some View {
        ZStack {
            Color.lightBeige
                .ignoresSafeArea()
            // Scroll View
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading, spacing: 45) {
                    
                    HStack {
                        Button("Cancel") {
                            showCancelAlert = true
                            
                        }
                        .alert("Are you sure you want to cancel?", isPresented: $showCancelAlert) {
                            Button("Cancel", role: .destructive) {
                                resetAllFields() // Reset the fields
                                //dismiss() the view if model
                            }
                            Button("Keep Editing", role: .cancel) {
                                // Keep editing
                            }
                        }
                        .foregroundStyle(.forest)
                        Spacer()

                        Button("Confirm") {
                            // Removing whitespaces
                            title = title.trimmingCharacters(in: .whitespacesAndNewlines)
                            description = description.trimmingCharacters(in: .whitespacesAndNewlines)
                            majorSelection = majorSelection.trimmingCharacters(in: .whitespacesAndNewlines)
                            
                            // Validate inputs
                            errorMessage = validateInputs()
                            if !errorMessage.isEmpty {
                                print("Validation failed: \(errorMessage)")
                                showAlert = true
                                return
                            } else {
                                print("All inputs are valid.")
                                print(description)
                                print(majorSelection)
                                
                                // Fill the object
                                addPostViewModel.post.title = title
                                addPostViewModel.post.description = description
                                addPostViewModel.post.subject = majorSelection
//                                print(selectedItems[0])
                                // Perform asynchronous save operation in a Task
                                Task {
                                    await addPostViewModel.savePost(images: selectedImages)
                                    //print("Post saved successfully.")
                                }
//                                await addPostViewModel.savePost(images: selectedImages)

                            }
                        }

                        .foregroundStyle(.forest)
                    }
                    
                    Text("New Post")
                        .font(.custom("InstrumentSerif-Regular", size: 48))
                        .foregroundStyle(.forest)
                    
                   // ---------------------- Input Fileds --------------------------------------------
                    VStack(spacing: 20) {
                        // ---------------------- Title of the post ----------------------
                        VStack(alignment: .leading, spacing: 20) {
                            Text("Title")
                            TextField(text: $title, prompt: Text("Some Title...")) {
                                Text(title)
                            }
                            .frame(maxWidth: .infinity, maxHeight: 30, alignment: .leading)
                            .padding()
                            .accentColor(.black)
                            .cornerRadius(16)
                            .background(.customGrey)
                            .overlay(
                                RoundedRectangle(cornerRadius: 16)
                                    .strokeBorder(.black, lineWidth: 1)
                            )
                        }
                        
                        // Selecting Subjects
                        VStack(alignment: .leading, spacing: 20) {
                            Text("Subject")
                            
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
                            .cornerRadius(16)
                            .background(.customGrey)
                            .overlay(
                                RoundedRectangle(cornerRadius: 16)
                                    .strokeBorder(.black, lineWidth: 1)
                            )
                        }
                        
                        // ---------------------- Post description --------------------------
                        VStack(alignment: .leading, spacing: 20) {
                            Text("Description")
                            TextEditor(
                                text: Binding(
                                    get: { description },
                                    set: {
                                        if $0.count <= 100 {
                                            description = $0
                                        }
                                    }
                                    
                                )
                            )
                            .frame(minHeight: 60, maxHeight: min(CGFloat(description.count / 50) * 30 + 60, 300))
                            .padding()
                            .accentColor(.black)
                            .cornerRadius(16)
                            .background(.customGrey)
                            .overlay(
                                RoundedRectangle(cornerRadius: 16)
                                    .strokeBorder(.black, lineWidth: 1)
                            )
                            .scrollContentBackground(.hidden)
                        }
                        
                        // ---------------------- For picking pictures ----------------------
                        PhotosPicker(selection: $selectedItems, maxSelectionCount: 2, matching: .any(of: [.screenshots, .images])) {
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
                            .clipShape(Capsule())
                            .foregroundStyle(.beige)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        .onChange(of: selectedItems) { newItems in
                            // Clear previous images
                            selectedImages.removeAll()
                            
                            // Asynchronously load the images
                            Task {
                                for item in newItems {
                                    if let data = try? await item.loadTransferable(type: Data.self),
                                       let uiImage = UIImage(data: data) {
                                        print("Image loaded successfully.")
                                        selectedImages.append(uiImage)
                                    } else {
                                        print("Failed to load image.")
                                    }
                                }
                            }
                        }
                        // ---------------------- For showing Pictures ----------------------
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach(0..<selectedImages.count, id: \.self) { i in
                                    Image(uiImage: selectedImages[i]) // Directly use the UIImage
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 200, height: 200)
                                }
                            }
                        }
                        // End of Scroll view

                        
                    }
                    .alert(isPresented: $showAlert) {
                        Alert(title: Text("Invalid Input"), message: Text(errorMessage), dismissButton: .default(Text("OK")))
                    }
                    
                }
                
            }
            .padding(30)
        }
        .navigationBarBackButtonHidden(true)
    }
    
    
    
    // ---------------- View ends ----------------------------
    func validateInputs() -> String {
        if title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            return "Title cannot be empty."
        }
        if description.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            return "Description cannot be empty."
        }
        if majorSelection.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            return "Please select a subject."
        }
        if selectedImages.isEmpty {
            return "Please select at least one image."
        }
        return ""
    }

    //----------------------------
    func resetAllFields() {
        title = ""
        errorMessage = ""
        description = ""
        majorSelection = ""
        showAlert = false
        selectedItems = []
        selectedImages = []
        majorSelection = majors[0]
    }


}

#Preview {
    AddPostView()
}
