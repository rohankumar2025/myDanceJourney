//
//  Ideabank.swift
//  myDanceJourney
//
//  Created by Rohan Kumar on 9/6/22.
//

import SwiftUI

struct Ideabank: View {
    @State private var selectedCollection = 1 // State variable to update collection showed on screen
    
    
    
    var body: some View {
        ZStack {
            Color.orange.ignoresSafeArea()
            
            
            VStack(spacing: 0) {
                // Title text
                Text("My Ideabank")
                    .foregroundColor(.white)
                    .font(.system(size: screenWidth * 0.07, weight: .bold))
                    .padding(.vertical)
                
                
                // Scrollview to choose between collections
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(1..<7, id: \.self) { i in
                            
                            Spacer()
                            
                            Text("Collection \(i)") // REPLACE WITH COLLECTION NAMES
                                .foregroundColor(self.selectedCollection == i ? .white : .black)
                                .font(.system(size: 15, weight: self.selectedCollection == i ? .bold : .regular))
                                .frame(width: screenWidth * 0.25)
                                .onTapGesture {
                                    withAnimation { self.selectedCollection = i }
                                }
                            
                            Spacer()
                        }
                    }
                }
                
                // Ideabank picture
                ZStack {
                    RoundedRectangle(cornerRadius: 15) // TODO: REPLACE WITH USER-INPUTTED IMAGE
                        .fill(.white)
                    
                    Text("Ideabank Picture")
                }
                .frame(width: screenWidth * 0.4, height: screenWidth * 0.4)
                .padding(.top)
                
                // Collection name text
                Text("Collection \(self.selectedCollection)") // TODO: REPLACE WITH COLLECTION NAME
                    .font(.system(size: 15, weight: .bold))
                    .foregroundColor(.white)
                    .padding(.bottom)
                
                // Scrollview VGrid for videos
                ScrollView {
                    let columns = Array(repeating: GridItem(.flexible()), count: 3)

                    LazyVGrid(columns: columns, spacing: 10) {
                        ForEach(0..<26, id: \.self) { i in
                            ZStack {
                                // TODO: REPLACE WITH VIDEOS ADDED BY USER
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(.white.opacity(0.5))
                            
                                Text("Video \(i)")
                            }
                            .frame(width: screenWidth * 0.3, height: screenHeight * 0.2)
                            
                        }
                    }
                    .frame(width: screenWidth * 0.95)
                }

                
                Spacer()
                
                // White on bottom of screen for footer
                Color.white.ignoresSafeArea()
                    .frame(height: screenHeight * 0.02)
            }
            
            
        }
    }
}

struct Ideabank_Previews: PreviewProvider {
    static var previews: some View {
        Ideabank()
    }
}
