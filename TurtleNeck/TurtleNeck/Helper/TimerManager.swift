//
//  TimerManager.swift
//  TurtleNeck
//
//  Created by Doran on 9/22/24.
//

import Foundation
import SwiftUI

class TimerManager: ObservableObject {
    @Published var timerValue: Int = 0
    @Published var timer: Timer? = nil

    func startTimer() {
        timerValue = 0 // 타이머 초기화
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            self.timerValue += 1
            print("타이머: \(self.timerValue)초")
        }
    }

    func resetTimer(statistic: [NotiStatistic]) {
        self.checkBestRecord(statistic: statistic)
        timer?.invalidate() // 타이머 중지
        timer = nil
        timerValue = 0 // 값 초기화
    }
    
    func checkBestRecord(statistic: [NotiStatistic]) {
        if let todayStatistic = statistic.last {
            if timerValue > todayStatistic.bestRecord {
                todayStatistic.bestRecord = timerValue // bestRecord 갱신
                print("Best Record 갱신됨: \(todayStatistic.bestRecord)초")
            }
        }
    }
}
