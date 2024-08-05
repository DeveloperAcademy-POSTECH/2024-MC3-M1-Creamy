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
        HStack {
            Button(action: {
                isMute.toggle()
            }) {
                Image(systemName: isMute ? "speaker" : "speaker.slash")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 16, height: 16)
                    .foregroundColor(.primary)
            }.buttonStyle(.plain)

            Button(action: action) {
                Image(systemName: "macwindow.on.rectangle")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 17, height: 17)
                    .foregroundColor(.primary)
            }
            .buttonStyle(.plain)
            
            Button(action: {
                appDelegate?.openSettingView()
            }) {
                Image(systemName: "gear")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 16, height: 16)
                    .foregroundColor(.primary)
            }
            .buttonStyle(.plain)
        }
    }
}
