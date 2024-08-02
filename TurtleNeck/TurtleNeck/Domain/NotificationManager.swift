//
//  notiManager.swift
//  TurtleNeck
//
//  Created by 박준우 on 7/29/24.
//

import Foundation
import UserNotifications

// TODO: enum 정리하기
enum NotiContent: Int {
    case worse1 = 1
    case worse2 = 2
    case worse3 = 3
    
    case bad1 = 4
    case bad2 = 5
    case bad3 = 6
    
    case good1 = 7
    case good2 = 8
    case good3 = 9
    
    case normal1 = 10
    case normal2 = 11
    case normal3 = 12
    case normal4 = 13
    
    var title: String {
        switch self {
        case .worse1: return "띵동"
        case .worse2: return "어이 친구🐢"
        case .worse3: return "(속닥) 저기…"
            
        case .bad1: return "거북이 되기 10초 전이에요🐢"
        case .bad2: return "자세가 흐트러지고 있어요"
        case .bad3: return "자세 점검 나왔습니다!"
            
        case .good1: return "지금 자세 아주 좋아요~!"
        case .good2: return "이대로만 유지해 주세요"
        case .good3: return "좋은 자세는 성공을 위한 첫 단계!"
            
        case .normal1: return "어라 천장에…!"
        case .normal2: return "지금 잘 앉아계신가요?"
        case .normal3: return "그거아세요?"
        case .normal4: return "스트레칭 타임🤸"
        }
    }
    
    var body: String {
        switch self {
        case .worse1: return "잠시 후 용궁행  버스가 도착합니다🚌"
        case .worse2: return "나랑 같이 바다 산책 갈래?"
        case .worse3: return "척추수술 2000만 원…"
            
        case .bad1: return "어라라"
        case .bad2: return "어라?"
        case .bad3: return "띵동🔔"
            
        case .good1: return "짝짝짝👏"
        case .good2: return "짝짝짝👏"
        case .good3: return "짝짝짝👏"
            
        case .normal1: return "잠시 스트레칭을 해보는 건 어떨까요⭐"
        case .normal2: return "모니터와 너무 가까워지진 않았나요?"
        case .normal3: return "척추수술 2000만 원이래요!"
        case .normal4: return "작업 중간중간 스트레칭 잊지 마세요!"
        }
    }
}

class NotificationManager {
    
    private let notiCenter = UNUserNotificationCenter.current()
    
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
    private func requestNotiPermission() {
        notiCenter.requestAuthorization(options: [.alert, .badge, .sound]) { isGranted, error in
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
    // TODO: state 값(어떤 알림을 설정할지 결정하는 값) 어떤 형태의 값으로 할지 결정하기
    func settingTimeNoti(state: String) {
        
        var randomInt = 0
        var notiCycle = 1.0
        
        switch state {
        case "worse":
            randomInt = Int.random(in: 1...3)
            
        case "bad":
            randomInt = Int.random(in: 4...6)
            notiCycle = 5
            
        case "good":
            randomInt = Int.random(in: 7...9)
            
        case "normal":
            randomInt = Int.random(in: 10...13)
            // TODO: 유저가 설정한 notiCycle 값 받아오기
            notiCycle = 600
            
        default:
            randomInt = Int.random(in: 10...13)
        }
        
        let notiContent = UNMutableNotificationContent()
        notiContent.title = NotiContent(rawValue: randomInt)!.title
        notiContent.body = NotiContent(rawValue: randomInt)!.body
        notiContent.sound = .default
        
        // UNNotificationAttachment 생성 및 할당
        /*
        guard let imgURL = Bundle.main.urlForImageResource("gubook3") else {
            print("이미지 url 생성 오류")
            return
        }
        
        do{
            notiContent.attachments = try [UNNotificationAttachment(identifier: "gubook3", url: imgURL)]
        }
        catch{
            print("알림 attachment 생성 오류")
            return
        }
         */
        
        let notiTrigger = UNTimeIntervalNotificationTrigger(timeInterval: notiCycle, repeats: false)
        let id = UUID().uuidString
        let notiRequest = UNNotificationRequest(identifier: id, content: notiContent, trigger: notiTrigger)
        notiCenter.add(notiRequest) { error in
            if (error != nil){
                print("알림 추가 오류: \(error.debugDescription)")
            }
        }
    }
    
    // 설정된 알림 전체 제거하기
    func removeTimeNoti() {
        notiCenter.removeAllPendingNotificationRequests()
    }
}
