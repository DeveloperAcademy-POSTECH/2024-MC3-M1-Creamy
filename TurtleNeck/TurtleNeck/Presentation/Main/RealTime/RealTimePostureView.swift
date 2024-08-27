//
//  RealTimePostureView.swift
//  TurtleNeck
//
//  Created by Doran on 7/27/24.
//

import SwiftUI

struct RealTimePostureView: View {
    @ObservedObject var motionManager: HeadphoneMotionManager
    var timer: Timer?
    @Binding var time: Int
    let user: User = UserManager().loadUser() ?? User(isFirst: true)
    
    
    var body: some View {
        VStack(spacing:0){
            if user.notificationMode == .posture {
                if motionManager.isConnected {
                    //자세 알림 모드 & 에어팟 o
                    if timer != nil {
                        VStack(spacing: 0){
                            Text(formattedTime(from: time)).font(.tnHeadline20).foregroundColor(.black)
                            Text("바른 자세 유지 중!").font(.tnBodyRegular12).foregroundColor(.black).padding(.top, 4)
                        }
                        .frame(height: 44)
                        .padding(.top, 14)
                    }
                    
                    else {
                        VStack(spacing: 0){
                            Text("자세를 다시 바르게 해주세요.").font(.tnBodyRegular14).foregroundColor(.black)
                        }
                        .frame(height: 37)
                        .padding(.top, 21)
                    }
                }
                else {
                    //자세 알림 모드 & 에어팟 x
                    VStack{
                        Text("에어팟을 착용해 주세요.").font(.tnBodyRegular14).foregroundColor(.black)
                    }
                    .frame(height: 37)
                    .padding(.top, 21)
                }
            }
            else {
                //기본 알림 모드
                VStack(spacing: 0){
                    Text("중간중간 천장을 바라보는\n스트레칭을 해주세요.").font(.tnBodyRegular14).foregroundColor(.black).multilineTextAlignment(.center)
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
