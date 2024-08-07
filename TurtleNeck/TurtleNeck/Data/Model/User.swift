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
    var goodPostureRange : Double = 0.1 //약 5.7도
    var disturbMode : Bool = false
    var notiCycle: Double = 10 //TODO: 10초 -> 10분으로 수정
    
    init(isFirst: Bool) {
        self.isFirst = isFirst
    }
}
