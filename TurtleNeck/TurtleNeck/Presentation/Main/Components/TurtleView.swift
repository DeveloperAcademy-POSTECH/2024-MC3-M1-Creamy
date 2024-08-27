//
//  TurtleView.swift
//  TurtleNeck
//
//  Created by Doran on 8/2/24.
//

import SwiftUI

struct TurtleView: View {
    @ObservedObject var motionManager : HeadphoneMotionManager
    let user = UserManager().loadUser()
    
    var body: some View {
        ZStack(alignment: .center) {
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
        .frame(width: 188,height: 102)
    }
}

extension TurtleView {
    private func clampedPitchValue(_ pitch: CGFloat) -> CGFloat {
        guard let goodPosture = user?.goodPosture else {
            return 0
        }
        
        //사람마다 에어팟을 끼는 각도가 다르기 때문에, 그것에 따라 거북이의 offset을 조절하기 위해 다음과 같이 설정
        let adjustedPitch = pitch - goodPosture
        
        if user?.notificationMode == .posture {
            if motionManager.isConnected {
                return min(max(adjustedPitch, -0.73), 0.44)
            } else {
                return 0
            }
        } else {
            return 0.44
        }
    }
}
