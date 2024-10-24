//
//  EditProfileView.swift
//  StudyMate
//
//  Created by Maddie Adair on 10/19/24.
//

import SwiftUI

struct EditProfileView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var major: String
    @Binding var year: String
    @Binding var description: String

    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var emailError = ""
    @State private var passwordError = ""
    
    var body: some View {
        ZStack {
            Color.lightBeige
                .ignoresSafeArea()
            
            VStack(spacing: 40) {
//                Text("Edit Profile")
//                    .font(.custom("InstrumentSerif-Regular", size: 48))
//                    .frame(maxWidth: .infinity, alignment: .leading)
//                    .padding(.top, 40)
                
                RoundedRectangle(cornerRadius: 50,
                                 style: .continuous)
                .aspectRatio(1.4, contentMode: .fill)
                .overlay(
                    Image("profile")
                        .resizable()
                        .scaledToFill()
                        .offset(x: -30.0, y: 20.0)
                )
                .frame(width: 150, height: 150, alignment: .leading)
                .clipShape(RoundedRectangle(cornerRadius: 50,
                                            style: .continuous))
                
                VStack(alignment: .center, spacing: 50) {
                    VStack(alignment: .leading, spacing: 14) {
                        
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
                                .stroke(.gray, lineWidth: 1)
                        )
                        
                        
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
                                .stroke(.gray, lineWidth: 1)
                        )
                        
                        
                        Text("Description")
                            .fontWeight(.bold)
                        TextField("Username", text: $description)
                            .frame(maxHeight: 100, alignment: .topLeading)
                            .padding()
                            .cornerRadius(16)
                            .background(.customGrey)
                            .overlay(
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke(.gray, lineWidth: 1)
                            )
                    }
                    
                }
                .frame(maxWidth: .infinity)
                            
                Button(action: {
//                    validateLogin()
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
                    Alert(title: Text("Invalid Input"), message: Text("Please fill out all fields."), dismissButton: .default(Text("OK")))
                }
                
                
                Spacer()
            }
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

#Preview {
    EditProfileView(major: .constant(majors[0]), year: .constant(years[1]), description: .constant("Lorem ipsum dolor sit amet, consectetur adipiscing elit."))
}
