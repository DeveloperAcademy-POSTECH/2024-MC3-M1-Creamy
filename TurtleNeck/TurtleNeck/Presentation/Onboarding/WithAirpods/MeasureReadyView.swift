//
//  PostureInfoView.swift
//  TurtleNeck
//
//  Created by Hyun Jaeyeon on 7/28/24.
//

import SwiftUI

struct MeasureReadyFirstView: View {
    var body: some View {
        VStack (spacing: 0){
            Image("ExplanationStep1")
                .padding(.bottom, 16)
            
            Text("바른 자세로 앉아주세요.")
                .font(.tnHeadline20)
                .fontWeight(.semibold)
                .padding(.bottom, 12)
            
            Text("자세 측정을 위해 에어팟을 착용하고,\n바른 자세로 앉아주세요.")
                .multilineTextAlignment(.center)
                .lineSpacing(4)
                .font(.tnBodyRegular14)
                .foregroundColor(.subText)
                .padding(.bottom, 52)
            
            VStack(spacing: 8){
                HoverableButton(
                    action: {
                        Router.shared.navigate(to: .measureReadySecond)
                    },
                    label: "다음"
                )
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct MeasureReadySecondView: View {
    var body: some View {
        VStack (spacing: 0){
            Image("ExplanationStep2")
                .padding(.bottom, 16)
            
            Text("화면을 자연스럽게 응시해 주세요.")
                .font(.tnHeadline20)
                .fontWeight(.semibold)
                .padding(.bottom, 12)
            
            Text("최대한 바른 자세를 유지하며 화면을 자연스럽게 응시해 주세요.\n측정 중 다른 곳을 바라보면 정확한 자세 측정에 실패할 수도 있어요.")
                .multilineTextAlignment(.center)
                .lineSpacing(4)
                .font(.tnBodyRegular14)
                .foregroundColor(.subText)
                .padding(.bottom, 52)
            
            VStack(spacing: 8){
                HoverableButton(
                    action: {
                        Router.shared.navigate(to: .measurePosture)
                    },
                    label: "측정 시작하기"
                )
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    MeasureReadyFirstView()
        .frame(width: 560, height: 560)
        .background(.white)
}
