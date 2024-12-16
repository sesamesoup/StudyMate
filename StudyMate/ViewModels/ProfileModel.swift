import Foundation
import Firebase
import FirebaseAuth
import FirebaseFirestore
struct UserProfile: Identifiable, Codable {
    var id: String // The user ID (matches the Firestore document ID)
    var email: String
    var firstName: String
    var lastName: String
    var major: String
    var password: String
    var profilePicture: String
    var username: String
    var year: String
}

//
struct UserPost: Identifiable, Codable {
    @DocumentID var id: String? // Automatically maps to Firestore document ID
    var createdAt: Timestamp // Timestamp when the post was created
    var description: String // Description of the post
    var image: String // Array of image URLs
    var subject: String // Subject of the post
    var title: String // Title of the post
}

@MainActor
class ProfileViewModel: ObservableObject {
    @Published var userProfile: UserProfile?
    @Published var userPosts: [UserPost] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    
    // fetching users entire profile
    func fetchUserProfile(userID: String) async {
        isLoading = true
        errorMessage = nil
        
        do {
            let document = try await Firestore.firestore().collection("users").document(userID).getDocument()
            if let data = document.data() {
                self.userProfile = UserProfile(
                    id: userID,
                    email: data["email"] as? String ?? "",
                    firstName: data["firstName"] as? String ?? "",
                    lastName: data["lastName"] as? String ?? "",
                    major: data["major"] as? String ?? "",
                    password: data["password"] as? String ?? "",
                    profilePicture: data["profilePicture"] as? String ?? "",
                    username: data["username"] as? String ?? "",
                    year: data["year"] as? String ?? ""
                )
            } else {
                errorMessage = "No data found for this user."
                print(errorMessage as Any)
            }
        } catch {
            errorMessage = "Failed to fetch profile data: \(error.localizedDescription)"
        }
        
        isLoading = false
    }
    
    func fetchCurrentUserPosts() async {
        guard let currentUserID = Auth.auth().currentUser?.uid else {
            DispatchQueue.main.async {
                self.errorMessage = "No logged-in user."
                self.userPosts = [] // Clear posts if no user is logged in
            }
            return
        }
        
        isLoading = true
        errorMessage = nil
        userPosts = [] // Reset to ensure a clean state before fetching
        
        do {
            let snapshot = try await Firestore.firestore()
                .collection("users")
                .document(currentUserID)
                .collection("posts")
                .getDocuments()
            
            let posts = snapshot.documents.compactMap { document in
                try? document.data(as: UserPost.self) // Automatically maps Firestore document ID
            }
            
            print("Posts fetched: count \(posts.count)")
            
            DispatchQueue.main.async {
                self.userPosts = posts
                if posts.isEmpty {
                    self.errorMessage = "You have not added any posts yet."
                }
            }
        } catch {
            DispatchQueue.main.async {
                self.errorMessage = "Failed to fetch your posts: \(error.localizedDescription)"
                self.userPosts = [] // Clear posts in case of an error
            }
        }
    }

}
