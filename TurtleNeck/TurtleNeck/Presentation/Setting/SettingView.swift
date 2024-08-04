//
//  SettingView.swift
//  TurtleNeck
//
//  Created by 박준우 on 7/26/24.
//

import SwiftUI

struct SettingView: View {
    @Binding var settingWindow: NSWindow?
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("설정")
            Text("알림 관련")
        }
        .padding()
        .frame(width: 560, height: 712)
        .onDisappear{
            settingWindow = nil
        }
    }
}
