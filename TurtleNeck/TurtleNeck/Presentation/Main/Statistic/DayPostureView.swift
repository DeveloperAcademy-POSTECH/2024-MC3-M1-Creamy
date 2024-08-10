//
//  DayPostureView.swift
//  TurtleNeck
//
//  Created by Doran on 7/31/24.
//

import SwiftUI
import SwiftData

struct DayPostureView: View {
    @Binding var time: Int
    @Query var statistic: [NotiStatistic]
    
    var body: some View {
        VStack(spacing: 0){
            Image("SmileTurtle").resizable().scaledToFit().frame(width: 100,height: 100).padding(.top,16)
            Text("오늘의 최고기록").font(.pretendardRegular12).foregroundColor(.black).padding(.top, 14)
            
            let highestRecord = max(statistic.last?.bestRecord ?? 0, time)
            Text(formattedTime(from: highestRecord)).font(.pretendardSemiBold20).foregroundColor(.black).padding(.top, 4)
            
        }
    }
}

extension DayPostureView {
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
