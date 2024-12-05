//
//  ChatLogViewModel.swift
//  StudyMate
//
//  Created by Sarang Mistry on 10/24/24.
//
import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseFirestore

//
struct ChatMessages: Identifiable{
    var id: String { documentID }
    
    let fromID, toID, text : String
    let documentID : String
    init(documentID: String,data:[String: Any]){
        self.fromID = data["fromID"] as? String ?? ""
        self.toID = data["toID"] as? String ?? ""
        self.text = data["text"] as? String ?? ""
        self.documentID = documentID
    }
}

//
class ChatLogViewModel: ObservableObject{
    @Published var chatText = ""
    @Published var errorMessage = ""
    @Published var chatMessages = [ChatMessages] ()
    //
    @Published var count = 0
    //
    let recieverUser : OtherUser?
    //--------------------------------------------------
    // init
    init(recieverUser: OtherUser?){
        self.recieverUser = recieverUser
        fetchMessages()
    }
    //--------------------------------------------------
    func fetchMessages(){
        //
        guard let fromID = Auth.auth().currentUser?.uid else {
            //
            print("Error getting current user")
            return
        }
        //
        guard let toID = self.recieverUser?.uid, !toID.isEmpty else {
            print("Error: To ID is nil or empty.")
            return
        }
        print("FromID: \(fromID)")
        print("ToID: \(toID)")
        //
        Firestore.firestore().collection("messages")
            .document(fromID).collection(toID)
            .order(by: "timestamp")
            .addSnapshotListener { querySnapshot, error in
                if let error {
                    //
                    print("fail to listen to messages")
                    
                    print("Error getting messages \(error)")
                    return
                }
                //
                querySnapshot?.documentChanges.forEach({documentChange in
                    if documentChange.type == .added{
                        let data = documentChange.document.data()
                        self.chatMessages.append(ChatMessages(documentID: documentChange.document.documentID, data: data))
                        
                    }
                })
                
                DispatchQueue.main.async {
                    self.count+=1
                }
                
            }
        //
        
        
    }
    
    //
    func handelSendMessage(){
        print("IN function Send message")
        print("Chat Text \(self.chatText)")
        //
        guard let fromID = Auth.auth().currentUser?.uid else {
            //
            print("Error getting current user")
            return
        }
        guard let toID = self.recieverUser?.uid else {
            print("Error getting reciever user")
            return
        }
        let db = Firestore.firestore()
        // Storing into FROM
        let chatRef = db.collection("messages")
            .document(fromID)
            .collection(toID)
            .document()
        //
        let messageData = ["fromID":fromID,"toID":toID,"text":self.chatText,"timestamp":Timestamp()] as [String : Any]
        //
        chatRef.setData(messageData){ error in
            if let error {
                print("Error storing message \(error)")
                self.errorMessage = "Error storing message \(error)"
                return
            }
            
        }
        self.prsistRecentMessage()
        //
        print("Able to save mess in FromID")
        self.chatText = ""
        self.count+=1
        
        //
        let recipientChatRef = db.collection("messages")
            .document(toID)
            .collection(fromID)
            .document()
        //
        recipientChatRef.setData(messageData){ error in
            if let error {
                print("Error storing message \(error)")
                self.errorMessage = "Error storing message \(error)"
                return
            }
            
        }
        print("Able to save mess for reciever")
        print("Successfully SAVED message")
        
    }
    
    //
    func prsistRecentMessage(){
        // copy text
        let copyText = self.chatText
        guard let fromID = Auth.auth().currentUser?.uid else { return }
        //
        guard let toID = self.recieverUser?.uid, !toID.isEmpty else {
            print("Error: To ID is nil or empty.")
            return
        }
        //
        let document = Firestore.firestore().collection("recent_messages")
            .document(fromID)
            .collection("messages")
            .document(toID)
        print("In presistent Chat text is\(self.chatText)")
        //
        let data = [
            "timestamp" : Timestamp(),
            "text" : self.chatText,
            "fromID":fromID,
            "toID": toID,
            "profileImage": self.recieverUser?.profilePicture ?? "",
            "username": self.recieverUser?.username ?? ""
        ] as [String : Any]
        //
        // Need to do something similar tanother dictionar for hte recipient of this message
        //
        document.setData(data) {error in
            if let error {
                print("Error: \(error)")
                return
            }
        }
        //
        let recieverDocument = Firestore.firestore().collection("recent_messages")
            .document(toID)
            .collection("messages")
            .document(fromID)
        print("In presistent Chat text is\(self.chatText)")
        //
        
        //
        fetchUserProfile(userID: fromID) { username, profileImage in
            let recieverData = [
                "timestamp": Timestamp(),
                "text": copyText,
                "fromID": fromID,
                "toID": toID,
                "profileImage": profileImage,
                "username": username
            ] as [String: Any]
            //
            print("Adding to reciever")
            recieverDocument.setData(recieverData) { error in
                if let error {
                    print("Error: \(error)")
                    return
                }
            }
            print("Function end pristent")
        }

    }
    //========================================

    //
    func fetchUserProfile(userID: String, completion: @escaping (String, String) -> Void) {
        Firestore.firestore().collection("users").document(userID).getDocument { documentSnapshot, error in
            if let error = error {
                print("Failed to fetch user profile: \(error.localizedDescription)")
                completion("Unknown", "")
                return
            }
            
            guard let data = documentSnapshot?.data() else {
                print("No data found for userID: \(userID)")
                completion("Unknown", "")
                return
            }
            
            let username = data["username"] as? String ?? "Unknown"
            let profilePicture = data["profilePicture"] as? String ?? ""
            
            completion(username, profilePicture)
        }
    }

}

