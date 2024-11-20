//
//  MorePostsView.swift
//  StudyMate
//
//  Created by Maddie Adair on 10/20/24.
//

import SwiftUI

struct MorePostsView: View {
    @State var shouldPresentSheet = false
//    @State private var filteredResults = PostViewModel().posts
//    @StateObject private var viewModel = PostViewModel()
    @State private var searchText = ""
    @State private var majorSelection: String?
    @State private var showSheet = false
    
    @Environment(\.dismiss) var dismiss
    
    @State private var filteredResults = postArr

    
    var body: some View {
        
        ZStack {
            Color.lightBeige
                .ignoresSafeArea()
            VStack(alignment: .leading, spacing: 40) {
                VStack(alignment: .leading, spacing: 12) {
                    Text("Explore")
                        .font(.custom("InstrumentSerif-Regular", size: 48))
                    
                    
                    Text("Find more posts by filtering by subject and post title.")
                    
                }
                
                Button(action: {
                    showSheet = true
                }) {
                    Text("Filter \(Image(systemName: "line.3.horizontal.decrease.circle.fill"))")
                        .bold()
                        .padding(8)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .background(.forest)
                        .foregroundStyle(.beige)
                        .cornerRadius(12)
                }
                
                //                    VStack(alignment: .leading, spacing: 20) {
                //                        Text("Subject")
                //
                //                        Picker("Select Major", selection: $majorSelection)
                //                        {
                //                            Text("Please Select One").tag(String?.none)
                //
                //                            ForEach(majors, id: \.self) {
                //                                Text($0).tag($0)
                //                            }
                //                        }
                //                        .pickerStyle(.menu)
                //                        .accentColor(.gray)
                //                        .padding()
                //                        .frame(maxWidth: .infinity, alignment: .leading)
                //                        .background(.white)
                //                        .overlay(
                //                            RoundedRectangle(cornerRadius: 16)
                //                                .stroke(Color.gray)
                //                        )
                //                    }
                
                ScrollView {
                    VStack {
                        ForEach(filteredResults) { post in
                            PostRow(post: post)
                        }
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                Spacer()
                
            }
            .padding(30)
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
                    HStack {
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
                        
                        Button(action: {
                            searchResults()
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
            .presentationDetents([.fraction(0.55)])
            .presentationCornerRadius(30)
            
        }
        
        
    }
    
    //            .navigationTitle("More Posts")
    //            .navigationBarTitleDisplayMode(.large)
    //            .frame(maxWidth: 350)
    
    
    //        .searchable(text: $searchText)
    
}

func searchResults() {
    if searchText.isEmpty && (majorSelection == nil) {
        showSheet = false
         return
    } else {
        var res: [Post] = postArr
        
        if !searchText.isEmpty {
            res = res.filter { $0.title.lowercased().contains(searchText.lowercased()) }
        }
        if (majorSelection != nil) {
            res = res.filter { $0.subject.contains(majorSelection!) }
        }
        filteredResults = res
        
        showSheet = false
    }
}
    
    func resetFilter() {
        filteredResults = postArr
        searchText = ""
        majorSelection = nil
        showSheet = false
    }

}

//#Preview {
//    MorePostsView()
//}
