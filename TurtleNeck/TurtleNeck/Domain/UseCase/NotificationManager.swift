//
//  notiManager.swift
//  TurtleNeck
//
//  Created by 박준우 on 7/29/24.
//

import Foundation
import UserNotifications

class NotificationManager {
    
    private let notiCenter = UNUserNotificationCenter.current()
    private var userData: User = User(isFirst: true)
    private var notiTimer: Timer?
    
    init() {
        let userManager = UserManager()
        if let loadedUserData = userManager.loadUser() {
            self.userData = loadedUserData
        }
    }
    
    // 알림 권한 상태 받아오기
    func fetchNotiPermissionState() {
        
        notiCenter.getNotificationSettings { setting in
            
            switch setting.authorizationStatus {
            case .notDetermined:
                print("알림 권한 미설정 상태")
                // TODO: 알림 권한 미설정 상태일 경우 권한 요청 자동으로 할지 결정하기
                self.requestNotiPermission()
            case .denied:
                print("알림 권한 불허용 상태")
            case .authorized:
                print("알림 권한 허용 상태")
            case .provisional:
                print("알림 권한 임시 허용 상태")
            case .ephemeral:
                // App Clip only
                print("알림 권한 일정시간 허용 상태")
            default:
                print("알림 권한 상태 가져오기 오류")
            }
        }
    }
    
    // 알림 권한 요청하기
    func requestNotiPermission() {
        
        notiCenter.requestAuthorization(options: [.alert, .sound]) { isGranted, error in
            if (isGranted) && (error == nil) {
                print("알림 권한 허용")
            }
            else if (!isGranted) {
                print("알림 권한 거부")
            }
            else{
                print("알림 권한 오류: \(error.debugDescription)")
            }
        }
    }
    
    // 알림 설정하기
    func settingTimeNoti(state: NotiContentState) {
        print("notificiationManager settingTimeNoti, \(state)")
        if state == .normal {
            self.notiTimer?.invalidate()
            self.notiTimer = nil
            
            let notiCycle = getNotiCycle(state: state)
            self.notiTimer = Timer.scheduledTimer(withTimeInterval: notiCycle, repeats: true) { _ in
                let id = UUID().uuidString
                let notiContent = self.getNotiContent(state: state)
                let notiTrigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
                let notiRequest = UNNotificationRequest(identifier: id, content: notiContent, trigger: notiTrigger)
                self.notiCenter.add(notiRequest) { error in
                    if (error != nil){
                        print("알림 추가 오류: \(error.debugDescription)")
                    }
                }
            }
        }
        else {
            self.notiTimer?.invalidate()
            self.notiTimer = nil
            
            let notiContent = getNotiContent(state: state)
            let notiCycle = getNotiCycle(state: state)
            let id = UUID().uuidString
            let notiTrigger = UNTimeIntervalNotificationTrigger(timeInterval: notiCycle, repeats: userData.notificationMode == .default)
            let notiRequest = UNNotificationRequest(identifier: id, content: notiContent, trigger: notiTrigger)
            notiCenter.add(notiRequest) { error in
                if (error != nil){
                    print("알림 추가 오류: \(error.debugDescription)")
                }
            }
        }
    }
    
    // 설정된 알림 전체 제거하기
    func removeTimeNoti() {
        notiCenter.removeAllPendingNotificationRequests()
    }
    
    // 알림 컨텐츠 가져오기
    private func getNotiContent(state: NotiContentState) -> UNMutableNotificationContent{
        
        switch state {
        case .worse:
            guard let content = WorseNotiContent.contents.randomElement()?.notiContent else{
                return UNMutableNotificationContent()
            }
            return content
        case .bad:
            guard let content = BadNotiContent.contents.randomElement()?.notiContent else{
                return UNMutableNotificationContent()
            }
            return content
        case .good:
            guard let content = GoodNotiContent.contents.randomElement()?.notiContent else{
                return UNMutableNotificationContent()
            }
            return content
        case .normal:
            guard let content = NormalNotiContent.contents.randomElement()?.notiContent else{
                return UNMutableNotificationContent()
            }
            return content
        }
    }
    
    // 알림 주기 가져오기
    private func getNotiCycle(state: NotiContentState) -> Double{
        
        switch state {
        case .worse:
            return userData.worseNotiCycle
        case .bad:
            return userData.badNotiCycle
        case .good:
            return 1
        case .normal:
            return userData.timeNotiCycle
        }
    }
}
