//
//  StatisticView.swift
//  TurtleNeck
//
//  Created by Doran on 7/31/24.
//

import SwiftUI

struct StatisticView: View {
    @State private var isToday: Bool = true
    @ObservedObject var motionManager: HeadphoneMotionManager
    @Binding var time: Int
    let user: User = UserManager().loadUser() ?? User(isFirst: true)
    
    var body: some View {
        if(user.notificationMode == .posture){
            posturePostureView.padding(.horizontal,8)
        }
        else{
            defaultModePostureView
        }
    }
    
    private var posturePostureView: some View {
        VStack{
            HStack {
                Button(action: {
                    withAnimation {
                        isToday.toggle()
                    }
                }) {
                    Image(systemName: "chevron.left")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 11,height: 24)
                        .foregroundColor(.chevron)
                        .opacity(isToday ? 0 : 1)
                }
                .disabled(isToday)
                .buttonStyle(.plain)
                
                showView(isToday: isToday)
                    .frame(width: 251).padding(.horizontal,14)
                    .animation(.easeInOut, value: isToday)
                
                Button(action: {
                    withAnimation {
                        isToday.toggle()
                    }
                }) {
                    Image(systemName: "chevron.right")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 11,height: 24)
                        .foregroundColor(.chevron)
                        .opacity(isToday ? 1 : 0)
                }
                .disabled(!isToday)
                .buttonStyle(.plain)
            }
            Spacer()
        }
    }
    
    private var defaultModePostureView: some View {
        VStack{
            Image("CryingNotAirpodTurtle").resizable().scaledToFit().frame(width: 100,height: 100).padding(.top,8)
            Text("자세 알림을 선택했을 경우에만\n 사용할 수 있어요.").font(.pretendardRegular14).foregroundColor(.black)
                .multilineTextAlignment(.center)
                    .lineSpacing(4)
                    .padding(.top, 22)
            Spacer()
        } .frame(width: 251).padding(.horizontal,14)
    }
}

extension StatisticView {
    @ViewBuilder
    private func showView(isToday: Bool) -> some View {
        if isToday {
            DayPostureView(time: $time)
                .transition(.move(edge: .leading))
        }
        else {
            WeekPostureView()
                .transition(.move(edge: .trailing))
        }
    }
}

