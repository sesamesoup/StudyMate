//
//  EditProfilePicView.swift
//  StudyMate
//
//  Created by Maddie Adair on 11/19/24.
//


import SwiftUI

struct EditProfilePicView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var profileIcon: String
    @State var selectedImg: String = ""
    
    @State private var imgArr: [[String]] = [["girl1", "girl2", "girl3"], ["girl4", "girl5", "girl6"], ["guy1", "guy2", "guy3"], ["guy4", "guy5", "guy6"]]
    
    @Environment(\.verticalSizeClass) var verticalSizeClass: UserInterfaceSizeClass?
    
    var body: some View {
        ZStack {
            Color.lightBeige
                .ignoresSafeArea()
            
            if verticalSizeClass == .regular {
                VStack(spacing: 40) {
                    RoundedRectangle(cornerRadius: 50,
                                     style: .continuous)
                    .aspectRatio(1.4, contentMode: .fill)
                    .overlay(
                        Image(selectedImg=="" ? profileIcon : selectedImg )
                            .resizable()
                            .scaledToFill()
                            .offset(x: -30.0, y: 20.0)
                    )
                    .frame(width: 150, height: 150, alignment: .leading)
                    .clipShape(RoundedRectangle(cornerRadius: 50,
                                                style: .continuous))
                    // Array of all the images
                    ScrollView {
                        VStack(spacing: 20) {
                            ForEach(imgArr, id: \.self) { arr in
                                HStack(spacing: 20) {
                                    ForEach(arr, id: \.self) { img in
                                        Button {
                                            selectedImg = img
                                        } label: {
                                            RoundedRectangle(cornerRadius: 32,
                                                             style: .continuous)
                                            .aspectRatio(1.4, contentMode: .fill)
                                            .overlay(
                                                Image(img)
                                                    .resizable()
                                                    .scaledToFill()
                                                    .offset(x: -20.0, y: 15.0)
                                                
                                            )
                                            .frame(width: 100, height: 100, alignment: .leading)
                                            .clipShape(RoundedRectangle(cornerRadius: 32, style: .continuous))
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 32)
                                                    .strokeBorder(selectedImg != img ? Color.clear : Color.forest, lineWidth: 4)
                                                
                                            )
                                            
                                        }
                                    }
                                }
                            }
                        }
                    }
                    .frame(maxWidth: .infinity)
                    
                    // Confirm picture selection
                    Button(action: {
                        if selectedImg != "" {
                            profileIcon = selectedImg
                            dismiss()
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
                    
                    
                    Spacer()
                }
                .navigationBarBackButtonHidden(true)
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Button(action: {
                            //profileIcon = selectedImg
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
                .onAppear(){
                    selectedImg = profileIcon
                }
                .padding(30)
            }
            
            else {
                HStack(spacing: 50) {
                    RoundedRectangle(cornerRadius: 50,
                                     style: .continuous)
                    .aspectRatio(1.4, contentMode: .fill)
                    .overlay(
                        Image(selectedImg=="" ? profileIcon : selectedImg )
                            .resizable()
                            .scaledToFill()
                            .offset(x: -30.0, y: 20.0)
                    )
                    .frame(width: 150, height: 150, alignment: .leading)
                    .clipShape(RoundedRectangle(cornerRadius: 50,
                                                style: .continuous))
                    
                    VStack(spacing: 24) {
                        // Array of all the images
                        ScrollView {
                            VStack(spacing: 20) {
                                ForEach(imgArr, id: \.self) { arr in
                                    HStack(spacing: 20) {
                                        ForEach(arr, id: \.self) { img in
                                            Button {
                                                selectedImg = img
                                            } label: {
                                                RoundedRectangle(cornerRadius: 32,
                                                                 style: .continuous)
                                                .aspectRatio(1.4, contentMode: .fill)
                                                .overlay(
                                                    Image(img)
                                                        .resizable()
                                                        .scaledToFill()
                                                        .offset(x: -20.0, y: 15.0)
                                                    
                                                )
                                                .frame(width: 100, height: 100, alignment: .leading)
                                                .clipShape(RoundedRectangle(cornerRadius: 32, style: .continuous))
                                                .overlay(
                                                    RoundedRectangle(cornerRadius: 32)
                                                        .strokeBorder(selectedImg != img ? Color.clear : Color.forest, lineWidth: 4)
                                                    
                                                )
                                                
                                            }
                                        }
                                    }
                                }
                            }
                        }
                        
                        // Confirm profile picture selection
                        Button(action: {
                            if selectedImg != "" {
                                profileIcon = selectedImg
                                dismiss()
                            }
                            
                        }) {
                            Text("Confirm")
                                .bold()
                                .padding()
                                .frame(maxWidth: 360, alignment: .center)
                                .background(.forest)
                                .foregroundStyle(.beige)
                                .cornerRadius(16)
                        }
                    }
                    .navigationBarBackButtonHidden(true)
                    .toolbar {
                        ToolbarItem(placement: .topBarLeading) {
                            Button(action: {
                                //profileIcon = selectedImg
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
                    .onAppear(){
                        selectedImg = profileIcon
                    }
                    .padding(30)
                }
            }
        }
    }
}
