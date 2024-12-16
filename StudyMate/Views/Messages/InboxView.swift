import SwiftUI
import FirebaseAuth
import FirebaseFirestore
import Firebase

struct InboxView: View {
    // Creating ViewModel
    @ObservedObject private var vm = MainMessageViewModel()
    // Imbox View
    //
    @State var shouldNavigateToChatLogView: Bool = false
    //
    @State var selectedUser: OtherUser?
    //
    @State var showNewMessage: Bool = false
    //
    @State private var searchText = "" // State for the search text
    @State private var filteredMessages: [RecentMessage] = [] // Filtered messages
    
    var body: some View {
        ZStack {
            Color.lightBeige
                .ignoresSafeArea()
            // Main stack
            VStack(alignment: .leading) {
                
                //===============================================
                VStack {
                    HStack {
                        Text("Inbox")
                            .font(.custom("InstrumentSerif-Regular", size: 48))
                        // Chat log here
                        
                        NavigationLink(
                            destination: ChatLogView(chatUser: self.selectedUser ?? OtherUser()),
                            isActive: $shouldNavigateToChatLogView
                        ) {
                            EmptyView() // NavigationLink needs a content closure, even if it's empty
                        }
                        Spacer()
                        Button(action: {
                            showNewMessage.toggle() // Show the new message screen
                        }) {
                       
                            
                            Image(systemName: "bubble.and.pencil")
                                .padding()
                                .frame(maxWidth: 50, alignment: .center)
                                .background(Color.forest) // Ensure `.forest` is a valid color
                                .foregroundColor(Color.beige) // Ensure `.beige` is a valid color
                                .cornerRadius(16)
                            
                        }
                        //
                        .fullScreenCover(isPresented: $showNewMessage) {
                            CreateNewMessageView(didSelectNewUser: { user in
                                print("didSelectNewUser: \(user.email)")
                                self.selectedUser = user
                                self.shouldNavigateToChatLogView = true // Trigger NavigationLink

                            })
                        }
                        .onAppear() {
                            self.searchText = "" // Ensure searchText is cleared when the cover disappears
                        }
                        
                        
                        
                    }
                    TextField("Search by username", text: $searchText)
                        .onChange(of: searchText) { newValue in
                            filterMessages()
                        }
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
                //===============================================
                Spacer()
                    .frame(height: 50)

                //
                if (!vm.recentMessages.isEmpty){
                    ScrollView() {
                        VStack {
                            if filteredMessages.isEmpty {
                                Text("No user with name \(searchText) exists.")
                            }
                            else{
                                
                                
                                ForEach(filteredMessages) { recentMessage in
                                    Button(action: {
                                        fetchUserAndNavigate(username: recentMessage.username)
                                       
                                    }) {
                                        VStack {
                                            HStack {
                                                HStack(spacing: 14) {
                                                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                                                        .aspectRatio(1.2, contentMode: .fill)
                                                    
                                                        .overlay(
                                                            Image(recentMessage.profileImage)
                                                                .resizable()
                                                                .scaledToFill()
                                                                .offset(x: -4.0, y: 0.0)
                                                        )
                                                        .frame(width: 40, height: 40, alignment: .leading)
                                                        .clipShape(RoundedRectangle(cornerRadius: 10,
                                                                                    style: .continuous))
                                                    // Username
                                                    VStack(alignment: .leading, spacing: 6) {
                                                        Text("\(recentMessage.username)")
                                                            .foregroundStyle(.black)
                                                            .font(.system(size: 14, weight: .semibold))
                                                            .frame(maxWidth: 130, alignment: .leading)
                                                            .lineLimit(1)
                                                            .truncationMode(.tail)
                                                        // Last chat message
                                                        Text("\(recentMessage.text)")
                                                            .font(.system(size: 12))
                                                            .foregroundStyle(.black)
                                                            .frame(maxWidth: 130, alignment: .leading)
                                                            .lineLimit(1)
                                                            .truncationMode(.tail)
                                                    }
                                                    
                                                    
                                                }
                                                .frame(maxWidth: .infinity, alignment: .leading)
                                                
                                                Spacer()
                                                
                                                // Timestamp
                                                Text(timeAgoSince(recentMessage.timestamp))
                                                    .frame(alignment: .trailing)
                                                    .foregroundStyle(.black)
                                                    .font(.system(size: 12))
                                                
                                            }
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                            .padding()
                                            .background(.multiplyBeige)
                                            .cornerRadius(16)
                                        }
                                    }
                                    
                                }
                                
                            }
                            
                        }
                        
                        // Modify the NavigationLink inside the ForEach
                    }

                    .scrollIndicators(.hidden)
                }
                // --------------------- If no chat found ----------------------------
                else {
                    Text("Start a new message by clicking on the plus icon!")
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                
                Spacer()
                
            }
            .padding(30)
            
        }
        .onAppear {
            Task {
                
                filterMessages() // Initial filter
            }
        }
    }
    //========================================================================
    private func filterMessages() {
        if searchText.isEmpty {
            filteredMessages = vm.recentMessages
        } else {
            filteredMessages = vm.recentMessages.filter { $0.username.lowercased().contains(searchText.lowercased()) }
        }
    }
    //
    private func fetchUserAndNavigate(username: String) {
        fetchUserByUsername(username: username) { user in
            guard let user = user else {
                print("No user found with username: \(username)")
                return
            }
            DispatchQueue.main.async {
                self.selectedUser = user
                self.shouldNavigateToChatLogView = true
                
            }
        }
    }
    
    //
    func fetchUserByUsername(username: String, completion: @escaping (OtherUser?) -> Void) {
        Firestore.firestore().collection("users")
            .whereField("username", isEqualTo: username)
            .getDocuments(source: .default){ querySnapshot, error in
                if let error = error {
                    print("Error fetching user by username: \(error.localizedDescription)")
                    completion(nil)
                    return
                }
                
                guard let documents = querySnapshot?.documents, let document = documents.first else {
                    print("No user found with username: \(username)")
                    completion(nil)
                    return
                }
                
                let data = document.data()
                let userID = document.documentID
                
                // Break down the initialization into smaller steps
                let email = data["email"] as? String ?? ""
                let firstName = data["firstName"] as? String ?? ""
                let lastName = data["lastName"] as? String ?? ""
                let major = data["major"] as? String ?? ""
                let year = data["year"] as? String ?? ""
                let profilePicture = data["profilePicture"] as? String ?? ""
                let username = data["username"] as? String ?? ""
                
                // Create the user object
                let user = OtherUser(
                    uid: userID,
                    email: email,
                    firstName: firstName,
                    lastName: lastName,
                    major: major,
                    year: year,
                    profilePicture: profilePicture,
                    username: username
                )
                
                completion(user)
            }
    }
    
    //
    func timeAgoSince(_ timestamp: Timestamp) -> String {
        let date = timestamp.dateValue() // Convert Timestamp to Date
        let now = Date()
        let calendar = Calendar.current
        
        let components = calendar.dateComponents([.minute, .hour, .day], from: date, to: now)
        
        if let day = components.day, day > 0 {
            return day == 1 ? "1 day ago" : "\(day) days ago"
        } else if let hour = components.hour, hour > 0 {
            return hour == 1 ? "1 hour ago" : "\(hour) hours ago"
        } else if let minute = components.minute, minute > 0 {
            return minute == 1 ? "1 minute ago" : "\(minute) minutes ago"
        } else {
            return "Just now"
        }
    }
}

// ==============================================================



//#Preview {
//    InboxView()
//}
