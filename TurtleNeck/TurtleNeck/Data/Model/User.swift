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
    var goodPosture: Double
    var goodPostureRange : Double
    var disturbMode : Bool
    var alertCycle: Int
    @Relationship(deleteRule: .cascade) var alertStatistics: [AlertStatistic]?
    
    init(isFirst: Bool, goodPosture: Double, goodPostureRange: Double, disturbMode: Bool, alertCycle: Int) {
        self.isFirst = isFirst
        self.goodPosture = goodPosture
        self.goodPostureRange = goodPostureRange
        self.disturbMode = disturbMode
        self.alertCycle = alertCycle
    }
}
