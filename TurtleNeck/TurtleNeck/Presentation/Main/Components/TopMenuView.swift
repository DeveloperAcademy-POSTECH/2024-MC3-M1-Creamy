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
    @Binding var isMute: Bool
    @ObservedObject var motionManager: HeadphoneMotionManager
    
    var body: some View {
        HStack(alignment: .center,spacing: 4) {
            Button(action: {
                isMute.toggle()
            }) {
                Image(isMute ? "speaker": "speaker.slash")
            }
            .buttonStyle(.plain)

            Button(action: action) {
                Image("macwindow.on.rectangle")
            }
            .buttonStyle(.plain)
            
            Button(action: {
                appDelegate?.openSettingView()
            }) {
                Image("gear")
            }
            .buttonStyle(.plain)
        }
    }
}

