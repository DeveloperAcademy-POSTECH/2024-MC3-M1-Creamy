//
//  TopMenuView.swift
//  TurtleNeck
//
//  Created by Doran on 8/2/24.
//

import SwiftUI

struct TopMenuView: View {
    let action: () -> Void
    @EnvironmentObject private var userManager: UserManager
    @Environment(\.appDelegate) var appDelegate: AppDelegate?
    @ObservedObject var notificationManager: NotificationManager
    @ObservedObject var motionManager: HeadphoneMotionManager
    @ObservedObject var timerManager: TimerManager
    
    
    var body: some View {
        HStack(alignment: .center,spacing: 4) {
            if !userManager.user.isFirst {
                Button(action: {
                    userManager.user.isSoundOn.toggle()
                    userManager.user.isNotificationOn.toggle()
                    userManager.saveUser()
                }) {
                    Image(userManager.user.isSoundOn && userManager.user.isNotificationOn ? "speaker": "speaker.slash")
                }
                .buttonStyle(.plain)
            }

            Button(action: action) {
                Image("macwindow.on.rectangle")
            }
            .buttonStyle(.plain)
            
            Button(action: {
                appDelegate?.openSettingView(notificationManager: notificationManager, motionManager: motionManager, timerManager: timerManager)
            }) {
                Image("gear")
            }
            .buttonStyle(.plain)
        }
    }
}

