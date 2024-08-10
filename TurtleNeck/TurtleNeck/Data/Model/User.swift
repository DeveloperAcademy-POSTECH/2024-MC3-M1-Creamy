//
//  User.swift
//  TurtleNeck
//
//  Created by Hyun Jaeyeon on 7/26/24.
//

import Foundation

enum NotificationMode: String, Codable {
    case postureAlert // 자세 알림 모드
    case defaultMode // 기본 알림 모드
}

struct User: Codable {
    var isFirst: Bool
    var goodPosture: Double?
    var goodPostureRange : Double = 0.1 //약 5.7도
    var disturbMode : Bool = false
    var notiCycle: Double = 10 //TODO: 10초 -> 10분으로 수정
    var notificationMode: NotificationMode?
}
