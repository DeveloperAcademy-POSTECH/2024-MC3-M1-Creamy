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
    
    @Binding var isMute: Bool
    @ObservedObject var motionManager: HeadphoneMotionManager
    
    var body: some View {
        NavigationStack{
            TurtleView(motionManager: motionManager)
                .offset(x: -16, y: 12)
                .padding(.top, 16)
        }
        .frame(width: 286,height: 130)
        .padding(.horizontal,12)
        .toolbar() {
            Spacer()
            TopMenuView(action: {
                presentationMode.wrappedValue.dismiss()
                appDelegate?.showPopover()
            }, isMute: $isMute, motionManager: motionManager)
        }
    }
}