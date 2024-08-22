//
//  User.swift
//  TurtleNeck
//
//  Created by Hyun Jaeyeon on 7/26/24.
//

import Foundation

enum NotificationMode: String, Codable {
    case posture // 자세 알림 모드
    case `default` // 기본 알림 모드
}

struct User: Codable {
    var isFirst: Bool
    var goodPosture: Double?
    var goodPostureRange : Double = 0.1 //약 5.7도
    var disturbMode : Bool = false
    var notiCycle: Double = 10 //TODO: 10초 -> 10분으로 수정
    var notificationMode: NotificationMode?
    var isSoundOn: Bool = true // 알림소리 On/Off: 기본 값 On(true)
    var isNotificationOn: Bool = true // 알림 On/Off: 기본 값 On(true)
    var timeNotiCycle: Double = 15 * 60 // 시간 알림 시간: 기본 값 15분
    var badNotiCycle: Double = 10 // 나쁜 자세 유지 시간(일반 알림): 기본 값 10초
    var worseNotiCycle: Double = 3 * 60 // 나쁜 자세 유지 시간(캐릭터 알림): 기본 값 3분
}
