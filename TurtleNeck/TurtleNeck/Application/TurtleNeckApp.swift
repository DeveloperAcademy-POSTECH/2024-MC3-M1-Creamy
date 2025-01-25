//
//  TurtleNeckApp.swift
//  TurtleNeck
//
//  Created by 박준우 on 7/26/24.
//

import SwiftUI
import UserNotifications

@main
struct TurtleNeckApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @StateObject private var statisticManager = StatisticManager()
    @StateObject private var userManager = UserManager.shared
    
    var body: some Scene {
        WindowGroup {
            if userManager.user.isFirst == true {
                ContentView()
                    .environment(\.appDelegate, appDelegate)
                    .environmentObject(statisticManager)
                    .environmentObject(userManager)
                    .frame(width: 560, height: 532)
                    .background(.white)
            }
            EmptyView()
        }
        .windowStyle(.hiddenTitleBar)
        .windowToolbarStyle(.expanded)
        .windowResizability(.contentSize)
    }
}
