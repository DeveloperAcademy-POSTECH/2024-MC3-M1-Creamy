//
//  OnboardingView.swift
//  TurtleNeck
//
//  Created by 박준우 on 7/26/24.
//

import SwiftUI

struct NotiPermissionView: View {
    var body: some View {
        VStack(spacing: 0){
            VStack(spacing: 0){
                Image("notificationImg")
                    .padding(.bottom, 28)
                
                Text("알림 허용이 필요해요")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .padding(.bottom, 16)
                
                Text("더 올바른 자세 유지를 도울 수 있도록\n알림 허용이 필요해요")
                    .multilineTextAlignment(.center)
                    .lineSpacing(4)
                    .font(.callout)
                    .foregroundColor(.subTextGray)
            }
            
            Spacer()
            
            HoverableButton(
                action: {
                    Router.shared.navigate(to: .checkDevice)
                },
                label: "다음"
            )
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.top, 132)
        .padding(.bottom, 61)
    }
}

#Preview {
    NotiPermissionView()
        .frame(width: 560, height: 560)
        .background(.white)
}
