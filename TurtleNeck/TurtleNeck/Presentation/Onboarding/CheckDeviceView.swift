//
//  AppIntroductionView.swift
//  TurtleNeck
//
//  Created by Hyun Jaeyeon on 7/28/24.
//

import SwiftUI

struct CheckDeviceView: View {    
    @State private var isWithAirpodsHover = false
    @State private var selectedMode: NotificationMode?
    let userManager = UserManager()
    
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
                    
                    HoverableButton(
                        action: {
                            setUserMode(selectedMode: .postureAlert)
                            
                            Router.shared.navigate(to: .motionPermission)
                        },
                        label: "자세 알림 모드"
                    )
                    .onHover { hovering in
                        isWithAirpodsHover = hovering
                    }
                    .padding(.bottom, 20)
                }
                .padding(.bottom, -20)
                
                HoverableButton(
                    action: {
                        setUserMode(selectedMode: .defaultMode)
                        
                        Router.shared.navigate(to: .withoutAirpods)
                    },
                    label: "기본 알림 모드"
                )
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.top, 35)
        .padding(.bottom, 61)
    }
}

extension CheckDeviceView {
    //사용자가 선택한 모드를 저장
    private func setUserMode(selectedMode: NotificationMode) {
        if var user = userManager.loadUser() {
            user.notificationMode = selectedMode
            userManager.saveUser(user)
        }
    }
}

#Preview {
    CheckDeviceView()
        .frame(width: 560, height: 560)
        .background(.white)
}
