//
//  PostureInfoView.swift
//  TurtleNeck
//
//  Created by Hyun Jaeyeon on 7/28/24.
//

import SwiftUI

struct MeasureReadyView: View {
    @EnvironmentObject var router: Router
    
    @State var isMeasureStartHover = false
    @State var isWithoutAirpodsHover = false
    
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
                Button {
                    router.navigate(to: .measurePosture)
                } label: {
                    Text("측정 시작하기")
                        .frame(width: 200, height: 33)
                        .foregroundColor(.primary)
                        .background(isMeasureStartHover ? Color.buttonHoverBG : Color.clear)
                }
                .buttonStyle(.plain)
                .cornerRadius(12)
                .onHover(perform: { hovering in
                    isMeasureStartHover = hovering
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
        .padding(.top, 117)
        .padding(.bottom, 44)
        .border(.black)
    }
}

#Preview {
    MeasureReadyView()
        .frame(width: 560, height: 560)
        .background(.white)
}
