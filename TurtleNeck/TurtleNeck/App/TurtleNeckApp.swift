//
//  TurtleNeckApp.swift
//  TurtleNeck
//
//  Created by 박준우 on 7/26/24.
//

import SwiftUI

@main
struct TurtleNeckApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        
        MenuBarExtra("TurtleNeckApp", systemImage: "tortoise.fill") {
            MainView()
                .frame(width: 344,height: 240)
        }.menuBarExtraStyle(.window)
    }
}
