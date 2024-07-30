//
//  MeasuringErrorVIew.swift
//  TurtleNeck
//
//  Created by Hyun Jaeyeon on 7/28/24.
//

import SwiftUI

struct MeasureErrorView: View {
    @EnvironmentObject var router: Router
    
    @State var isMeasureAgainHover = false
    @State var isWithoutAirpodsHover = false
    
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
                .foregroundColor(.subTextGray)
                
            Spacer()
            
            VStack(spacing: 8){
                Button {
                    router.navigate(to: .measureReady)
                } label: {
                    Text("다시 측정하기")
                        .frame(width: 200, height: 33)
                        .foregroundColor(.primary)
                        .background(isMeasureAgainHover ? Color.buttonHoverBG : Color.clear)
                }
                .buttonStyle(.plain)
                .cornerRadius(12)
                .onHover(perform: { hovering in
                    isMeasureAgainHover = hovering
                })
                
                Button {
                    router.navigate(to: .withoutAirpods)
                } label: {
                    Text("에어팟 없이 알림만 받기")
                        .frame(width: 200, height: 33)
                        .foregroundColor(.primary)
                        .background(isWithoutAirpodsHover ? Color.buttonHoverBG : Color.clear)
                }
                .buttonStyle(.plain)
                .cornerRadius(12)
                .onHover(perform: { hovering in
                    isWithoutAirpodsHover = hovering
                })
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
