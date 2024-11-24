//
//  PostModel.swift
//  StudyMate
//
//  Created by Maddie Adair on 10/20/24.
//

import Foundation

struct Post: Codable, Identifiable {
    var id = UUID()
    var title, description, dateTime, username: String
    var subject, firstName, lastName: String
    var image: [URL]
    var profilePic: URL
    
    var formattedDT: String {
        let inputFormatter = ISO8601DateFormatter()
        inputFormatter.formatOptions = [
          .withFractionalSeconds,
          .withFullDate
        ]
        let date = inputFormatter.date(from: dateTime)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM dd, YYYY"
        
        return dateFormatter.string(from: date!)
    }
    
    var fullName: String {
            return "\(firstName) \(lastName)"
        }
    
    enum CodingKeys: String, CodingKey {
        case title, description, dateTime, username, subject, firstName, lastName, image, profilePic
    }
}

class PostViewModel: ObservableObject {
    @Published var posts: [Post] = []
    @Published var suggestedPosts: [Post] = []

    init() {
        loadData()
    }
    
    
    func loadData() {
        guard let url = URL(string: "https://api.npoint.io/a368926a47985ca0e6ee") else {
            print("Invalid URL")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Failed to load posts: \(error)")
                return
            }
            
            guard let data = data else {
                print("No data returned from the server")
                return
            }
            
            do {
                let jsonDecoder = JSONDecoder()
                let postData = try jsonDecoder.decode([Post].self, from: data)
                DispatchQueue.main.async {
                    self.posts = postData
                    self.suggestedPosts = postData
                }
            } catch {
                print("Failed to decode posts: \(error)")
            }
        }
        
        task.resume()
    }
}

