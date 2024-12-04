//
//  SplachScreen.swift
//  StudyMate
//
//  Created by Sarang Mistry on 11/24/24.
//

import SwiftUI
//
struct SplashScreen: View {
    
    @State var isActive : Bool = false
    @State private var size = 0.8
    @State private var opacity = 0.5
    
    var body: some View {
        if isActive {
            ContentView()
        } else {
            ZStack {
                Color.lightBlue
                    .ignoresSafeArea()
                VStack(alignment: .center) {
                    Spacer()
                    
                    VStack(spacing: 40) {
                        Image("SplachScreenImage")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 200)
                        
                        VStack(spacing: 10) {
                            
                            Text("StudyMate")
                                .font(.custom("InstrumentSerif-Regular", size: 60))
                                .foregroundStyle(.forest)
                            
                            Text("Helping UH students study better.")
                                .foregroundStyle(.forest)
                                .font(.system(size: 20))
                                .italic()
                        }
                    }
                    
                    Spacer()
                    
                    
                }
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    withAnimation {
                        self.isActive = true
                    }
                }
            }
        }
    }
}

#Preview {
    SplashScreen()
}
