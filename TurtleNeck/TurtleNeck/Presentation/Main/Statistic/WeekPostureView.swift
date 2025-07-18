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
            Text("최근 7일간의 최고 기록")
                .font(.tnBodyEmphasized12)
                .foregroundColor(.black)
                .padding(.top, 18)
            
            HStack(alignment: .bottom, spacing: 8) {
                if past7DaysStatistics.count == 0 {
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
                    ForEach(past7DaysStatistics) { data in
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
        guard let maxBestRecord = getMaxBestRecord(from: past7DaysStatistics) else {
            return 0
        }

        if day.bestRecord == 0 {
            return 0
        }

        // 최소 높이 10, 최대 높이 92로 설정
        let minHeight = 10.0
        let maxHeight = 92.0
        let ratio = Double(day.bestRecord) / Double(maxBestRecord)
        let calculatedHeight = minHeight + (ratio * (maxHeight - minHeight))
        
        return calculatedHeight
    }
    
    private func getMaxBestRecord(from statistics: [Statistic]) -> Int? {
        return statistics
            .map { $0.bestRecord }
            .filter { $0 > 0 }  // 0보다 큰 값만 필터링
            .max()
    }
    
    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd"
        return formatter.string(from: date)
    }
}

extension WeekPostureView {
    // 최근 7일간의 통계 데이터 (오늘부터 7일 전까지)
    private var past7DaysStatistics: [Statistic] {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        let sevenDaysAgo = calendar.date(byAdding: .day, value: -6, to: today)!
        
        // 최근 7일 범위의 모든 날짜 생성
        var past7Days: [Date] = []
        for i in 0..<7 {
            if let date = calendar.date(byAdding: .day, value: -i, to: today) {
                past7Days.append(date)
            }
        }
        past7Days.reverse() // 오래된 날짜부터 정렬
        
        // 각 날짜에 대해 기록이 있으면 해당 기록, 없으면 빈 기록 생성
        return past7Days.map { date in
            let dayStart = calendar.startOfDay(for: date)
            if let existingRecord = statisticManager.statistics.first(where: { calendar.startOfDay(for: $0.date) == dayStart }) {
                return existingRecord
            } else {
                return Statistic(date: date, time: 0, notiCount: 0, bestRecord: 0)
            }
        }
    }
}

#Preview {
    
    WeekPostureView().environmentObject(StatisticManager())
}
