//
//  WithoutAirpodsView.swift
//  TurtleNeck
//
//  Created by Hyun Jaeyeon on 7/28/24.
//

import SwiftUI

struct WithoutAirpodsView: View {
    @AppStorage("isFirst") var isFirst: Bool = true
    @Environment(\.appDelegate) var appDelegate: AppDelegate?
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.modelContext) var modelContext
    @State private var isAppStartHover = false
    let userManager = UserManager()
    
    var cycles: [Double] = [15, 30, 45, 60]
    @State private var selectedCycle: Double = 15
    
    var body: some View {
        VStack(spacing: 16){
            Image("withoutAirpodsNoti")
                .padding(.bottom, 68)
            
            Text("알림 간격을 선택해 주세요.")
                .font(.tnHeadline20)
                .padding(.bottom, 12)
            
            Menu("\(Int(selectedCycle))") {
                ForEach(cycles, id: \.self) { cycle in
                    Button(action: {
                        selectedCycle = cycle
                    }, label: {
                        Text("\(Int(cycle))")
                            .foregroundStyle(Color.black)
                    })
                }
            }
            .foregroundStyle(Color.white)
            .frame(width: 100)
            .padding(.bottom, 104)
                
            
            HoverableButton(action: {
                appDelegate?.createMenuBarIcon()
                
                // default NotiStatistic 정보 생성
                let notiStatistic = NotiStatistic(date: Date())
                modelContext.insert(notiStatistic)
                
                NSApplication.shared.keyWindow?.close()
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    appDelegate?.showPopover()
                }
                
                userManager.setUserMode(selectedMode: false, keyPath: \User.isFirst)
                userManager.setUserMode(selectedMode: selectedCycle, keyPath: \User.timeNotiCycle)
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
