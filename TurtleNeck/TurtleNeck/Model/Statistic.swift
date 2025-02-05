//
//  Statistic.swift
//  TurtleNeck
//
//  Created by Doran on 12/29/24.
//

import Foundation

struct Statistic: Identifiable, Codable {
    var id: UUID = UUID() // 고유 식별자
    var date: Date
    var time: Int // 착용 시간
    var notiCount: Int // 알림 카운트
    var bestRecord: Int // 최상의 기록
    
    // 초기화 메서드 수정
    init(date: Date, time: Int = 0, notiCount: Int = 0, bestRecord: Int = 0) {
        self.date = date
        self.time = time
        self.notiCount = notiCount
        self.bestRecord = bestRecord
    }

    
    mutating func addWearingTime(_ additionalTime: Int) {
        self.time += additionalTime
    }
}
