//
//  WeekPostureView.swift
//  TurtleNeck
//
//  Created by Doran on 7/27/24.
//

import SwiftUI
import SwiftData

struct WeekPostureView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var statistics: [NotiStatistic] // NotiStatistic 배열

    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            Text("지난 7일간의 최고 기록")
                .font(.tnBodyEmphasized12)
                .foregroundColor(.black)
                .padding(.top, 18)
            
            HStack(alignment: .bottom) {
                ForEach(filteredStatistics) { data in // data는 NotiStatistic 타입
                    let height = getHeightStatistic(day: data) // data를 NotiStatistic으로 전달
                    VStack(spacing: 2) {
                        if data.bestRecord == 0 {
                            Text("no data")
                                .font(.tnBodyMedium8)
                                .foregroundColor(.chevron)
                        } else {
                            let averageAlerts = formattedTime(from: data.bestRecord)
                            Text(formattedTime(from: data.bestRecord))
                                .font(.tnBodylight8)
                                .foregroundColor(.black)
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
                }
            }
            .frame(width: 260, height: 120)
            .padding(EdgeInsets(top: 17, leading: 0, bottom: 8, trailing: 0))
        }
    }
    
    
}

extension WeekPostureView {
    
    private func getHeightStatistic(day: NotiStatistic) -> Double {
        guard let maxBestRecord = getMaxBestRecord(from: statistics) else {
            return 0
        }

        if day.bestRecord == 0 {
            return 0
        }

        let calculatedHeight = Double(day.bestRecord) * (92 / Double(maxBestRecord))
        return calculatedHeight
    }
    
    private func getMaxBestRecord(from statistics: [NotiStatistic]) -> Int? {
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
    private var filteredStatistics: [NotiStatistic] {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        return statistics.filter { calendar.startOfDay(for: $0.date) < today }
    }
}
