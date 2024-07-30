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
        VStack(spacing: 16){
            Rectangle()
                .frame(width: 190, height: 168)
                .cornerRadius(8)
                .foregroundColor(.gray)
                .padding(.bottom, 8)
            
            Text("접근 권한을 허용해주세요.")
                .font(.title3)
                .fontWeight(.semibold)
            
            Text("자세가 흐트러진 순간 정확하게 알림을 드리기 위해 접근 권한 허용이 필요해요")
                .font(.callout)
                .foregroundColor(.subTextGray)
            
            Spacer()
            
            Button {
                router.navigate(to: .measureReady)
            } label: {
                Text("다음")
                    .foregroundColor(.primary)
                    .frame(width: 200, height: 33)
            }
            .buttonStyle(.plain)
        }
        .padding(.top, 117)
        .padding(.bottom, 61)
        .border(.black)
    }
}

#Preview {
    MotionPermissionView()
        .frame(width: 560, height: 560)
        .background(.white)
}
