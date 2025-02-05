//
//  DayPostureView.swift
//  TurtleNeck
//
//  Created by Doran on 7/31/24.
//

import SwiftUI

struct DayPostureView: View {
    @EnvironmentObject private var statisticManager: StatisticManager
    @ObservedObject var timerManager: TimerManager
    
    var body: some View {
        VStack(spacing: 0){
            Image("SmileTurtle").resizable().scaledToFit().frame(width: 100,height: 100).padding(.top,16)
            Text("오늘의 최고기록").font(.tnBodyRegular12).foregroundColor(.black).padding(.top, 14)
            
            let highestRecord = max((statisticManager.statistics.last?.bestRecord ?? 0), 0)
            Text(highestRecord.formattedTime()).font(.tnHeadline20).foregroundColor(.black).padding(.top, 4)
        }
    }
}
