//
//  CirclesPopup.swift
//  myDanceJourney
//
//  Created by Rohan Kumar on 9/9/22.
//

import SwiftUI

import SwiftUI

struct CirclesPopup: View {
    @EnvironmentObject var profile: ProfileManager
    // Used in dragging
    @State private var curHeight: CGFloat = screenHeight * 0.38
    @State private var prevDragTranslation = CGSize.zero
    
    let maxHeight = screenHeight * 0.7
    let minHeight = screenHeight * 0.05
    
    
    var body: some View {

            ZStack {
                RoundedRectangle(cornerRadius: 30)
                    .fill(.white)
                    .ignoresSafeArea()
                
                // Info for selected date (only drawn if selected date != nil
                VStack(alignment: .leading) {
                    // Header to show selected date
                    ZStack(alignment: .top) {
                        Capsule()
                            .frame(width: screenWidth * 0.1, height: screenHeight * 0.005)
                            .padding(.top, 5)
                    }
                    .frame(maxWidth: .infinity)
                    .background(Color.white.opacity(0.00001))
                    .gesture(dragGesture)
                    
                    
                    // TODO: ADD INFO
                    
                    
                    Spacer()
                }
            }
            .frame(height: max(self.curHeight, minHeight))
            .shadow(color: .black.opacity(0.1), radius: 20, x: 0, y: -10)
            // Animates view in from bottom of screen
            .transition(.move(edge: .bottom))
            .onAppear {
                withAnimation { self.curHeight = minHeight }
            }
            
            
        
    }
    
    var dragGesture: some Gesture {
        DragGesture(minimumDistance: 0, coordinateSpace: .global)
            .onChanged { val in
                let dragAmount = val.translation.height - prevDragTranslation.height
                curHeight -= dragAmount / (curHeight > maxHeight || curHeight < minHeight ? 6 : 1)
                prevDragTranslation = val.translation
            }
            .onEnded { val in
                prevDragTranslation = .zero
                if self.curHeight > maxHeight {
                    withAnimation { self.curHeight = maxHeight }
                } else if self.curHeight < minHeight {
                    withAnimation { self.curHeight = minHeight }
                }
            }
        
    }
    
    
    
}

struct SelectedDateView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Circles()
                .environmentObject(ProfileManager())
        }
    }
}

