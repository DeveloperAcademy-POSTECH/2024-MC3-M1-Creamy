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

    func resetTimer(statistics: inout [Statistic]) {
        checkBestRecord(statistics: &statistics)
        timer?.invalidate()
        timer = nil
        timerValue = 0
    }
    
    func checkBestRecord(statistics: inout [Statistic]) {
        guard let todayStatisticIndex = statistics.firstIndex(where: { Calendar.current.isDate($0.date, inSameDayAs: Date()) }) else {
            return
        }
        
        var todayStatistic = statistics[todayStatisticIndex]

        if timerValue > todayStatistic.bestRecord {
            todayStatistic.bestRecord = timerValue
            statistics[todayStatisticIndex] = todayStatistic
            print("Best Record 갱신됨: \(todayStatistic.bestRecord)초")
        }
    }
}
