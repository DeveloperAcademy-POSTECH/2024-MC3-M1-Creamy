//
//  WithoutAirpodsView.swift
//  TurtleNeck
//
//  Created by Hyun Jaeyeon on 7/28/24.
//

import SwiftUI

struct WithoutAirpodsView: View {
    @Environment(\.appDelegate) var appDelegate: AppDelegate?
    @Environment(\.presentationMode) var presentationMode
    @State private var isAppStartHover = false
    
    var body: some View {
        VStack(spacing: 16){
            Image("withoutAirpodsNoti")
                .padding(.bottom, 68)
            
            Text("주기적으로 알람을 드릴게요.")
                .font(.title3)
                .fontWeight(.semibold)
                .padding(.bottom, 16)
            
            Text("10분 간격으로 알림을 드릴게요.\n알림 간격은 추후 설정에서 조절이 가능해요.\n추후 에어팟으로 자세 측정을 하고 싶다면 설정에서 모드를 바꿀 수 있어요.")
                .multilineTextAlignment(.center)
                .lineSpacing(4)
                .font(.callout)
                .foregroundColor(.subTextGray)
            
            Spacer()
            
            HoverableButton(action: {
                appDelegate?.createMenuBarIcon()
                
                NSApplication.shared.keyWindow?.close()
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    appDelegate?.showPopover()
                }
            }, label: "시작하기")
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.top, 93)
        .padding(.bottom, 61)
    }
}

#Preview {
    WithoutAirpodsView()
        .frame(width: 560, height: 560)
        .background(.white)
}
