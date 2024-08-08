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
        HStack(alignment: .center,spacing: 5) {
            Button(action: {
                isMute.toggle()
            }) {
                Image(systemName: isMute ? "speaker" : "speaker.slash")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 17, height: 17)
                    .foregroundColor(.primary)
            }
            .buttonStyle(.plain)
            .padding(.top, 1)

            Button(action: action) {
                Image(systemName: "macwindow.on.rectangle")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 17, height: 17)
                    .foregroundColor(.primary)
            }
            .buttonStyle(.plain)
            .padding(.trailing, 3)
            
            Button(action: {
                appDelegate?.openSettingView()
            }) {
                Image(systemName: "gear")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 17, height: 17)
                    .foregroundColor(.primary)
            }
            .buttonStyle(.plain)
        }
    }
}

