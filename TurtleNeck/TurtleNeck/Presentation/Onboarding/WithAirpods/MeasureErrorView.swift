//
//  MeasuringErrorVIew.swift
//  TurtleNeck
//
//  Created by Hyun Jaeyeon on 7/28/24.
//

import SwiftUI

struct MeasureErrorView: View {
    var body: some View {
        VStack(spacing: 16){
           Image("error")
                .padding(.bottom, 8)
            
            Text("측정을 실패했어요.")
                .font(.title3)
                .fontWeight(.semibold)
            
            Text("정확한 측정을 실패했어요.\n다시 자세를 측정해 주세요.")
                .multilineTextAlignment(.center)
                .lineSpacing(4)
                .font(.callout)
                .foregroundColor(.subText)
                
            Spacer()
            
            VStack(spacing: 8){
                HoverableButton(action: {
                    Router.shared.navigateToRoot()
                    Router.shared.navigate(to: .measureReady)
                }, label: "다시 측정하기")
                
                HoverableButton(action: {
                    Router.shared.navigate(to: .withoutAirpods)
                }, label: "에어팟 없이 알림만 받기")
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.top, 86)
        .padding(.bottom, 39)
    }
}

#Preview {
    MeasureErrorView()
        .frame(width: 560, height: 560)
        .background(.white)
}
