//
//  OnboardingView.swift
//  TurtleNeck
//
//  Created by 박준우 on 7/26/24.
//

import SwiftUI

struct NotiPermissionView: View {
    @EnvironmentObject var router: Router
    
    var body: some View {
        VStack{
            Text("알림 허용이 필요해요")
            Text("더 올바른 자세 유지를 도울 수 있도록\n 알림 허용이 필요해요")
            
            Button {
                router.navigate(to: .checkDevice)
            } label: {
                Text("다음")
            }
        }
    }
}

#Preview {
    NotiPermissionView()
}
