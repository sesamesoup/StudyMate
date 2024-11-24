//
//  AddPostView.swift
//  StudyMate
//
//  Created by Maddie Adair on 10/19/24.
//

import SwiftUI
import PhotosUI

struct AddPostView: View {
    @Environment(\.dismiss) private var dismiss
    
    @State private var title: String = ""
    @State private var description: String = ""
    @State private var subject: String = ""
    
    @State private var selectedItems = [PhotosPickerItem]()
    @State private var selectedImages = [Image]()
    @State private var majorSelection = majors[0]
    
    var body: some View {
        ZStack {
            Color.lightBeige
                .ignoresSafeArea()
            ScrollView(.vertical, showsIndicators: true) {
                VStack(alignment: .leading, spacing: 70) {
                    
                    HStack {
                        Button("Cancel") {
                            dismiss()
                        }
                        .foregroundStyle(.forest)
                        Spacer()
                        Button("Confirm") {
                            dismiss()
                        }
                        .foregroundStyle(.forest)
                    }
                    
                    Text("New Post")
                        .font(.custom("InstrumentSerif-Regular", size: 48))
                        .foregroundStyle(.forest)
                    
                    VStack(spacing: 30) {
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
                        
                        
                        VStack(alignment: .leading, spacing: 20) {
                            Text("Description")
                            TextField(text: $description, prompt: Text("Lorem Ipsum...")) {
                                Text(description)
                            }
                            .frame(height: 300, alignment: .topLeading)
                            .padding()
                            .accentColor(.black)
                            .cornerRadius(16)
                            .background(.customGrey)
                            .overlay(
                                RoundedRectangle(cornerRadius: 16)
                                    .strokeBorder(.black, lineWidth: 1)
                            )
                        }
                        
                        PhotosPicker(selection: $selectedItems, maxSelectionCount: 3, matching: .any(of: [.screenshots, .images])) {
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
                        }
                        .onChange(of: selectedItems) {
                            Task {
                                selectedImages.removeAll()
                                
                                for item in selectedItems {
                                    if let image = try? await item.loadTransferable(type: Image.self) {
                                        selectedImages.append(image)
                                    }
                                }
                            }
                        }
                        
                        ScrollView(.horizontal, showsIndicators: true) {
                            HStack() {
                                ForEach(0..<selectedImages.count, id: \.self) { i in
                                    selectedImages[i]
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 200, height: 200)
                                }
                            }
                        }
                        
                    }
                    
                }
                
            }
            .padding(30)
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    AddPostView()
}
