//
//  FinishMeasuringView.swift
//  TurtleNeck
//
//  Created by Hyun Jaeyeon on 7/28/24.
//

import SwiftUI

struct MeasureFinishView: View {
    @Environment(\.appDelegate) var appDelegate: AppDelegate?
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.modelContext) var modelContext
    
    var body: some View {
        VStack(spacing: 16){
            Image("fighting")
                .padding(.bottom, 16)
            
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
                        
                        UserDefaults.standard.set(false, forKey: "isFirst")
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
        .padding(.top, 86)
        .padding(.bottom, 39)
    }
}

#Preview {
    MeasureFinishView()
        .frame(width: 560, height: 560)
        .background(.white)
}
