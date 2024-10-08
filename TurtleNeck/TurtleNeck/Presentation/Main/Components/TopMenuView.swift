//
//  TopMenuView.swift
//  TurtleNeck
//
//  Created by Doran on 8/2/24.
//

import SwiftUI

struct TopMenuView: View {
    @Environment(\.appDelegate) var appDelegate: AppDelegate?
    
    let action: () -> Void
    @ObservedObject var notificationManager: NotificationManager
    @ObservedObject var motionManager: HeadphoneMotionManager
    @ObservedObject var timerManager: TimerManager
    
    let userManager = UserManager()
    
    var body: some View {
        HStack(alignment: .center,spacing: 4) {
            if var user = userManager.loadUser() {
                Button(action: {
                    user.isSoundOn.toggle()
                    user.isNotificationOn.toggle()
                    userManager.saveUser(user)
                }) {
                    Image(user.isSoundOn && user.isNotificationOn ? "speaker": "speaker.slash")
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

