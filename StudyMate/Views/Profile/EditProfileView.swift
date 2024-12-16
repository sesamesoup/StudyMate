//
//  EditProfileView.swift
//  StudyMate
//
//  Created by Maddie Adair on 11/19/24.
//
//

import SwiftUI
import Firebase
import FirebaseAuth

struct EditProfileView: View {
    @Environment(\.dismiss) var dismiss
    //
    @State var major: String
    @State var year: String
    @State var profileIcon: String
    
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var isSuccessAlert = false
    
    @Environment(\.verticalSizeClass) var verticalSizeClass: UserInterfaceSizeClass?
    
    var body: some View {
        ZStack {
            Color.lightBeige
                .ignoresSafeArea()
            
            if verticalSizeClass == .regular {
                VStack(spacing: 40) {
                    // Profile Picture
                    NavigationLink(destination: EditProfilePicView(profileIcon: $profileIcon)) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 50,
                                             style: .continuous)
                            .aspectRatio(1.4, contentMode: .fill)
                            .overlay(
                                
                                Image(profileIcon)
                                    .resizable()
                                    .scaledToFill()
                                    .offset(x: -30.0, y: 20.0)
                                
                                
                            )
                            .frame(width: 150, height: 150, alignment: .leading)
                            .clipShape(RoundedRectangle(cornerRadius: 50,
                                                        style: .continuous))
                            Image(systemName: "pencil")
                                .padding(6)
                                .foregroundStyle(.black)
                                .background(Color.white)
                                .clipShape(Capsule())
                                .offset(x: 45.0, y: 45.0)
                        }
                    }
                    
                    // Years and Major
                    VStack(alignment: .center, spacing: 50) {
                        VStack(alignment: .leading, spacing: 22) {
                            // Year Picker
                            Text("Year")
                                .fontWeight(.bold)
                            
                            Picker("-- Select a year --", selection: $year) {
                                ForEach(years, id: \.self) {
                                    Text($0)
                                }
                            }
                            .pickerStyle(.menu)
                            .accentColor(.forest)
                            .frame(maxWidth: .infinity, maxHeight: 30, alignment: .leading)
                            .padding()
                            .background(.customGrey)
                            .cornerRadius(16)
                            .overlay(
                                RoundedRectangle(cornerRadius: 16)
                                    .strokeBorder(.gray, lineWidth: 1)
                            )
                            
                            // Major Picker
                            Text("Major")
                                .fontWeight(.bold)
                            
                            Picker("-- Select a major --", selection: $major) {
                                ForEach(majors, id: \.self) {
                                    Text($0)
                                }
                            }
                            .pickerStyle(.menu)
                            .accentColor(.forest)
                            .frame(maxWidth: .infinity, maxHeight: 30, alignment: .leading)
                            .padding()
                            .background(.customGrey)
                            .cornerRadius(16)
                            .overlay(
                                RoundedRectangle(cornerRadius: 16)
                                    .strokeBorder(.gray, lineWidth: 1)
                            )
                        }
                    }
                    .frame(maxWidth: .infinity)
                    
                    // Confirm Button
                    Button(action: {
                        if validateInputs() {
                            updateProfile()
                        }
                    }) {
                        Text("Confirm")
                            .bold()
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .center)
                            .background(.forest)
                            .foregroundStyle(.beige)
                            .cornerRadius(16)
                    }
                    .alert(isPresented: $showAlert) {
                        Alert(
                            title: Text(isSuccessAlert ? "Success" : "Invalid Input"),
                            message: Text(alertMessage),
                            dismissButton: .default(Text("OK"))
                        )
                    }
                    
