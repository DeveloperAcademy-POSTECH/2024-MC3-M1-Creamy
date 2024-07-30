//
//  AppIntroductionView.swift
//  TurtleNeck
//
//  Created by Hyun Jaeyeon on 7/28/24.
//

import SwiftUI

struct CheckDeviceView: View {
    @EnvironmentObject var router: Router
    
    @State private var isWithAirpodsHover = false
    @State private var isWithoutAirpodsHover = false
    
    private var image: String {
        isWithAirpodsHover ? "withMax" : "withoutAirpods"
    }
    
    var body: some View {
        VStack(spacing: 16){
            Image(image)
            
            Text("에어팟 사용 여부를 선택해 주세요.")
                .font(.title3)
                .fontWeight(.semibold)

            Text("에어팟을 착용하면 자세가 흐트러진 정확한 시점에 알림을 드릴 수 있어요. \n 에어팟이 없다면 주기적으로 알림을 보내드려요.")
                .multilineTextAlignment(.center)
                .lineSpacing(4)
                .font(.callout)
                .foregroundColor(.subTextGray)
            
            Spacer()
            
            HStack(spacing: 16){
                ZStack (alignment: .bottom){
                    if isWithAirpodsHover{
                        Text("에어팟 3세대, 에어팟 프로, 맥스 모델만 가능해요")
                            .font(.footnote)
                            .foregroundColor(Color(hex: "BE6060"))
                    }
                    
                    Button {
                        router.navigate(to: .motionPermission)
                    } label: {
                        Text("에어팟으로 자세 측정하기")
                            .frame(width: 200, height: 33)
                            .foregroundColor(.primary)
                            .background(isWithAirpodsHover ? Color.buttonHoverBG : Color.clear)
                    }
                    .buttonStyle(.plain)
                    .cornerRadius(12)
                    .onHover(perform: { hovering in
                        isWithAirpodsHover = hovering
                    })
                    .padding(.bottom, 20)
                }
                .padding(.bottom, -20)
                
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
        .padding(.top, 35)
        .padding(.bottom, 61)
        .border(.black)
    }
}

#Preview {
    CheckDeviceView()
        .frame(width: 560, height: 560)
        .background(.white)
}
