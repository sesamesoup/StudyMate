//
//  SignUpModel.swift
//  StudyMate
//
//  Created by Sarang Mistry on 12/3/24.
//

import Foundation
// Screen 1
struct Personal {
    var firstName: String = ""
    var lastName: String = ""
}

// Screen 2
struct Credentials {
    var username: String = ""
    var email: String = ""
    var password: String = ""
    var confirmPassword: String = ""
}

// Screen 3
struct ProfileIcon {
    var profilePicString: String = ""
}

// Screen 4
struct Academic {
    var major: String = majors[0]
    var year: String = "Sophomore"
}

// togther
struct NewUserData {
    var personal: Personal = Personal()
    var credentials: Credentials = Credentials()
    var academic: Academic = Academic()
    var pfp: ProfileIcon = ProfileIcon()
}

enum Steps {
    case personal
    case login
    case academic
    case pfp
    
    var title: String {
        switch self {
        case .personal: return "Personal"
        case .login: return "Login"
        case .academic: return "Academic"
        case .pfp: return "Profile Picture"
        }
    }
    
    var next: Steps? {
        switch self {
        case .personal: return .login
        case .login: return .pfp
        case .pfp: return .academic
        case .academic: return nil
        }
    }
    
    var previous: Steps? {
        switch self {
        case .personal: return nil
        case .login: return .personal
        case .pfp: return .login
        case .academic: return .pfp
        }
    }
}
