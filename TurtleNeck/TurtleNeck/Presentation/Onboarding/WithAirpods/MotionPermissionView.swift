//
//  AirpodsAlertView.swift
//  TurtleNeck
//
//  Created by Hyun Jaeyeon on 7/28/24.
//

import SwiftUI

struct MotionPermissionView: View {
    @EnvironmentObject var router: Router
    
    var body: some View {
        VStack{
            Text("접근 권한을 허용해주세요.")
            Text("자세가 흐트러진 순간 정확하게 알림을 드리기 위해 접근 권한 허용이 필요해요")
            
            Button {
                router.navigate(to: .measureReady)
            } label: {
                Text("다음")
            }
        }
    }
}

#Preview {
    MotionPermissionView()
}