                    Spacer()
                }
                
                // Custom cancel button
                .navigationBarBackButtonHidden(true)
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Button(action: {
                            dismiss()
                        }) {
                            HStack(spacing: 10) {
                                Image(systemName: "arrow.left")
                                    .foregroundStyle(.forest)
                                Text("Cancel")
                                    .foregroundStyle(.forest)
                            }
                        }
                    }
                }
                .padding(30)
            }
            
            else {
                
                ScrollView {
                    // Profile Picture
                    NavigationLink(destination: EditProfilePicView(profileIcon: $profileIcon)) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 50,
                                             style: .continuous)
                            .aspectRatio(1.4, contentMode: .fill)
                            .overlay(
                                
                                Image(profileIcon)
                                    .resizable()
                                    .scaledToFill()
                                    .offset(x: -30.0, y: 20.0)
                                
                                
                            )
                            .frame(width: 150, height: 150, alignment: .leading)
                            .clipShape(RoundedRectangle(cornerRadius: 50,
                                                        style: .continuous))
                            Image(systemName: "pencil")
                                .padding(6)
                                .foregroundStyle(.black)
                                .background(Color.white)
                                .clipShape(Capsule())
                                .offset(x: 45.0, y: 45.0)
                        }
                    }
                    
                    VStack(spacing: 40) {
                        // Years and Major
                        VStack(alignment: .center, spacing: 50) {
                            VStack(alignment: .leading, spacing: 22) {
                                // Year Picker
                                Text("Year")
                                    .fontWeight(.bold)
                                
                                Picker("-- Select a year --", selection: $year) {
                                    ForEach(years, id: \.self) {
                                        Text($0)
                                    }
                                }
                                .pickerStyle(.menu)
                                .accentColor(.forest)
                                .frame(maxWidth: .infinity, maxHeight: 30, alignment: .leading)
                                .padding()
                                .cornerRadius(16)
                                .background(.customGrey)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 16)
                                        .strokeBorder(.gray, lineWidth: 1)
                                )
                                
                                // Major Picker
                                Text("Major")
                                    .fontWeight(.bold)
                                
                                Picker("-- Select a major --", selection: $major) {
                                    ForEach(majors, id: \.self) {
                                        Text($0)
                                    }
                                }
                                .pickerStyle(.menu)
                                .accentColor(.forest)
                                .frame(maxWidth: .infinity, maxHeight: 30, alignment: .leading)
                                .padding()
                                .cornerRadius(16)
                                .background(.customGrey)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 16)
                                        .strokeBorder(.gray, lineWidth: 1)
                                )
                            }
                        }
                        .frame(maxWidth: .infinity)
                        
                        // Confirm Button
                        Button(action: {
                            if validateInputs() {
                                updateProfile()
                            }
                        }) {
                            Text("Confirm")
                                .bold()
                                .padding()
                                .frame(maxWidth: .infinity, alignment: .center)
                                .background(.forest)
                                .foregroundStyle(.beige)
                                .cornerRadius(16)
                        }
                        .alert(isPresented: $showAlert) {
                            Alert(
                                title: Text(isSuccessAlert ? "Success" : "Invalid Input"),
                                message: Text(alertMessage),
                                dismissButton: .default(Text("OK"))
                            )
                        }
                        
                        Spacer()
                    }
                    
                    // Custom Cancel button
                    .navigationBarBackButtonHidden(true)
                    .toolbar {
                        ToolbarItem(placement: .topBarLeading) {
                            Button(action: {
                                dismiss()
                            }) {
                                HStack(spacing: 10) {
                                    Image(systemName: "arrow.left")
                                        .foregroundStyle(.forest)
                                    Text("Cancel")
                                        .foregroundStyle(.forest)
                                }
                            }
                        }
                    }
                    .padding(30)
                }
            }
        }
    }
    
    // Validation Function
    private func validateInputs() -> Bool {
        if major.isEmpty || year.isEmpty {
            alertMessage = "Please fill out all fields."
            isSuccessAlert = false
            showAlert = true
            return false
        }
        return true
    }
    
    // Backend Update Function
    private func updateProfile() {
        guard let userID = Auth.auth().currentUser?.uid else {
            alertMessage = "No authenticated user found."
            isSuccessAlert = false
            showAlert = true
            return
        }
        
        let updatedData: [String: Any] = [
            "major": major,
            "year": year,
            "profilePicture": profileIcon
        ]
        
        Firestore.firestore().collection("users").document(userID).updateData(updatedData) { error in
            if let error = error {
                alertMessage = "Error updating profile: \(error.localizedDescription)"
                isSuccessAlert = false
            } else {
                alertMessage = "Your profile has been updated successfully!"
                isSuccessAlert = true
            }
            showAlert = true
        }
    }
}
