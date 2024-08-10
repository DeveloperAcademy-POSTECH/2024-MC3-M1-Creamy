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
    @State private var wearingStartTime: Date?
    @State private var isStarted: Bool = false
    @State private var timer: Timer? = nil
    @State private var timerValue: Int = 0
    
    @Query var statistic: [NotiStatistic]
    
    let userManager = UserManager()
    
    var characterNotiManager : CharacterNotiManager = CharacterNotiManager()

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
            if let user = userManager.loadUser() { // UseDefault가 잘 들어갔는지 확인
                print(user)
            }
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
                if timer == nil {
                    startTimer()
                }
                
                // 등록된 로컬 노티 제거
                NotificationManager().removeTimeNoti()
                // 캐릭터 노티 제거
                characterNotiManager.removeCharacterNoti()
                
                // bad 상태 5초 이상 유지 후 good 상태로 전환일 때
                if let lastBadTime = motionManager.lastBadPostureTime, Date().timeIntervalSince(lastBadTime) >= 5 {

                    // good 로컬 노티 등록
                    NotificationManager().settingTimeNoti(state: .good)
                }
                
            case .bad:
                resetTimer()
                
                if oldState == .good {
                    NotificationManager().settingTimeNoti(state: .bad)
                }
                else if oldState == .worse {
                    
                }
                
                if let notiStatistic = statistic.last {
                    notiStatistic.notiCount = notiStatistic.notiCount + 1
                }
                
            case .worse:
                if let notiStatistic = statistic.last {
                    notiStatistic.notiCount = notiStatistic.notiCount + 1                    
                }
                
                // 등록된 로컬 노티 제거
                NotificationManager().removeTimeNoti()
                // 캐릭터 노티 설정
                characterNotiManager.setCharacterNoti()
            }
        }
        .onChange(of: motionManager.isConnected) { isConnected in
            if isConnected {
                wearingStartTime = Date()
                checkAndAddTodayData() // isConnected가 true일 때 호출
            }
            else {
                resetTimer()

                if let startTime = wearingStartTime {
                    let endTime = Date()
                    let wearingDuration = Int(endTime.timeIntervalSince(startTime))
                    
                    let today = Calendar.current.startOfDay(for: endTime)
                    
                    if let lastStatistic = statistic.last {
                        lastStatistic.time += wearingDuration
                    }
                    
                    do {
                        try modelContext.save()
                    } catch {
                        print("저장 중 오류 발생: \(error)")
                    }
                }
                
                wearingStartTime = nil // 착용 시간 초기화
            }
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

                        Text("기록")
                            .font(.pretendardRegular13)
                            .foregroundColor(isRealTime ? .chevron : .primary)
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
    private func showView(isRealTime: Bool) -> some View {
        if isRealTime {
            RealTimePostureView(motionManager: motionManager, time: $timerValue)
        }
        
        else {
            StatisticView(motionManager: motionManager,time: $timerValue)
        }
    }
}

extension MainView {
    private func checkAndAddTodayData() {
        let today = Calendar.current.startOfDay(for: Date())
        let todayDataExists = statistic.contains { Calendar.current.isDate($0.date, inSameDayAs: today) }
        
        if !todayDataExists {
            // 오늘 데이터가 없으면 새 데이터 추가
            let newTodayData = NotiStatistic(date: today)
            modelContext.insert(newTodayData)
            print("오늘에 해당하는 데이터가 추가되었습니다.")
        }
        
        // 데이터 갯수가 8개를 초과할 경우 제일 오래된 데이터 삭제
        if statistic.count > 8 {
            guard let firstItem = statistic.first else { return } // 첫 번째 아이템 확인
            modelContext.delete(firstItem)
            print("가장 오래된 데이터가 삭제되었습니다.")
        }
    }
    
    private func startTimer() {
        timerValue = 0
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            timerValue += 1
            print("타이머: \(timerValue)초")
        }
    }
    
    private func resetTimer() {
        checkBestRecord()
        
        timer?.invalidate()
        timer = nil
        timerValue = 0
    }
    
    private func checkBestRecord() {
        if let todayStatistic = statistic.last {
            if timerValue > todayStatistic.bestRecord {
                todayStatistic.bestRecord = timerValue // bestRecord 갱신
                print("Best Record 갱신됨: \(todayStatistic.bestRecord)초")
            }
        }
    }
}


#Preview {
    MainView()
}
