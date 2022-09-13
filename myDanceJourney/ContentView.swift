//
//  ContentView.swift
//  myDanceJourney
//
//  Created by Rohan Kumar on 9/6/22.
//

import SwiftUI

let screenWidth = UIScreen.main.bounds.width
let screenHeight = UIScreen.main.bounds.height



struct ContentView: View {
    @StateObject var profile = ProfileManager()

    var body: some View {
        
        if profile.isLoggedIn {
        
            TabView {
                Circles()
                    .tabItem {
                        Label("Circles", systemImage: "circle.hexagonpath")
                    }
                Growth()
                    .tabItem {
                        Label("Growth", systemImage: "leaf")
                    }
                Calendar()
                    .tabItem {
                        Label("Calendar", systemImage: "calendar")
                    }
                Ideabank()
                    .tabItem {
                        Label("Idea Bank", systemImage: "heart.text.square")
                    }
                Profile()
                    .tabItem {
                        Label("Profile", systemImage: "person")
                    }
            }
            .accentColor(.orange)
            .environmentObject(profile)
            
        } else {
            Authentication()
                .environmentObject(profile)
        }
    
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
