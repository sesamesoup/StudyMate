//
//  MainMessageViewModel.swift
//  StudyMate
//
//  Created by Sarang Mistry on 11/24/24.
//
import SwiftUI
import FirebaseAuth
import FirebaseFirestore
import Firebase

//
// Recent messages
struct RecentMessage : Identifiable{
    var id : String { documentID }
    
    let documentID: String
    let text, fromID, toID, username, profileImage: String
    let timestamp: Timestamp
    
    //
    init(documentID: String, data : [String: Any ]){
        self.documentID = documentID
        self.text = data["text"] as? String ?? ""
        self.fromID = data["fromID"] as? String ?? ""
        self.toID = data["toID"] as? String ?? ""
        self.username = data["username"] as? String ?? ""
        self.profileImage = data["profileImage"] as? String ?? ""
        self.timestamp = data["timestamp"] as? Timestamp ?? Timestamp()
    }
}

struct ChatUser{
    let uid, email, firstName, lastName, major, year,profilePicture: String
}


class MainMessageViewModel: ObservableObject {
    @Published var errorMessage: String = ""
    @Published var chatUser: ChatUser?
    //
    @Published var recentMessages: [RecentMessage] = []
    //
    init(){
        // fetch the current user
        fetchCurrentUser()
        //
        fetchRecentMessages()
    }
    private func fetchRecentMessages(){
        guard let uid = Auth.auth().currentUser?.uid else {
            print( "Unable to fetch current user")
            return
        }
        //
        Firestore.firestore().collection("recent_messages")
            .document(uid)
            .collection("messages")
            .order(by: "timestamp")
            .addSnapshotListener { querySnapshot, error in
                if let error = error {
                    print("Fail fetching recent messages: \(error)")
                    return
                }
                //
                querySnapshot?.documentChanges.forEach { change in
//                    if change.type == .added {
                        // fetching recent
                    let docID = change.document.documentID

                    if let index = self.recentMessages.firstIndex(where: { rm in
                        return rm.documentID == docID
                    }){
                        self.recentMessages.remove(at: index)
                    }
                    //
                    self.recentMessages.insert(.init(documentID: docID, data: change.document.data()),at:0)

                }
            }
        
    }
    //
    func fetchCurrentUser(){
        guard let userId = Auth.auth().currentUser?.uid else {
            print("Unable to fetch current user")
            return
        }
        // Getting the current user
        Firestore.firestore().collection("users").document(userId).getDocument { (snapshot, error) in
            if let error = error  {
                print("Error fetching current user: \(error)")
                return
            }
            guard let data = snapshot?.data() else {
                print("No data found")
                return
            }
            print(data)
            //
            self.chatUser = ChatUser(uid: userId, email: data["email"] as? String ?? "", firstName: data["firstName"] as? String ?? "", lastName: data["lastName"] as? String ?? "", major: data["major"] as? String ?? "", year: data["year"] as? String ?? "", profilePicture: data["profilePicture"] as? String ?? "")
        }
    }
    
    
}
