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
        
        MenuBarExtra {
            MainView().frame(width: 348,height: 232)
        } label: {
            let image: NSImage = {
                let ratio = $0.size.height / $0.size.width
                $0.size.height = 30
                $0.size.width = 30 / ratio
                return $0
            }(NSImage(named: "withMax")!)

            Image(nsImage: image)
            
        }
        .menuBarExtraStyle(.window)
    }
}
