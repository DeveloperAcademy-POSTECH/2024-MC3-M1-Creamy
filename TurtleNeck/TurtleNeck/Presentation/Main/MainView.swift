//
//  MainView.swift
//  TurtleNeck
//
//  Created by 박준우 on 7/26/24.
//

import SwiftUI
import SwiftData

struct MainView: View {
    @Environment(\.appDelegate) var appDelegate: AppDelegate?
    @Environment(\.modelContext) var modelContext
    
    @StateObject private var motionManager = HeadphoneMotionManager()
    @State var isRealTime: Bool = true
    @State var isMute: Bool = false
    
    @State private var lastCheckedDate = Date()
    
    @Query var statistic: [NotiStatistic]
    
    var body: some View {
        VStack(spacing: 0){
            HStack(alignment: .center, spacing: 10){
                Spacer()
                
                segmentView.padding(EdgeInsets(top: 4, leading: 0, bottom: 0, trailing: 16))
                
                TopMenuView(action: {
                    appDelegate?.openAlwaysOnTopView(isMute: $isMute, motionManager: motionManager)
                }, isMute: $isMute, motionManager: motionManager)

            }
            .padding(.top, 12)
            
            showView(isRealTime: isRealTime)
        }
        .padding(.horizontal,12)
        .background(.white)
        .frame(width: 348,height: 232)
        .onAppear {
            motionManager.startUpdates()
            checkDateChange()
            
            print(statistic.count)
        }
        .onChange(of: lastCheckedDate) { _, _ in
            checkDateChange()
        }
    }
    
    private var segmentView: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.white)
                .frame(width: 140, height: 22)
                .shadow(radius: 1)
        
            HStack(alignment: .center, spacing: 0) {
                Button(action: {
                    isRealTime = true
                }) {
                    ZStack {

                        RoundedRectangle(cornerRadius: 8)
                            .fill(isRealTime ?  Color.iconHoverBG : .white)

                        Text("실시간")
                            .font(.pretendardRegular13)
                            .foregroundColor(isRealTime ? .primary : .chevron)
                    }
                    .frame(width: 69.5, height: 22)
                }
                .buttonStyle(PlainButtonStyle())
                
                Button(action: {
                    isRealTime = false
                }) {
                    ZStack {

                        RoundedRectangle(cornerRadius: 8)
                            .fill(isRealTime ? .white : Color.iconHoverBG)

                        Text("통계")
                            .font(.pretendardRegular13)
                            .foregroundColor(isRealTime ? .chevron : .primary)
                    }
                    .frame(width: 69.5, height: 22)
                }
                .buttonStyle(PlainButtonStyle())
            }
        }
    }
    
    private func checkDateChange() {
        let currentDate = Date()
        let calendar = Calendar.current
        
        // 마지막 체크한 날짜와 현재 날짜의 년, 월, 일이 다르면 날짜 변경 감지
        if !calendar.isDate(lastCheckedDate, inSameDayAs: currentDate) {
            addNotiStatistic(for: currentDate)
        }
        
        lastCheckedDate = currentDate
    }
    
    private func addNotiStatistic(for date: Date) {
        // NotiStatistic의 새 항목 추가
        let newStatistic = NotiStatistic(date: date)
        modelContext.insert(newStatistic)
        print("날짜 변경! statistic 추가됨")
        
        // statistic 배열의 길이가 7을 초과하면 첫 번째 요소 삭제
        if statistic.count > 7 {
            if let firstStatistic = statistic.first {
                modelContext.delete(firstStatistic)
            }
        }
    }
}

extension MainView {
    @ViewBuilder
    private func showView(isRealTime: Bool) -> some View {
        if isRealTime {
            RealTimePostureView(motionManager: motionManager)
        }
        
        else {
            StatisticView()
        }
    }
}

#Preview {
    MainView()
}
