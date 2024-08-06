//
//  AlertStatistic.swift
//  TurtleNeck
//
//  Created by Hyun Jaeyeon on 7/26/24.
//

import Foundation
import SwiftData

@Model
class NotiStatistic {
    @Attribute(.unique) var id = UUID()
    var date: Date = Date()
    var time: Int = 0
    var notiCount: Int = 0
    
    init(date: Date) {
        self.date = date
    }
}
