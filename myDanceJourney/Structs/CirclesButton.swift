//
//  CirclesButton.swift
//  myDanceJourney
//
//  Created by Rohan Kumar on 9/9/22.
//

import SwiftUI

struct CirclesButton: View {
    var circleName: String
    var circleImage: String
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 30)
                .fill(.white)
                .shadow(color: .gray.opacity(0.4), radius: 20)
            
            VStack {
                Spacer()
                
                Image(systemName: self.circleImage)
                    .resizable()
                    .scaledToFit()
                    .frame(width: screenWidth * 0.2, height: screenHeight * 0.12)
                    
                Text(self.circleName)
                    .font(.system(size: 100, weight: .bold))
                    .minimumScaleFactor(0.01)
                    .padding(.horizontal)
                    .multilineTextAlignment(.center)
                
                Spacer()
            }
        }
        .frame(width: screenWidth * 0.4, height: screenHeight * 0.22)

    }
}

struct CirclesButton_Previews: PreviewProvider {
    static var previews: some View {
        CirclesButton(circleName: "Test123144215", circleImage: "calendar")
    }
}
