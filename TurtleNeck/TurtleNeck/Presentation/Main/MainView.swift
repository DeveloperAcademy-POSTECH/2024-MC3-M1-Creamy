//
//  MainView.swift
//  TurtleNeck
//
//  Created by 박준우 on 7/26/24.
//

import SwiftUI

struct MainView: View {
    @Environment(\.appDelegate) var appDelegate: AppDelegate?
    
    @StateObject private var motionManager = HeadphoneMotionManager()
    @State var isRealTime: Bool = true

    var body: some View {
        VStack(spacing: 0){
            HStack(alignment: .center, spacing: 10){
                Spacer()
                
                segmentView.padding(EdgeInsets(top: 4, leading: 0, bottom: 0, trailing: 16))
                
                TopMenuView(motionManager: motionManager).environment(\.appDelegate, appDelegate)

            }
            .padding(.top, 12)
            
            showView(isRealTime: isRealTime)
        }
        .padding(.horizontal,12)
        .background(.white)
        .frame(width: 348,height: 232)
        .onAppear {
            motionManager.startUpdates()
        }
//        .onDisappear {
//            motionManager.stopUpdates()
//        }
    }
    
    private var segmentView: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.white)
                .frame(width: 140, height: 22)
                .shadow(radius: 1)
        
            HStack(alignment: .center, spacing: 0) {
                Button(action: {
                    isRealTime = true
                }) {
                    ZStack {

                        RoundedRectangle(cornerRadius: 8)
                            .fill(isRealTime ?  Color.iconHoverBG : .white)

                        Text("실시간")
                            .font(.pretendardRegular13)
                            .foregroundColor(isRealTime ? .primary : .chevron)
                    }
                    .frame(width: 69.5, height: 22)
                }
                .buttonStyle(PlainButtonStyle())
                
                Button(action: {
                    isRealTime = false
                }) {
                    ZStack {

                        RoundedRectangle(cornerRadius: 8)
                            .fill(isRealTime ? .white : Color.iconHoverBG)

                        Text("통계")
                            .font(.pretendardRegular13)
                            .foregroundColor(isRealTime ? .chevron : .primary)
                    }
                    .frame(width: 69.5, height: 22)
                }
                .buttonStyle(PlainButtonStyle())
            }
        }
    }

}

extension MainView {
    @ViewBuilder
    private func showView(isRealTime: Bool) -> some View {
        if isRealTime {
            RealTimePostureView(motionManager: motionManager)
        }
        
        else {
            StatisticView()
        }
    }
}

#Preview {
    MainView()
}
