//
//  Circles.swift
//  myDanceJourney
//
//  Created by Rohan Kumar on 9/6/22.
//

import SwiftUI

struct Circles: View {
    @EnvironmentObject var profile: ProfileManager
    
    @State var searchText: String = ""
    @State private var showCreateCircleSheet = false
    
    
    
    var body: some View {
        
        ZStack {
            Color.orange.ignoresSafeArea()
            VStack {
                
                // Custom search bar
                ZStack {
                    let searchBarColor = Color.init(red: 43/255, green: 44/255, blue: 46/255)
                    // Black background
                    RoundedRectangle(cornerRadius: 25)
                        .fill(searchBarColor)
                        .shadow(color: .black.opacity(0.15), radius: 15, x: 0, y: 10)
      
                    // "Find A Circle" default text
                    HStack {
                        Text(self.searchText == "" ? "Find A Circle" : "")
                            .opacity(0.9)
                            .padding(.leading)

                        Spacer()

                    }
                    
                    // Searchbar textfield
                    TextField("", text: self.$searchText)
                        .foregroundColor(.white)
                        .background(.clear)
                        .padding(.horizontal)
                    
                    // X button to reset searchText
                    HStack {
                        Spacer()
                        Button { self.searchText = "" } label: { Image(systemName: "xmark.circle.fill") }
                            .opacity(0.8)
                            . padding(.horizontal)
                    }
                    
                }
                .foregroundColor(.white)
                .font(.system(size: screenWidth * 0.05, weight: .bold))
                .frame(width: screenWidth * 0.8, height: screenHeight * 0.05)
                
                // Search filters
                HStack {
                    ForEach(0..<4, id: \.self) { i in
                        // TODO: REPLACE WHITE CIRCLE WITH ICONS FOR SEARCH FILTERS
                        
                        ZStack {
                            Circle()
                                .fill(.white)
                            
                            Text("Filter \(i)") // REPLACE WITH FILTER TYPE AND IMAGE
                        }
                        .frame(width: screenWidth * 0.22, height: screenWidth * 0.22)
                        .padding(2)
                        .shadow(color: .black.opacity(0.15), radius: 10, x: 5, y: 10)
                    }
                }
                .frame(height: screenHeight * 0.15)
                
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 10) {
                        
                        ForEach(0..<8, id: \.self) { i in
                            
                            ZStack {
                                RoundedRectangle(cornerRadius: 25)
                                    .fill(.white)
                                
                                Text("My Circle \(i+1)") // TODO: REPLACE WITH CIRCLE ICON/NAME + TODO ITEMS
                            }
                            .frame(width: screenWidth * 0.95, height: screenHeight * 0.1)
                        }
                    }
                }
                .frame(height: screenHeight * 0.55)
                
                
                
                // "Create a circle" button
                Button {
                    self.showCreateCircleSheet = true
                } label: {
                    ZStack {
                        HStack {
                            Image(systemName: "plus.circle.fill")
                                .foregroundColor(.orange)
                                .font(.system(size: screenWidth * 0.05, weight: .bold))
                            Text("Create A Circle")
                                .foregroundColor(.black)
                                .fontWeight(.medium)
                        }
                        .font(.system(size: screenWidth * 0.035))
                        .padding(.horizontal, 10)
                        .padding(.vertical, 8)
                        .background(.white)
                        .cornerRadius(5)
                        .shadow(color: .black.opacity(0.2), radius: 20, x: 2, y: 5)
                    }
                }
                

                
                
                
                
                Spacer()
            }
            
            
            VStack {
                Spacer()
                CirclesPopup().environmentObject(profile)
            }
        }
        .fullScreenCover(isPresented: self.$showCreateCircleSheet) {
            CreateCircleView(toggleSheet: self.$showCreateCircleSheet)
        }
        
    }
}

struct CirclesView_Previews: PreviewProvider {
    static var previews: some View {
        Circles()
            .environmentObject(ProfileManager())
    }
}
