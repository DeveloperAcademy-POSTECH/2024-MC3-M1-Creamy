//
//  FinishMeasuringView.swift
//  TurtleNeck
//
//  Created by Hyun Jaeyeon on 7/28/24.
//

import SwiftUI

struct MeasureFinishView: View {
    @AppStorage("isFirst") var isFirst: Bool = true
    @Environment(\.appDelegate) var appDelegate: AppDelegate?
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.modelContext) var modelContext
    let userManager = UserManager()
    
    var body: some View {
        VStack(spacing: 0){
            Image("fighting")
                .padding(.bottom, 26)
            
            Text("측정이 끝났어요.")
                .font(.tnHeadline20)
                .padding(.bottom, 12)
            
            Text("자세가 흐트러지면 알려드릴게요!\n알림 타입은 설정에서 바꿀 수 있어요.")
                .multilineTextAlignment(.center)
                .lineSpacing(4)
                .font(.tnBodyRegular14)
                .foregroundColor(.subText)
                .padding(.bottom, 32)
            
            VStack(spacing: 16){
                HoverableButton(
                    action: {
                        appDelegate?.createMenuBarIcon()
                        
                        // default NotiStatistic 정보 생성
                        let notiStatistic = NotiStatistic(date: Date())
                        modelContext.insert(notiStatistic)

                        NSApplication.shared.keyWindow?.close()
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            appDelegate?.showPopover()
                        }
                        
                        userManager.setUserMode(selectedMode: false, keyPath: \User.isFirst)
                    },
                    label: "시작하기"
                )
                
                HoverableButton(
                    action: {
                        Router.shared.navigateToRoot()
                        Router.shared.navigate(to: .measureReady)
                    },
                    label: "다시 측정하기"
                )
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    MeasureFinishView()
        .frame(width: 560, height: 560)
        .background(.white)
}
