//
//  TurtleView.swift
//  TurtleNeck
//
//  Created by Doran on 8/2/24.
//

import SwiftUI

struct TurtleView: View {
    @ObservedObject var motionManager : HeadphoneMotionManager
    
    var body: some View {
        ZStack(alignment: .center) {
//            Color.white
            Color.clear
            let defaultOffset = clampedPitchValue(motionManager.pitch)
            
            Image("Neck+cloth")
                .resizable()
                .frame(width: 30.33, height: 77.16)
                .rotationEffect(.degrees(defaultOffset * (180 / .pi)))
                .offset(x: 56 + defaultOffset * 5, y: -9 - defaultOffset * 5)


            
            Image("Body")
                .resizable()
                .scaledToFit()
                .frame(width: 175.67, height: 147.61)
                .offset(x:24, y: 48)
            
            Image("Head")
                .resizable()
                .scaledToFit()
                .frame(width: 64.21, height: 58.99)
                .rotationEffect(defaultOffset > 0 ? .degrees(defaultOffset * (180 / .pi) * 0.8) : .degrees(0))
                .offset(x: 43 + defaultOffset * 35, y: -36 - defaultOffset * 10)
            
        }
        .frame(width: 188,height: 114)
    }
}

extension TurtleView {
    private func clampedPitchValue(_ pitch: CGFloat) -> CGFloat {
        return min(max(pitch, -0.73), 0.44)
    }
}
