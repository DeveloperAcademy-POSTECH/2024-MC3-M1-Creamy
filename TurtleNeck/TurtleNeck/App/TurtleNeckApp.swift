//
//  TurtleNeckApp.swift
//  TurtleNeck
//
//  Created by 박준우 on 7/26/24.
//

import Foundation
import SwiftUI
import SwiftData

@main
struct TurtleNeckApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var modelContainer: ModelContainer = {
        let schema = Schema([User.self, NotiStatistic.self])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
        
        do {
            return try ModelContainer(for: schema,
                                      configurations: [modelConfiguration])
        } catch {
            fatalError("modelContainer가 생성되지 않았습니다: \(error)")
        }
    }()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .frame(width: 560, height: 560)
                .background(.white)
        }
        .windowStyle(.hiddenTitleBar)
        .windowToolbarStyle(.expanded)
        .windowResizability(.contentSize)
        
        MenuBarExtra("TurtleNeckApp", systemImage: "tortoise.fill") {
            MainView()
                .frame(width: 344,height: 240)
        }.menuBarExtraStyle(.window)
    }
}


class AppDelegate: NSObject, NSApplicationDelegate {
    func applicationDidFinishLaunching(_ notification: Notification) {
        /// 강제 라이트모드 설정
        if let appearance = NSAppearance(named: .aqua) {
            NSApp.appearance = appearance
        }
    }
}
