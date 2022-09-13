//
//  SignUp.swift
//  myDanceJourney
//
//  Created by Rohan Kumar on 9/6/22.
//

import SwiftUI

struct SignUp: View {
    @EnvironmentObject var profile: ProfileManager
    @State private var email: String = ""
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var reEnteredPassword: String = ""
    
    @State private var feedbackText: String = ""
    @State private var isLoading = false
    
    var body: some View {
        VStack {
            Text("Sign up")
                .font(.system(size: 50, weight: .bold))
            
            TextField("Email", text: self.$email)
                .padding()
            
            TextField("Username", text: self.$username)
                .padding()
            
            SecureField("Password", text: self.$password)
                .padding()
            
            SecureField("Re-enter password", text: self.$reEnteredPassword)
                .padding()
            
            
            Button("Sign up") {
                createNewAccount()
            }
            .padding()
            .foregroundColor(.white)
            .background(.orange)
            .cornerRadius(10)
            
            Text(self.feedbackText)
        }
    }
    
    // Function called when Create Account Button is Pressed
    func createNewAccount() {
        // Does not authenticate user unless both passwords match
        if self.password != self.reEnteredPassword {
            self.feedbackText = "Passwords do not match"
            return
            
        }
        
        self.isLoading = true // Indicates that Firebase call is loading
        
        // Firebase call to authenticate new user
        FirebaseManager.shared.auth.createUser(withEmail: self.email, password: self.password) {
            result, error in
            if let err = error { // Error Message
                self.feedbackText = convertErrorMessage(err as NSError)
                self.isLoading = false
                return
            }

            // Create Account was successful if it reached this line of code
            self.feedbackText = ""
            guard let uid = FirebaseManager.shared.auth.currentUser?.uid else { return } // Gets current User ID

            // TODO: Update Initial userData by adding more fields as more components are added
            let userInfo:Dictionary<String, Any> = [
                "Username": self.username,
                "UID": uid,
                "ProfilePicURL": "",
                "Bio": ""
            ]
            // Stores userInfo into user's firestore file
            FirebaseManager.shared.firestore.collection("users").document(uid).setData(userInfo) { err in
                    if let err = err {
                        print(err)
                        return
                    }
                }

            profile.getUpdatedUserData() // Updates user Data
            profile.isLoggedIn = true // Indicates that user is logged in, Switches to ContentView()
            self.isLoading = false // Indicates that Firebase call has finished
        
        }
        
    }
    
    
}

struct SignUp_Previews: PreviewProvider {
    static var previews: some View {
        SignUp()
    }
}
