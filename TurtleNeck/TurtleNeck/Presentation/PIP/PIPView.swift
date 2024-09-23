//
//  PIPView.swift
//  TurtleNeck
//
//  Created by Doran on 8/4/24.
//

import SwiftUI

struct PIPView: View {
    @Environment(\.appDelegate) var appDelegate: AppDelegate?
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject var notificationManager: NotificationManager
    @ObservedObject var motionManager: HeadphoneMotionManager
    @ObservedObject var timerManager: TimerManager
    
    var body: some View {
        
        ZStack{
            TurtleView(motionManager: motionManager)
                .offset(x: -16, y: 12)
                .padding(.top, 16)
            
            TopMenuView(action: {
                NSApplication.shared.keyWindow?.close()
                appDelegate?.showPopover()
            }, notificationManager: notificationManager, motionManager: motionManager, timerManager: timerManager)
            .offset(x: 100, y: -77)
        }
        .frame(width: 286,height: 130)
        .padding(.horizontal,12)
    }
}
