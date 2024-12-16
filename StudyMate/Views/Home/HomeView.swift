//
//  HomeView.swift
//  StudyMate
//
//  Created by Maddie Adair on 10/20/24.
//

import SwiftUI
import FirebaseAuth

struct HomeView: View {
    
    //
    @State private var searchText = ""
    @State private var majorSelection: String?
    @State private var showSheet = false
    //
    @State private var allPosts: [AllUserPosts] = []
    // for alert
    @State private var showFilterAlert = false
    @State private var alertMessage = ""
    
    
    //    @State private var filteredResults = postArr
    @State private var filteredResults: [AllUserPosts] = []
    @StateObject private var viewModel = ProfileViewModel()

    var body: some View {
        
        ZStack {
            Color.lightBeige
                .ignoresSafeArea()
            VStack(alignment: .leading, spacing: 32) {
                
                // Explore title------------------------
                HStack {
                    Text("Hey, \(viewModel.userProfile?.firstName ?? "FirstName")")
                        .font(.custom("InstrumentSerif-Regular", size: 48))
                    
                    Spacer()
                    
                    // Filter Sheet ------------------------
                    Button(action: {
                        showSheet = true
                    }) {
                        Image(systemName: "slider.horizontal.3")
                            .padding()
                            .frame(maxWidth: 50, alignment: .center)
                            .background(Color.forest) // Ensure `.forest` is a valid color
                            .foregroundColor(Color.beige) // Ensure `.beige` is a valid color
                            .cornerRadius(16)
                            
                    }
                }
                //  filtered Results------------------------
                ScrollView {
                    VStack {
                        ForEach(filteredResults) { post in
                            PostRow(post: post)
                        }
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                //Spacer()
                
            }
            .padding(30)
            .navigationBarBackButtonHidden(true)
            
            // ------------------------- Search Sheet -------------------------
            .sheet(isPresented: $showSheet) {
                VStack(spacing: 40) {
                    Spacer()
                    VStack( alignment: .leading, spacing: 40) {
                        VStack(alignment: .leading, spacing: 20) {
                            Text("Search")
                                .fontWeight(.semibold)
                            
                            TextField("Search posts by title", text: $searchText, prompt: Text("\(Image(systemName: "magnifyingglass")) Search"))
                                .accentColor(.forest)
                                .padding()
                                .background(.white)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .cornerRadius(16)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 16)
                                        .stroke(Color.forest)
                                )
                        }
                        
                        VStack(alignment: .leading, spacing: 20) {
                            Text("Subject")
                                .fontWeight(.semibold)
                            
                            Picker("Select Subject", selection: $majorSelection)
                            {
                                Text("Please Select One").tag(String?.none)
                                
                                ForEach(majors, id: \.self) {
                                    Text($0).tag($0)
                                }
                            }
                            .pickerStyle(.menu)
                            .accentColor(.forest)
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(.white)
                            .cornerRadius(16)
                            .overlay(
                                RoundedRectangle(cornerRadius: 16)
                                    .strokeBorder(Color.forest)
                            )
                        }
                        
                    }
                    
                    // Filter settings
                    HStack(spacing: 20) {
                        
                        // Reset filter
                        Button(action: {
                            resetFilter()
                        }) {
                            Text("Reset")
                                .bold()
                                .padding()
                                .frame(maxWidth: .infinity, alignment: .center)
                                .foregroundStyle(.forest)
                                .cornerRadius(16)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 16)
                                        .strokeBorder(.forest, lineWidth: 1)
                                )
                        }
                        
                        // Apply filter
                        Button(action: {
                            print("calling search results")
                            searchResults()
                            showSheet = false
                        }) {
                            Text("Apply")
                                .bold()
                                .padding()
                                .frame(maxWidth: .infinity, alignment: .center)
                                .background(.forest)
                                .foregroundStyle(.beige)
                                .cornerRadius(16)
                        }
                    }
                }
                
                
                .padding()
                .presentationBackground(.lightBeige)
                //                            .interactiveDismissDisabled()
                .presentationDetents([.fraction(0.50)])
                .presentationCornerRadius(30)
                
            }
            
            // ------------- Search Sheet end --------------------------------
        }
        .alert(isPresented: $showFilterAlert) {
            Alert(
                title: Text("No Results Found"),
                message: Text(alertMessage),
                dismissButton: .default(Text("Reset filter"), action: {
                    resetFilter()
                    showFilterAlert = false
                })
            )
        }
        .onAppear {
            Task {
                if let userID = Auth.auth().currentUser?.uid {
                    await viewModel.fetchUserProfile(userID: userID)
                    print(viewModel.userProfile as Any)
                }
            }
            loadPostsForOtherUsers { posts in
                let sortedPosts = posts.sorted {
                    $0.createdAt.dateValue() > $1.createdAt.dateValue()
                }
                self.allPosts = sortedPosts
                print(posts)
                self.filteredResults = sortedPosts
            }
        }
        
        
        
        
        
    }
    //
    
    // ------------- Function for Search -------------------------------------
    
    func searchResults() {
        // Reset filtered results to allPosts
        var results = allPosts
        
        // Filter by searchText (matches title or description)
        if !searchText.isEmpty {
            results = results.filter { post in
                post.title.lowercased().contains(searchText.lowercased()) ||
                post.description.lowercased().contains(searchText.lowercased())
            }
        }
        
        // Filter by majorSelection (subject)
        if let selectedMajor = majorSelection, !selectedMajor.isEmpty {
            results = results.filter { post in
                post.subject == selectedMajor
            }
        }
        
        // Check if filtered results are empty
        if results.isEmpty {
            showSheet = false
            print("Result is empty")
            alertMessage = "No posts match your filters. Try adjusting your search."
            DispatchQueue.main.async {
                self.showFilterAlert = true // Present the alert after the sheet is dismissed
            }
        } else {
//            showFilterAlert = false
            filteredResults = results
            showSheet = false // Dismiss the filter sheet
        }
    }
    
    // Reset
    func resetFilter() {
        filteredResults = self.allPosts
        searchText = ""
        majorSelection = nil
        showSheet = false
    }
    
}
