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
    
    var body: some View {
        if(motionManager.isConnected){
            connectedAirpodView.padding(.horizontal,8)
        }
        else{
            disConnectedAirpodView
        }
    }
    
    private var connectedAirpodView: some View {
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
    
    private var disConnectedAirpodView: some View {
        VStack{
            Image("CryingNotAirpodTurtle").resizable().scaledToFit().frame(width: 100,height: 100).padding(.top,32)
            Text("에어팟을 착용하지 않으면").font(.pretendardRegular12).foregroundColor(.black).padding(.top,8)
            Text("계산이 불가능해요.").font(.pretendardRegular12).foregroundColor(.black)
            Spacer()
        } .frame(width: 251).padding(.horizontal,14)
    }
}

extension StatisticView {
    @ViewBuilder
    private func showView(isToday: Bool) -> some View {
        if isToday {
           DayPostureView()
                .transition(.move(edge: .trailing))
        }
        else {
            WeekPostureView()
                .transition(.move(edge: .leading))
        }
    }
}

