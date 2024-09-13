//
//  AirpodsAlertView.swift
//  TurtleNeck
//
//  Created by Hyun Jaeyeon on 7/28/24.
//

import SwiftUI
import CoreMotion

struct MotionPermissionView: View {
    @StateObject private var motionManager = HeadphoneMotionManager()
    let userManager = UserManager()
    
    var body: some View {
        VStack(spacing: 12){
            Image("motionPermissionImg")
                .padding(.bottom, 13)
            
            Text("접근 권한을 허용해주세요.")
                .font(.tnHeadline20)
            
            Text("자세가 흐트러진 순간 정확하게\n알림을 드리기 위해 접근 권한 허용이 필요해요")
                .multilineTextAlignment(.center)
                .lineSpacing(4)
                .font(.tnBodyRegular14)
                .foregroundColor(.subText)
            
            Spacer()
            
            HoverableButton(
                action: {
                    Router.shared.navigate(to: .measureReadyFirst)
                },
                label: "다음"
            )
        }
        .onAppear{
            // 일단 stop, 권한만 받아옴
            motionManager.stopUpdates()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.top, 62)
        .padding(.bottom, 58)
    }
}

#Preview {
    MotionPermissionView()
        .frame(width: 560, height: 532)
        .background(.white)
}
