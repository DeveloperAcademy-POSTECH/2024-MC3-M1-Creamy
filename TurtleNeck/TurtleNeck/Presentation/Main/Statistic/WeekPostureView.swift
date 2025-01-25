//
//  WeekPostureView.swift
//  TurtleNeck
//
//  Created by Doran on 7/27/24.
//

import SwiftUI

struct WeekPostureView: View {
    @EnvironmentObject private var statisticManager: StatisticManager

    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            Text("지난 7일간의 최고 기록")
                .font(.tnBodyEmphasized12)
                .foregroundColor(.black)
                .padding(.top, 18)
            
            HStack(alignment: .bottom, spacing: 8) {
                if filteredStatistics.count == 0 {
                    VStack(spacing: 0){
                        Image("CryingTurtle").resizable().scaledToFit().frame(width: 100,height: 100).padding(.top,8)
                        Text("측정된 데이터가 없어요.").font(.tnBodyRegular14).foregroundColor(.black)
                            .multilineTextAlignment(.center)
                                .lineSpacing(4)
                                .padding(.top, 22)
                        Spacer()
                    } .frame(width: 251).padding(.horizontal,14)
                }
                else {
                    ForEach(filteredStatistics) { data in
                        let height = getHeightStatistic(day: data)
                        VStack(spacing: 2) {
                            if data.bestRecord == 0 {
                                Text("no data")
                                    .font(.tnBodyMedium8)
                                    .foregroundColor(.chevron)
                            } else {
                                let averageAlerts = data.bestRecord.formattedTime()
                                Text("\(averageAlerts)")
                                    .font(.tnBodylight8)
                                    .foregroundColor(.black)
                                    .frame(width: 30)
                            }
                            Rectangle()
                                .fill(Color.chart)
                                .frame(width: 16, height: CGFloat(height))
                                .padding(.horizontal, 4.5)
                                .clipShape(
                                    .rect(
                                        topLeadingRadius: 20,
                                        bottomLeadingRadius: 0,
                                        bottomTrailingRadius: 0,
                                        topTrailingRadius: 20
                                    )
                                )
                            Text(formatDate(data.date))
                                .font(.tnBodyRegular10)
                                .foregroundColor(.black)
                                .frame(width: 29)
                        }
                        .frame(width: 30, height: 120,alignment: .bottom)
                    }
                }
            }
            .frame(width: 260, height: 120)
            .padding(EdgeInsets(top: 17, leading: 0, bottom: 8, trailing: 0))
        }
    }
    
    
}

extension WeekPostureView {
    private func getHeightStatistic(day: Statistic) -> Double {
        guard let maxBestRecord = getMaxBestRecord(from: statisticManager.statistics) else {
            return 0
        }

        if day.bestRecord == 0 {
            return 0
        }

        let calculatedHeight = Double(day.bestRecord) * (92 / Double(maxBestRecord))
        return calculatedHeight
    }
    
    private func getMaxBestRecord(from statistics: [Statistic]) -> Int? {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        
        return statistics
            .filter { calendar.startOfDay(for: $0.date) < today }
            .map { $0.bestRecord }
            .max()
    }
    
    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd"
        return formatter.string(from: date)
    }
}

extension WeekPostureView {
    // View에 보여주는 통계 중에 오늘의 데이터를 제외
    private var filteredStatistics: [Statistic] {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        return statisticManager.statistics.filter { calendar.startOfDay(for: $0.date) < today }
    }
}

#Preview {
    
    WeekPostureView().environmentObject(StatisticManager())
}
