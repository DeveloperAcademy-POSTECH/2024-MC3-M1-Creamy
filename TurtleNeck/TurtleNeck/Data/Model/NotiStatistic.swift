//
//  AlertStatistic.swift
//  TurtleNeck
//
//  Created by Hyun Jaeyeon on 7/26/24.
//

import Foundation
import SwiftData

@Model
class NotiStatistic: Identifiable {
    @Attribute(.unique) var id = UUID()
    var date: Date = Date()
    var time: Int = 0
    var notiCount: Int = 0
    var bestRecord: Int = 0
    
    init(date: Date) {
        self.date = date
    }
    
    func addWearingTime(_ additionalTime: Int) {
            self.time += additionalTime
    }
}
