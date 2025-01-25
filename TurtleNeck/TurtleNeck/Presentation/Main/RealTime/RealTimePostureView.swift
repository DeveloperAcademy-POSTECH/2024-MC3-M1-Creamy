//
//  RealTimePostureView.swift
//  TurtleNeck
//
//  Created by Doran on 7/27/24.
//

import SwiftUI

struct RealTimePostureView: View {
    @EnvironmentObject private var statisticManager: StatisticManager
    @EnvironmentObject private var userManager: UserManager
    @ObservedObject var motionManager: HeadphoneMotionManager
    @ObservedObject var timerManager: TimerManager
    
    
    var body: some View {
        VStack(spacing:0){
            if userManager.user.notificationMode == .posture {
                if motionManager.isConnected {
                    //자세 알림 모드 & 에어팟 o
                    if timerManager.timer != nil {
                        VStack(spacing: 0){
                            Text(formattedTime(from: timerManager.timerValue)).font(.tnHeadline20).foregroundColor(.black)
                            Text("바른 자세 유지 중!").font(.tnBodyRegular12).foregroundColor(.black).padding(.top, 4)
                            ZStack{
                                RoundedRectangle(cornerRadius: 4)
                                    .fill(statisticManager.statistics.last?.bestRecord ?? 0 < timerManager.timerValue ? Color.bestRecordBG : Color.white)
                                    .frame(width: 57, height: 16)
                                Text("최고 기록!").font(.tnBodyRegular10).foregroundColor(statisticManager.statistics.last?.bestRecord ?? 0 < timerManager.timerValue ? .bestRecordText : Color.white)
                            }
                            .padding(.top, 4)
                        }
                        .frame(height: 68)
                        .padding(.top, 14)
                    }
                    
                    else {
                        VStack(spacing: 0){
                            Text("자세를 다시 바르게 해주세요.").font(.tnBodyRegular14).foregroundColor(.black)
                            Spacer()
                        }
                        .frame(height: 50)
                        .padding(.top, 32)
                    }
                }
                else {
                    //자세 알림 모드 & 에어팟 x
                    VStack(spacing: 0){
                        Text("에어팟을 착용해 주세요.").font(.tnBodyRegular14).foregroundColor(.black)
                        Spacer()
                    }
                    .frame(height: 50)
                    .padding(.top, 32)
                }
            }
            else {
                //기본 알림 모드
                VStack(spacing: 0){
                    Text("중간중간 천장을 바라보는\n스트레칭을 해주세요.").font(.tnBodyRegular14).foregroundColor(.black).multilineTextAlignment(.center)
                        .lineSpacing(4)
                    Spacer()
                }
                .frame(height: 60)
                .padding(.top, 22)
            }
            
            TurtleView(motionManager: motionManager)
                .environmentObject(userManager)
                .offset(x: -16,y: 18)
        }
    }
}
