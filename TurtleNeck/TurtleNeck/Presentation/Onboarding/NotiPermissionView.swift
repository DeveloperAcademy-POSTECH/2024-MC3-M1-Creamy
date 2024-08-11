//
//  OnboardingView.swift
//  TurtleNeck
//
//  Created by 박준우 on 7/26/24.
//

import SwiftUI

struct NotiPermissionView: View {
    let userManager = UserManager()
    
    var body: some View {
        VStack(spacing: 0){
            VStack(spacing: 0){
                Image("notificationImg")
                    .padding(.bottom, 40)
                
                Text("알림 허용이 필요해요")
                    .font(.tnHeadline20)
                    .padding(.bottom, 12)
                
                Text("더 올바른 자세 유지를 도울 수 있도록\n알림 허용이 필요해요")
                    .font(.tnBodyRegular14)
                    .multilineTextAlignment(.center)
                    .lineSpacing(4)
                    .foregroundColor(.subText)
            }
            .padding(.bottom, 58)
            
//            Spacer()
            
            HoverableButton(
                action: {
                    //모션 허용 시, default 유저 정보 생성
                    let user = User(isFirst: true)
                    userManager.saveUser(user)
                    
                    Router.shared.navigate(to: .checkDevice)
                },
                label: "다음"
            )
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .onAppear{
            NotificationManager().requestNotiPermission()
        }
    }
}

#Preview {
    NotiPermissionView()
        .frame(width: 560, height: 560)
        .background(.white)
}
