//
//  Profile.swift
//  myDanceJourney
//
//  Created by Rohan Kumar on 9/6/22.
//

import SwiftUI
import SDWebImageSwiftUI

struct Profile: View {
    @EnvironmentObject var profile: ProfileManager
    
    @State private var showImagePicker = false
    @State private var profilePic: UIImage?
    
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            
            VStack {
                Header()
                
                // Profile pic button
                ProfilePic(profilePic: self.$profilePic)
                    .onTapGesture { self.showImagePicker = true }
                
                Text(profile.username)
                    .font(.system(size: screenWidth * 0.05))
                
                Text(profile.bio)
                    .font(.system(size: screenWidth * 0.03, weight: .thin))
                    .frame(width: screenWidth * 0.8)
                
                
                Spacer()
            }
        }
        .fullScreenCover(
            isPresented: self.$showImagePicker,
            onDismiss: {
                storeProfilePic(self.profilePic) {
                    profile.getUpdatedUserData()
                }
                self.showImagePicker = false
            }) {
                ImagePicker(image: self.$profilePic)
            }
            
        }
    
    
    
    struct ProfilePic: View {
        @EnvironmentObject var profile: ProfileManager
        @Binding var profilePic: UIImage?
        
        var body: some View {
            ZStack {
                // Default image
                Image(systemName: "person.circle")
                    .font(.system(size: screenWidth * 0.4, weight: .ultraLight))
                    .foregroundColor(.black)
                
                
                // If profile has picture, shows picture, else default image
                if profile.profilePicURL != "" {
                    WebImage(url: URL(string: profile.profilePicURL))
                        .resizable()
                        .scaledToFill()
                        .clipShape(Circle())
                        .frame(width: screenWidth * 0.37, height: screenWidth * 0.37)
                }
            }
            
        }
    }
    
    struct Header: View {
        var body: some View {
            ZStack {
                // Background
                Color.orange.ignoresSafeArea()
                
                // Content
                HStack {
                    Text("Profile")
                        .font(.system(size: screenWidth * 0.08, weight: .semibold))
                    
                    Spacer()
                    
                    Image(systemName: "gearshape.fill")
                        .font(.system(size: screenWidth * 0.06, weight: .light))
                }
                .foregroundColor(.white)
                .padding(.horizontal)
                
            }
            .frame(height: screenHeight * 0.075)
        }
    }
    
}

struct Profile_Previews: PreviewProvider {
    static var previews: some View {
        Profile()
            .environmentObject(ProfileManager())
    }
}
