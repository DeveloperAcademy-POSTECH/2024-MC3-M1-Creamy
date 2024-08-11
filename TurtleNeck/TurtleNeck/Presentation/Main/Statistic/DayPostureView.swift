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
            Text("오늘의 최고기록").font(.tnBodyRegular12).foregroundColor(.black).padding(.top, 14)
            
//            let highestRecord = max(statistic.last?.bestRecord ?? 0, time)
            Text(formattedTime(from: statistic.last?.bestRecord ?? 0)).font(.tnHeadline20).foregroundColor(.black).padding(.top, 4)
            
        }
    }
}
