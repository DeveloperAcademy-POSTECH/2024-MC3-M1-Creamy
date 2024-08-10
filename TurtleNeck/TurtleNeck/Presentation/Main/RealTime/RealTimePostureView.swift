//
//  RealTimePostureView.swift
//  TurtleNeck
//
//  Created by Doran on 7/27/24.
//

import SwiftUI

struct RealTimePostureView: View {
    @ObservedObject var motionManager: HeadphoneMotionManager
    @Binding var time: Int
    let user: User = UserManager().loadUser() ?? User(isFirst: true)
    
    
    var body: some View {
        VStack(spacing:0){
            if user.notificationMode == .posture {
                if motionManager.isConnected {
                    //자세 알림 모드 & 에어팟 o
                    VStack(spacing: 0){
                        Text(formattedTime(from: time)).font(.pretendardSemiBold20).foregroundColor(.black)
                        Text("바른 자세 유지 중!").font(.pretendardRegular14).foregroundColor(.black).padding(.top, 4)
                    }
                    .frame(height: 44)
                    .padding(.top, 14)
                }
                else {
                    //자세 알림 모드 & 에어팟 x
                    VStack{
                        Text("에어팟을 착용해 주세요.").font(.pretendardRegular14).foregroundColor(.black)
                    }
                    .frame(height: 37)
                    .padding(.top, 21)
                }
            }
            else {
                //기본 알림 모드
                VStack(spacing: 0){
                    Text("중간중간 천장을 바라보는\n스트레칭을 해주세요.").font(.pretendardRegular14).foregroundColor(.black).multilineTextAlignment(.center)
                        .lineSpacing(4)
                }
                .frame(height: 46)
                .padding(.top, 12)
            }
            TurtleView(motionManager: motionManager)
                .offset(x: -16, y: 36)
        }
        
        Spacer()
    }
}

extension RealTimePostureView {
    private func formattedTime(from seconds: Int) -> String {
        let hours = seconds / 3600
        let minutes = (seconds % 3600) / 60
        let secs = seconds % 60
        
        if hours > 0 {
            return String(format: "%02d시간 %02d분 %02d초", hours, minutes, secs) // HH:mm:ss
        } else if minutes > 0 {
            return String(format: "%02d분 %02d초", minutes, secs) // mm:ss
        } else {
            return String(format: "%02d초", secs) // ss
        }
    }
}
