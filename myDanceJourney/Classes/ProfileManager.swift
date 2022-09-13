//
//  ProfileManager.swift
//  myDanceJourney
//
//  Created by Rohan Kumar on 9/6/22.
//

import Foundation
import SwiftUI

class ProfileManager: ObservableObject {
    // State info
    @Published var isLoggedIn: Bool = false
    
    // Profile info
    @Published var username: String = "Username"
    @Published var profilePicURL: String = ""
    @Published var bio: String = "This is my bio."
    
    // Circles info
    @Published var circles: [String] = []
    
    
    
    init() {
        // Initializes isLoggedIn
        if FirebaseManager.shared.auth.currentUser?.uid != "" {
            getUpdatedUserData()
        }
        else { isLoggedIn = false }
    }
    
    func getUpdatedUserData() {
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else { return }
        FirebaseManager.shared.firestore.collection("users")
            .document(uid).getDocument{ snapshot, err in
                if let err = err {
                    print("Failed to fetch current user:", err)
                    return
                }
                guard let data = snapshot?.data() else { return }
                
                // Profile info
                self.username = data["Username"] as? String ?? ""
                self.profilePicURL = data["ProfilePicURL"] as? String ?? ""
                self.bio = data["Bio"] as? String ?? "This is my bio."
                
                // Circles info
                self.circles = data["Circles"] as? [String] ?? []
                
                
                // Tells app that user is logged in
                self.isLoggedIn = true
                
                
            }
    }
}
