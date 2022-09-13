//
//  CreateCircle.swift
//  myDanceJourney
//
//  Created by Rohan Kumar on 9/10/22.
//

import SwiftUI

struct CreateCircleView: View {
    @Binding var toggleSheet: Bool
    var body: some View {
        VStack {
            
            // Header
            HStack {
                Text("Create A Circle")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                Spacer()
                
                // X button to close sheet
                Button { self.toggleSheet = false } label: {
                    Image(systemName: "xmark")
                        .foregroundColor(.black)
                }
            }
            .padding()
            
            // TODO: CREATE UI FOR THIS VIEW
            
            Spacer()
        }
    }
}

struct CreateCircle_Previews: PreviewProvider {
    static var previews: some View {
        CreateCircleView(toggleSheet: .constant(true))
    }
}
