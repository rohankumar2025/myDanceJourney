//
//  Login.swift
//  myDanceJourney
//
//  Created by Rohan Kumar on 9/6/22.
//

import SwiftUI

struct Login: View {
    @EnvironmentObject var profile: ProfileManager
    @State private var email: String = ""
    @State private var password: String = ""
    
    @State private var feedbackText: String = ""
    @State private var isLoading = false
    
    var body: some View {
        VStack {
            Text("Log in")
                .font(.system(size: 50, weight: .bold))
            
            TextField("Email", text: self.$email)
                .padding()
            
            SecureField("Password", text: self.$password)
                .padding()
            
            
            Button("Log in") {
                logInExistingAccount()
            }
            .padding()
            .foregroundColor(.white)
            .background(.orange)
            .cornerRadius(10)
            
            Text(self.feedbackText)
        }
    }
    
    
    // Function to login user
    func logInExistingAccount() {
        self.isLoading = true // Indicates that Firebase call is loading

        // Firebase call to authenticate existing user
        FirebaseManager.shared.auth.signIn(withEmail: self.email, password: self.password) {
            result, error in
            if let err = error { // Error Message
                self.feedbackText = convertErrorMessage(err as NSError)
                self.isLoading = false
                return
            }

            // Login was successful if it reached this line of code
            self.feedbackText = ""

            profile.getUpdatedUserData() // Updates User Data
            profile.isLoggedIn = true // Indicates that user is logged in, Switches to ContentView()

            self.isLoading = false // Indicates that Firebase call has finished

        }
    }
}

struct Login_Previews: PreviewProvider {
    static var previews: some View {
        Login()
            .environmentObject(ProfileManager())
    }
}
