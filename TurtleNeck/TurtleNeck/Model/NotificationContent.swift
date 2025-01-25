//
//  NotificationContent.swift
//  TurtleNeck
//
//  Created by 박준우 on 8/3/24.
//

import Foundation
import UserNotifications

enum NotiContentState: String {
    case worse
    case bad
    case good
    case normal
}

struct NotificationContent{
    let title: String
    let body: String
    let attachmentImgName: String = ""
    let notiContent: UNMutableNotificationContent = UNMutableNotificationContent()
    let userManager = UserManager.shared
    
    init(title: String, body: String) {
        self.title = title
        self.body = body
        self.notiContent.title = title
        self.notiContent.body = body
        self.notiContent.sound = {
            if userManager.user.isFirst {
                if userManager.user.isSoundOn {
                    return .default
                }
                else {
                    return .none
                }
            }
            else {
                return .default
            }
        }()
        
        if let imgURL = Bundle.main.urlForImageResource(self.attachmentImgName) {
            do {
                try notiContent.attachments = [UNNotificationAttachment(identifier: UUID().uuidString, url: imgURL)]
            }
            catch {
                return
            }
        }
    }
}

struct WorseNotiContent{
    static let contents: [NotificationContent] = [
        NotificationContent(title: "띵동", body: "잠시 후 용궁행  버스가 도착합니다🚌"),
        NotificationContent(title: "어이 친구🐢", body: "나랑 같이 바다 산책 갈래?"),
        NotificationContent(title: "(속닥) 저기…", body: "척추수술 2000만 원…")
    ]
}

struct BadNotiContent{
    static let contents: [NotificationContent] = [
        NotificationContent(title: "어라라", body: "거북이 되기 10초 전이에요🐢"),
        NotificationContent(title: "어라?", body: "자세가 흐트러지고 있어요"),
        NotificationContent(title: "띵동🔔", body: "자세 점검 나왔습니다!")
    ]
}

struct GoodNotiContent{
    static let contents: [NotificationContent] = [
        NotificationContent(title: "짝짝짝👏", body: "지금 자세 아주 좋아요~!"),
        NotificationContent(title: "짝짝짝👏", body: "이대로만 유지해 주세요"),
        NotificationContent(title: "짝짝짝👏", body: "좋은 자세는 성공을 위한 첫 단계!")
    ]
}

struct NormalNotiContent{
    static let contents: [NotificationContent] = [
        NotificationContent(title: "어라 천장에…!", body: "잠시 스트레칭을 해보는 건 어떨까요⭐"),
        NotificationContent(title: "지금 잘 앉아계신가요?", body: "모니터와 너무 가까워지진 않았나요?"),
        NotificationContent(title: "그거아세요?", body: "척추수술 2000만 원이래요!"),
        NotificationContent(title: "스트레칭 타임🤸", body: "작업 중간중간 스트레칭 잊지 마세요!")
    ]
}
