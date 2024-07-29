//
//  AppIntroductionView.swift
//  TurtleNeck
//
//  Created by Hyun Jaeyeon on 7/28/24.
//

import SwiftUI

struct CheckDeviceView: View {
    @EnvironmentObject var router: Router
    
    var body: some View {
        VStack(spacing: 16){
            Image("checkDeviceImg")
            
            Text("에어팟 사용 여부를 선택해 주세요.")
                .font(.title3)
                .fontWeight(.semibold)

            Text("에어팟을 착용하면 자세가 흐트러진 정확한 시점에 알림을 드릴 수 있어요. \n 에어팟이 없다면 주기적으로 알림을 보내드려요.")
                .multilineTextAlignment(.center)
                .lineSpacing(4)
                .font(.callout)
            
            Spacer()
            
            HStack(spacing: 16){
                Button {
                    router.navigate(to: .motionPermission)
                } label: {
                    Text("에어팟으로 자세 측정하기")
                        .foregroundStyle(.green)
                        .frame(width: 200, height: 33)
                }
                .buttonStyle(.plain)
                .border(.black)
                
                Button {
                    router.navigate(to: .withoutAirpods)
                } label: {
                    Text("에어팟 없이 알림만 받기")
                        .foregroundStyle(.green)
                        .frame(width: 200, height: 33)
                }
                .buttonStyle(.plain)
                .border(.black)
            }
        }
        .padding(.top, 35)
        .padding(.bottom, 61)
    }
}

#Preview {
    CheckDeviceView()
        .frame(width: 560, height: 560)
        .background(.white)
}
