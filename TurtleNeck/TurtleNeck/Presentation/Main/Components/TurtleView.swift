//
//  TurtleView.swift
//  TurtleNeck
//
//  Created by Doran on 8/2/24.
//

import SwiftUI

struct TurtleView: View {
    var body: some View {
        ZStack(alignment: .center) {
            Color.white
            
            Image("Neck+cloth")
                .resizable()
                .frame(width: 30.33, height: 77.16)
                .offset(x: 56 , y: -9 )

            
            Image("Body")
                .resizable()
                .scaledToFit()
                .frame(width: 175.67, height: 147.61)
                .offset(x:24, y: 48)
            
            Image("Head")
                .resizable()
                .scaledToFit()
                .frame(width: 64.21, height: 58.99)
                .offset(x: 43 , y: -36)
            
        }
        .frame(width: 188,height: 114)
    }
}

#Preview {
    TurtleView()
}
