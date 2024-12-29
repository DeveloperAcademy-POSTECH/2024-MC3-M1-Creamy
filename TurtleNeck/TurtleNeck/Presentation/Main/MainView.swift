//
//  MainView.swift
//  TurtleNeck
//
//  Created by 박준우 on 7/26/24.
//

import SwiftUI

struct MainView: View {
    @Environment(\.appDelegate) var appDelegate: AppDelegate?
    @EnvironmentObject var statisticManager: StatisticManager
    @StateObject private var notificationManager = NotificationManager()
    @StateObject private var motionManager = HeadphoneMotionManager()
    @StateObject private var timerManager = TimerManager()

    @State var isRealTime: Bool = true
    @State private var lastCheckedDate = Date()
    @State private var wearingStartTime: Date?
    @State private var isStarted: Bool = false

    private var userData: User = UserManager().loadUser() ?? User(isFirst: true)
    
    var userManager = UserManager()
    
    var characterNotiManager : CharacterNotiManager = CharacterNotiManager()
    
    var body: some View {
        VStack(spacing: 0){
            HStack(alignment: .center, spacing: 10){
                Spacer()
                
                segmentView.padding(EdgeInsets(top: 4, leading: 0, bottom: 0, trailing: 16))
                
                TopMenuView(action: {
                    appDelegate?.openAlwaysOnTopView(notificationManager: notificationManager, motionManager: motionManager, timerManager: timerManager)
                }, notificationManager: notificationManager, motionManager: motionManager, timerManager: timerManager)
                
            }
            .padding(.top, 12)
            
            showView(isRealTime: isRealTime, timer: timerManager.timer)
            
            Spacer()
        }
        .padding(.horizontal,12)
        .background(.white)
        .frame(width: 348,height: 232)
        .onAppear {
            if let userData = userManager.loadUser() { // UseDefault가 잘 들어갔는지 확인
                if userData.notificationMode == .posture {
                    motionManager.startUpdates()
                }
                else if userData.notificationMode == .default {
                    // 등록된 로컬 노티 제거
                    notificationManager.removeNoti()
                    // 로컬 노티 등록
                    notificationManager.settingTimeNoti(state: .normal)
                }
            }
            print(statisticManager.statistics)
        }
        .onChange(of: motionManager.currentState) { oldState, newState in
            guard let currentState = motionManager.currentState else { return }
            
            // 처음 상태 변경시에는 알림을 무시하기 위해 isStarted 사용
            if !isStarted {
                isStarted = true
                return
            }
            
            switch currentState {
            case .good:
                // 타이머 시작
                if timerManager.timer == nil {
                    timerManager.startTimer()
                }
                
                // 등록된 로컬 노티 제거
                notificationManager.removeNoti()
                // 캐릭터 노티 제거
                characterNotiManager.removeCharacterNoti()
                
                // bad 상태 5초 이상 유지 후 good 상태로 전환일 때
                if let lastBadTime = motionManager.lastBadPostureTime, Date().timeIntervalSince(lastBadTime) >= 5 {
                    
                    // good 로컬 노티 등록
                    notificationManager.settingTimeNoti(state: .good)
                }
                
            case .bad:
                timerManager.resetTimer(statistics: &statisticManager.statistics)

                if oldState == .good {
                    notificationManager.settingTimeNoti(state: .bad)
                }
                
                // 마지막 통계 업데이트
                if var lastStatistic = statisticManager.statistics.last {
                    lastStatistic.notiCount += 1 // notiCount 증가
                    statisticManager.statistics[statisticManager.statistics.count - 1] = lastStatistic
                    statisticManager.saveStatistics()
                }
                
            case .worse:
                // 마지막 통계 업데이트
                if var lastStatistic = statisticManager.statistics.last {
                    lastStatistic.notiCount += 1 // notiCount 증가
                    statisticManager.statistics[statisticManager.statistics.count - 1] = lastStatistic
                    statisticManager.saveStatistics()
                }
                
                // 등록된 로컬 노티 제거
                notificationManager.removeNoti()
                // 캐릭터 노티 설정
                characterNotiManager.setCharacterNoti()
            }
        }
        .onChange(of: motionManager.isConnected) { _, isConnected in
            if isConnected {
                wearingStartTime = Date()
                checkAndAddTodayData() // isConnected가 true일 때 호출
            }
            else {
                timerManager.resetTimer(statistics: &statisticManager.statistics)
                
                if let startTime = wearingStartTime {
                    let endTime = Date()
                    let wearingDuration = Int(endTime.timeIntervalSince(startTime))
                    
                    let today = Calendar.current.startOfDay(for: endTime)
                    
                    if var lastStatistic = statisticManager.statistics.last {
                        lastStatistic.time += wearingDuration
                        statisticManager.statistics[statisticManager.statistics.count - 1] = lastStatistic
                    }
                    
                    statisticManager.saveStatistics()
                }
                
                wearingStartTime = nil // 착용 시간 초기화
            }
        }
        .onChange(of: userManager.loadUser()?.goodPosture) { _, _ in
            motionManager.reset() // goodPosture가 변경될 때 reset 호출
            motionManager.startUpdates()
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
                            .fill(isRealTime ?  Color.buttonHover : .white)

                        Text("실시간")
                            .font(.tnBodyRegular13)
                            .foregroundColor(isRealTime ? .buttonText : .chevron)
                    }
                    .frame(width: 69.5, height: 22)
                }
                .buttonStyle(PlainButtonStyle())
                
                Button(action: {
                    isRealTime = false
                }) {
                    ZStack {

                        RoundedRectangle(cornerRadius: 8)
                            .fill(isRealTime ? .white : Color.buttonHover)

                        Text("기록")
                            .font(.tnBodyRegular13)
                            .foregroundColor(isRealTime ? .chevron : .buttonText)
                    }
                    .frame(width: 69.5, height: 22)
                }
                .buttonStyle(PlainButtonStyle())
            }
        }
    }

}

extension MainView {
    @ViewBuilder
    private func showView(isRealTime: Bool, timer: Timer?) -> some View {
        if isRealTime {
            RealTimePostureView(motionManager: motionManager, timerManager: timerManager)
                .environmentObject(statisticManager)
        }
        
        else {
            StatisticView(motionManager: motionManager, timerManager: timerManager)
                .environmentObject(statisticManager)
        }
    }
}

extension MainView {
    private func checkAndAddTodayData() {
        let today = Calendar.current.startOfDay(for: Date())
        let todayDataExists = statisticManager.statistics.contains { Calendar.current.isDate($0.date, inSameDayAs: today) }

        if !todayDataExists {
            let newTodayData = Statistic(date: today)
            statisticManager.addStatistic(newTodayData)
            print("오늘에 해당하는 데이터가 추가되었습니다.")
        }

        if statisticManager.statistics.count > 8 {
            statisticManager.statistics.removeFirst()
            print("가장 오래된 데이터가 삭제되었습니다.")
        }
    }
}


#Preview {
    MainView().environmentObject(StatisticManager())
}
