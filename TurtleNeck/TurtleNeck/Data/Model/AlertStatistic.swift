//
//  AlertStatistic.swift
//  TurtleNeck
//
//  Created by Hyun Jaeyeon on 7/26/24.
//

import Foundation
import SwiftData

@Model
class AlertStatistic {
    @Attribute(.unique) var id = UUID()
    var date: Date
    var time: Int
    var count: Int
    
    init(date: Date, time: Int, count: Int) {
        self.date = date
        self.time = time
        self.count = count
    }
}
