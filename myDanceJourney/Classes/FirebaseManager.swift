//
//  FirebaseManager.swift
//  myDanceJourney
//
//  Created by Rohan Kumar on 9/6/22.
//

import Foundation
import FirebaseCore
import FirebaseAuth
import FirebaseStorage
import FirebaseFirestore


// Class used for Firebase commands (allows use of realtime preview)
class FirebaseManager : NSObject {
    let auth : Auth
    let storage : Storage
    let firestore : Firestore
    
    static let shared = FirebaseManager()
    
    override init() {
        FirebaseApp.configure()
        
        self.auth = Auth.auth()
        self.storage = Storage.storage()
        self.firestore = Firestore.firestore()
    }
}

// Template Function to update User info
func updateUserInfo<T>(updatedField:String, info:Any, infoType:T.Type) {
    // Gets current User ID
    guard let uid = FirebaseManager.shared.auth.currentUser?.uid else { return }
    if let info = info as? T { // Checks to see if info is of the correct type
        
        let userInfo = [updatedField: info] // Dictionary storing new information
        // Updates userInfo into user's firestore file
        
        FirebaseManager.shared.firestore.collection("users").document(uid).updateData(userInfo) { err in
            if let err = err {
                print(err)
                return
            }
        }
    }
    
}

//func createCircle(circleName: String, profile: ProfileManager) {
//    guard let uid: String = FirebaseManager.shared.auth.currentUser?.uid else { return }
//
//    if profile.circles.contains(circleName) || false { return } // Checks to see if user is already in circle
//
//    // TODO: CHECK TO SEE IF CIRCLENAME ALREADY EXISTS IN DATABASE
//
//    let circleInfo = ["Leaders": [uid]] // Dictionary putting current user as circle Leader
//
//    // Adds circle leader info to firebase
//    FirebaseManager.shared.firestore.collection("circles").document(circleName).setData(circleInfo) { err in
//        if let err = err { print(err) }
//    }
//    // Adds empty array of members to firebase
//    FirebaseManager.shared.firestore.collection("circles").document(circleName).setData(["Members": []]) { err in
//        if let err = err { print(err) }
//    }
//
//    // Appends circleName to user's circles and updates firebase
//    profile.circles.append(circleName)
//    updateUserInfo(updatedField: "Circles", info: profile.circles, infoType: [String].self)
//    profile.getUpdatedUserData()
//}
//
//
//func joinCircle(circleName: String, profile: ProfileManager) {
//    guard let uid: String = FirebaseManager.shared.auth.currentUser?.uid else { return }
//
//    if profile.circles.contains(circleName) || false { return } // Checks to see if user is already in circle (on the user's side)
//
//    // Opens circles collection in firestore
//    FirebaseManager.shared.firestore.collection("circles").document(circleName).getDocument { (snapshot, err) in
//        if let err = err { print(err); return } // Handles error
//
//        guard let data = snapshot?.data() else { return } // Unwraps data
//        var members = data["Members"] as? [String] ?? [] // Gets members array
//        let leaders = data["Leaders"] as? [String] ?? [] // Gets leaders array
//
//        // Adds user to circle if user is not already in circle (checks on the circle's side)
//        if !members.contains(uid) && !leaders.contains(uid) {
//            members.append(uid)
//            FirebaseManager.shared.firestore.collection("circles").document(circleName).updateData(["Members": members])
//            profile.circles.append(circleName)
//            updateUserInfo(updatedField: "Circles", info: profile.circles, infoType: [String].self)
//            profile.getUpdatedUserData()
//        }
//    }
//}
