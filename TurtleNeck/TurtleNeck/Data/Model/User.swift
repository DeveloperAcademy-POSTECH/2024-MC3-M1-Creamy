//
//  User.swift
//  TurtleNeck
//
//  Created by Hyun Jaeyeon on 7/26/24.
//

import Foundation
import SwiftData

@Model
class User {
    var isFirst: Bool
    var goodPosture: Double? = nil
    var goodPostureRange : Double = 0.1
    var disturbMode : Bool = false
    var notiCycle: Int = 300
    @Relationship(deleteRule: .cascade) var notiStatistics: [NotiStatistic]?
    
    init(isFirst: Bool) {
        self.isFirst = isFirst
    }
}
