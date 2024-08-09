//
//  User.swift
//  TurtleNeck
//
//  Created by Hyun Jaeyeon on 7/26/24.
//

import Foundation

struct User: Codable {
    var isFirst: Bool
    var goodPosture: Double?
    var goodPostureRange : Double = 0.1 //약 5.7도
    var disturbMode : Bool = false
    var notiCycle: Double = 10 //TODO: 10초 -> 10분으로 수정
}
