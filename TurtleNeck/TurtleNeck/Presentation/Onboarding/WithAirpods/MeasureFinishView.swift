//
//  FinishMeasuringView.swift
//  TurtleNeck
//
//  Created by Hyun Jaeyeon on 7/28/24.
//

import SwiftUI

struct MeasureFinishView: View {
    @State private var isAppStartHover = false
    @State private var isMeasureAgainHover = false
    
    var body: some View {
        VStack(spacing: 16){
            Rectangle()
                .frame(width: 190, height: 168)
                .cornerRadius(8)
                .foregroundColor(.gray)
                .padding(.bottom, 8)
            
            Text("측정이 끝났어요.")
                .font(.title3)
                .fontWeight(.semibold)
            
            Text("자세가 흐트러지면 알려드릴게요!\n에어팟 사용 관련 설정은 세팅에서 바꿀 수 있어요.")
                .multilineTextAlignment(.center)
                .lineSpacing(4)
                .font(.callout)
                .foregroundColor(.subTextGray)
            
            Spacer()
            
            VStack(spacing: 16){
                Button {
                    
                } label: {
                    Text("시작하기")
                        .frame(width: 200, height: 33)
                        .foregroundColor(.primary)
                        .background(isAppStartHover ? Color.buttonHoverBG : Color.clear)
                }
                .buttonStyle(.plain)
                .cornerRadius(12)
                .onHover(perform: { hovering in
                    isAppStartHover = hovering
                })
                
                Button {
                    
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
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.top, 86)
        .padding(.bottom, 39)
    }
}

#Preview {
    MeasureFinishView()
        .frame(width: 560, height: 560)
        .background(.white)
}
