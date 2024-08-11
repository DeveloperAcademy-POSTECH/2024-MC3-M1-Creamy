//
//  AppIntroductionView.swift
//  TurtleNeck
//
//  Created by Hyun Jaeyeon on 7/28/24.
//

import SwiftUI

struct CheckDeviceView: View {    
    @State private var isWithAirpodsHover = false
    @State private var isMeasuringBadHovered = false
    @State private var isRegularTimeHovered = false
    
    var body: some View {
        VStack(spacing: 12){
            
            Text("받고 싶은 알림을 선택해 주세요.")
                .font(.crHeadline)

            Text("선택한 알림은 추후 설정에서 변경할 수 있어요")
                .font(.callout)
                .foregroundColor(.captionText)
                .padding(.bottom, 21)
                        
            HStack(spacing: 16){
                Button(action: {
                    print("hi")
                }) {
                    VStack(spacing: 0){
                        Image("MeasuringBad")
                            .padding(.bottom, 18)
                        
                        Text("자세 측정 알림")
                            .font(.crBodyEmphasized)
                            .padding(.bottom, 10)
                        
                        Text("자세가 흐트러졌을 때\n실시간으로 알림을 보내드려요.")
                            .multilineTextAlignment(.center)
                            .lineSpacing(2)
                            .font(.crBodyRegular)
                            .padding(.bottom, 6)
                        
                        Text("에어팟 3세대, 에어팟 프로,\n맥스 모델이 필요해요")
                            .multilineTextAlignment(.center)
                            .lineSpacing(2)
                            .font(.system(size: 10, weight: .semibold))
                            .foregroundColor(.warning)
                    }
                    .padding(.top, 20)
                    .padding(.bottom, 24)
                    .padding(.horizontal, 29)
                    .frame(width: 230, height: 312)
                    .background(isMeasuringBadHovered ? Color.buttonHoverBG : Color.clear)
                    .cornerRadius(16)
                }
                .buttonStyle(.plain)
                .onHover { hovering in
                    isMeasuringBadHovered = hovering
                }
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(isMeasuringBadHovered ? Color.buttonText : Color.borderLine, lineWidth: 2)
                )
                
                Button(action: {
                    print("hi")
                }) {
                    VStack(spacing: 0){
                        Image("RegularTime")
                            .padding(.bottom, 18)
                        
                        Text("기본 알림")
                            .font(.crBodyEmphasized)
                            .padding(.bottom, 10)
                        
                        Text("주기적으로 자세에 관련된\n알림을 보내드려요.")
                            .multilineTextAlignment(.center)
                            .lineSpacing(2)
                            .font(.crBodyRegular)
                            .padding(.bottom, 6)
                    }
                    .padding(.top, 20)
                    .padding(.bottom, 24)
                    .padding(.horizontal, 29)
                    .frame(width: 230, height: 312)
                    .background(isRegularTimeHovered ? Color.buttonHoverBG : Color.clear)
                    .cornerRadius(16)
                }
                .buttonStyle(.plain)
                .onHover { hovering in
                    isRegularTimeHovered = hovering
                }
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(isRegularTimeHovered ? Color.buttonText : Color.borderLine, lineWidth: 2)
                )
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.top, 40)
        .padding(.bottom, 68)
    }
}

#Preview {
    CheckDeviceView()
        .frame(width: 560, height: 560)
        .background(.white)
}
//
//struct CheckDeviceView_Preview: PreviewProvider {
//    static var previews: some View{
//        CheckDeviceView()
//            .frame(width: 560, height: 560)
//            .background(.white)
//    }
//}
