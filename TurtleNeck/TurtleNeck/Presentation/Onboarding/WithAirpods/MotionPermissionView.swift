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
    
    var body: some View {
        VStack(spacing: 16){
            Image("motionPermissionImg")
                .padding(.bottom, 24)
            
            Text("접근 권한을 허용해주세요.")
                .font(.title3)
                .fontWeight(.semibold)
            
            Text("자세가 흐트러진 순간 정확하게 알림을 드리기 위해 접근 권한 허용이 필요해요")
                .font(.callout)
                .foregroundColor(.subTextGray)
            
            Spacer()
            
            HoverableButton(
                action: {
                    Router.shared.navigate(to: .measureReady)
                },
                label: "다음"
            )
        }
        .onAppear{
            // 일단 stop, 권한만 받아옴
            motionManager.stopUpdates()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.top, 80)
        .padding(.bottom, 61)
    }
}

#Preview {
    MotionPermissionView()
        .frame(width: 560, height: 560)
        .background(.white)
}
