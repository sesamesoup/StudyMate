//
//  jsonModel.swift
//  StudyMate
//
//  Created by Maddie Adair on 10/24/24.
//


import Foundation

var years = ["Freshman", "Sophomore", "Junior", "Senior", "Graduate Student", "Other"]


var majors: [String] = load("majors.json")

struct PrevPost: Codable, Identifiable {
    var id = UUID()
    var title, description, datetime, subject: String
    var image: [URL]
    
    var formattedDT: String {
        let inputFormatter = ISO8601DateFormatter()
        inputFormatter.formatOptions = [
          .withFractionalSeconds,
          .withFullDate
        ]
        let date = inputFormatter.date(from: datetime)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM dd, YYYY"
        
        return dateFormatter.string(from: date!)
    }
    
    
    enum CodingKeys: String, CodingKey {
        case title, description, datetime, subject, image
    }
}

var prevPosts: [PrevPost] = load("prevPosts.json")


//var postArr: [Post] = load("posts.json")

func load<T: Decodable>(_ filename: String) -> T {
    let data: Data
    
    
    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
    else {
        fatalError("Couldn't find \(filename) in main bundle.")
    }
    
    
    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
    }
    
    
    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
}
