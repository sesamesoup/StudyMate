//
//  HomeView.swift
//  StudyMate
//
//  Created by Maddie Adair on 10/19/24.
//

import SwiftUI

struct HomeView: View {
    @State var shouldPresentSheet = false
    @StateObject private var viewModel = PostViewModel()

    var body: some View {
        ZStack {
            Color.lightBeige
                .ignoresSafeArea()
            NavigationStack {
                VStack {
                    Button(action: {
                        shouldPresentSheet.toggle()
                    }) {
                        NavigationLink(destination: AddPostView().toolbar(.hidden, for: .tabBar)) {
                            
                            HStack(spacing: 12) {
                                Text("New Post")
                                    .bold()
                                
                                Image(systemName: "pencil")
                                    .resizable()
                                    .scaledToFit()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 15, height: 15)
                            }
                        }
                        .padding()
                        .background(.forest)
                        .clipShape(.capsule)
                        .foregroundStyle(.beige)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        
                    }
                    
                    
                    HStack {
                        Text("Hi, ")
                            .font(.custom("InstrumentSerif-Regular", size: 48))
                        Text("Jane")
                            .font(.custom("InstrumentSerif-Italic", size: 48))
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Spacer()
                        .frame(height: 50)
                    
                    VStack(spacing: 10) {
                        HStack {
                            HStack() {
                                VStack(alignment: .leading) {
                                    Text("6")
                                        .font(.system(size: 26, weight: .bold))
                                    
                                    Text("new posts in the last hour")
                                }
                                
                                Image(systemName: "staroflife.fill")
                                    .padding(6)
                                    .foregroundStyle(.black)
                                    .background(.blendMode(.multiply).opacity(0.2))
                                    .clipShape(Capsule())
                                    .offset(y: 60.0)
                                
                            }
                            .padding()
                            .frame(maxWidth: .infinity, maxHeight: 140, alignment: .topLeading)
                            .fixedSize(horizontal: false, vertical: false)
                            .background(.lightBlue)
                            .cornerRadius(16)
                            
                            // 110
                            
                            HStack() {
                                VStack(alignment: .leading) {
                                    Text("4")
                                        .font(.system(size: 26, weight: .bold))
                                    
                                    Text("day streak")
                                }
                                Image(systemName: "flame.fill")
                                    .padding(6)
                                    .foregroundStyle(.black)
                                    .background(.blendMode(.multiply).opacity(0.2))
                                    .clipShape(Capsule())
                                    .offset(x: 20, y: 70.0)
                                
                            }
                            .padding()
                            .frame(maxWidth: .infinity, maxHeight: 140, alignment: .topLeading)
                            .fixedSize(horizontal: false, vertical: false)
                            
                            .background(.lightGreen)
                            .cornerRadius(16)
                        }
                        .frame(maxWidth: .infinity)
                        
                    }
                    .frame(maxWidth: .infinity)
                    
                    Spacer()
                        .frame(height: 50)
                    
                    VStack(spacing: 25) {
                        HStack {
                            Text("Recent Posts")
                                .font(.system(size: 24, weight: .medium))
                            Spacer()
                            NavigationLink(destination: MorePostsView().toolbar(.hidden, for: .tabBar)) {
                                HStack {
                                    Text("View More")
                                        .foregroundStyle(.black)
                                        .font(.system(size: 14, weight: .medium))
                                    Image(systemName: "arrow.right")
                                        .resizable()
                                        .scaledToFit()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 10, height: 10)
                                        .foregroundStyle(.black)
                                }
                            }
                        }
                        
                        VStack {
                            ForEach(viewModel.posts.prefix(3), id: \.id) { post in
                                PostRow(post: post)
                            }
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    
                    
                    Spacer()
                    
                }
                .padding(30)
            }
        }
    }
}

#Preview {
    HomeView()
}
