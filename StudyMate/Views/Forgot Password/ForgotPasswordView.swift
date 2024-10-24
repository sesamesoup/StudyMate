//
//  ForgotPasswordView.swift
//  StudyMate
//
//  Created by Maddie Adair on 10/14/24.
//

import SwiftUI

struct ForgotPasswordView: View {
    @State private var email: String = ""
    @Environment(\.dismiss) var dismiss
    @State private var showAlert = false

    var body: some View {
        ZStack {
            Color.lightBlue
                .ignoresSafeArea()
            
            
            VStack(spacing: 40) {
                Spacer()
                Image("collab3")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 175)
                
                Spacer()
                
                VStack(alignment: .leading, spacing: 50) {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Forgot your password?")
                            .font(.custom("InstrumentSerif-Regular", size: 40))
                        
                        Text("No worries! Just enter the email address associated with your account and we’ll send you a link to reset your password.")
                            .fixedSize(horizontal: false, vertical: true)
                    }
                    
                    VStack(spacing: 30) {
                        TextField("Email", text: $email)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(.white)
                            .cornerRadius(16)
                        
                        NavigationLink(destination: ResetPasswordView()) {
                            Text("Submit")
                                .bold()
                                .padding()
                                .frame(maxWidth: .infinity, alignment: .center)
                                .background(.forest)
                                .foregroundStyle(.beige)
                                .cornerRadius(16)
                        }
                        
//                        Button(action: {
//                            if (email == ""){
//                                showAlert = true
//                            }
//                        }) {
//                            Text("Submit")
//                                .bold()
//                                .padding()
//                                .frame(maxWidth: .infinity, alignment: .center)
//                                .background(.forest)
//                                .foregroundStyle(.beige)
//                                .cornerRadius(16)
//                        }
//                        .alert(isPresented: $showAlert) {
//                            Alert(title: Text("Invalid Input"), message: Text("Please enter a valid email."), dismissButton: .default(Text("OK")))
//                        }
                    
                    }
                    
                    Spacer()
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
    ForgotPasswordView()
}
