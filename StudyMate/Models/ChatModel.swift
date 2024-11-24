//
//  ChatModel.swift
//  StudyMate
//
//  Created by Maddie Adair on 10/24/24.
//

import Foundation

struct ChatElement: Codable, Identifiable {
    var id = UUID()
    var title, description: String
    var messages: [Message]
    var username, firstName, lastName: String
    var profilePic: URL
    
    var fullName: String {
        return "\(firstName) \(lastName)"
    }
    
    enum CodingKeys: String, CodingKey {
        case title, description, messages, username, firstName, lastName, profilePic
    }
    
}

struct Message: Codable {
    var dateTime: String
    var data: [MessageData]
    
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
    
    var timeString: String {
        let inputFormatter = ISO8601DateFormatter()
        let date = inputFormatter.date(from: dateTime)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm a"

        return dateFormatter.string(from: date!)
    }
}

struct MessageData: Codable, Identifiable {
    var id = UUID()
    var from, message, dateTime: String
    
    var formattedDT: String {
        let inputFormatter = ISO8601DateFormatter()
        inputFormatter.formatOptions = [
          .withFractionalSeconds,
          .withFullDate
        ]
        let date = inputFormatter.date(from: dateTime) ?? Date.now
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM dd, YYYY"

        return dateFormatter.string(from: date)
    }
    
    var timeString: String {
        let inputFormatter = ISO8601DateFormatter()
        let date = inputFormatter.date(from: dateTime) ?? Date.now
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm a"

        return dateFormatter.string(from: date)
    }
    
    enum CodingKeys: String, CodingKey {
        case from, message, dateTime
    }
}


class ChatModel: ObservableObject {
    @Published var chats: [ChatElement] = []
    
    init() {
        loadData()
    }
    
    
    func loadData() {
        guard let url = URL(string: "https://api.npoint.io/76e7bac4013cb9f1d58c") else {
            print("Invalid URL")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Failed to load chats: \(error)")
                return
            }
            
            guard let data = data else {
                print("No data returned from the server")
                return
            }
            
            do {
                let jsonDecoder = JSONDecoder()
                let chatData = try jsonDecoder.decode([ChatElement].self, from: data)
                DispatchQueue.main.async {
                    self.chats = chatData
                }
            } catch {
                print("Failed to decode chats: \(error)")
            }
        }
        
        task.resume()
    }
}

