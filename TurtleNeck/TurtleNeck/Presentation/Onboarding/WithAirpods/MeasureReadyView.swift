//
//  PostureInfoView.swift
//  TurtleNeck
//
//  Created by Hyun Jaeyeon on 7/28/24.
//

import SwiftUI

struct MeasureReadyView: View {
    var body: some View {
        VStack (spacing: 16){
            Rectangle()
                .frame(width: 190, height: 168)
                .cornerRadius(8)
                .foregroundColor(.gray)
                .padding(.bottom, 8)
            
            Text("바른 자세로 앉아주세요.")
                .font(.title3)
                .fontWeight(.semibold)
            
            Text("자세 측정을 위해 에어팟을 착용하고, 바른 자세로 앉아주세요\n준비가 되면 하단의 측정 시작하기 버튼을 눌러주세요.")
                .multilineTextAlignment(.center)
                .lineSpacing(4)
                .font(.callout)
                .foregroundColor(.subTextGray)
                
            Spacer()
            
            VStack(spacing: 8){
                HoverableButton(
                    action: {
                        Router.shared.navigate(to: .measurePosture)
                    },
                    label: "측정 시작하기"
                )
                
                HoverableButton(
                    action: {
                        Router.shared.navigate(to: .withoutAirpods)
                    },
                    label: "에어팟 없이 알림만 받기"
                )
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.top, 117)
        .padding(.bottom, 44)
    }
}

#Preview {
    MeasureReadyView()
        .frame(width: 560, height: 560)
        .background(.white)
}
