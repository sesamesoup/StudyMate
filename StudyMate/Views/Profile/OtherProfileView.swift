//
//  OtherProfileView.swift
//  StudyMate
//
//  Created by Maddie Adair on 10/19/24.
//

import SwiftUI

struct OtherProfileView: View {
    
    var fullName: String
    var username: String
    var major: String
    var year: String
    var description: String
    var profilePic: URL
    
    @State private var showingAlert = false
    @Environment(\.dismiss) var dismiss

    var body: some View {
        ZStack {
            Color.lightBeige
                .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 30) {
                    RoundedRectangle(cornerRadius: 80,
                                     style: .continuous)
                    .aspectRatio(1.35, contentMode: .fill)
                    .overlay(
                        AsyncImage(url: profilePic) { image in
                            image
                                .resizable()
                                .scaledToFill()
                                .offset(x: -52.0, y: 20.0)
                            
                        } placeholder: {
                            ProgressView()
                        }
                    )
                    .frame(width: 350, height: 350, alignment: .leading)
                    .clipShape(RoundedRectangle(cornerRadius: 80,
                                                style: .continuous))
                    .padding(.top, 40)
                    
                    VStack(spacing: 20) {
                        VStack {
                            Text(fullName)
                                .font(.custom("InstrumentSerif-Regular", size: 40))

//                                .font(.system(size: 40, weight: .semibold))
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            Text("@\(username)")
                                .font(.system(size: 20, weight: .semibold))
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        
                        VStack(alignment: .leading, spacing: 30) {
                            Text("\(year) - \(major)")
                                .fontWeight(.medium)
                            
                            Text(description)
                                .fontWeight(.medium)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
                    }
                    
                    
                }
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
                            
                            Text("Back")
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
    OtherProfileView(fullName: "John Doe", username: "johndoe", major: "Electrical Engineering", year: "Junior", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.", profilePic: URL(string: "https://avatar.iran.liara.run/public/3")!)
}
