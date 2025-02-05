//
//  WithoutAirpodsView.swift
//  TurtleNeck
//
//  Created by Hyun Jaeyeon on 7/28/24.
//

import SwiftUI

struct WithoutAirpodsView: View {
    @EnvironmentObject private var userManager: UserManager
    private var cycles: [Double] = [15, 30, 45, 60]
    
    @Environment(\.appDelegate) var appDelegate: AppDelegate?
    @Environment(\.presentationMode) var presentationMode
    
    @StateObject private var statisticManager = StatisticManager()
    @State private var isAppStartHover = false
    @State private var selectedCycle: Double = 15
    
    var body: some View {
        VStack(spacing: 16){
            Image("withoutAirpodsNoti")
                .padding(.bottom, 68)
            
            Text("알림 간격을 선택해 주세요.")
                .font(.tnHeadline20)
                .padding(.bottom, 12)
            
            Menu("\(Int(selectedCycle))분") {
                ForEach(cycles, id: \.self) { cycle in
                    Button(action: {
                        selectedCycle = cycle
                    }, label: {
                        Text("\(Int(cycle))분")
                            .foregroundStyle(Color.black)
                    })
                }
            }
            .foregroundStyle(Color.white)
            .frame(width: 100)
            .padding(.bottom, 104)
                
            
            HoverableButton(action: {
                appDelegate?.createMenuBarIcon()
                
                // default Statistic 정보 생성
                let newTodayData = Statistic(date: Date())
                statisticManager.addStatistic(newTodayData)
                
                NSApplication.shared.keyWindow?.close()
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    appDelegate?.showPopover()
                }
                
                userManager.updateUser(keyPath: \User.isFirst, value: false)
                userManager.updateUser(keyPath: \User.timeNotiCycle, value: selectedCycle * 60)
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
