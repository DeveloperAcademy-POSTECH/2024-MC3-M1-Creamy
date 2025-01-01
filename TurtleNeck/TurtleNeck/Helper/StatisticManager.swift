//
//  StatisticManager.swift
//  TurtleNeck
//
//  Created by Doran on 12/29/24.
//

import SwiftUI

class StatisticManager: ObservableObject {
    @AppStorage("statistics") private var statisticsData: Data = Data()
    @Published var statistics: [Statistic] = []
    
    init() {
        loadStatistics()
    }
    
    func addStatistic(_ statistic: Statistic) {
        statistics.append(statistic)
        saveStatistics()
    }
    
    func loadStatistics() {
        if let decodedStatistics = try? JSONDecoder().decode([Statistic].self, from: statisticsData) {
            self.statistics = decodedStatistics
        }
    }
    
    func saveStatistics() {
        if let encodedData = try? JSONEncoder().encode(statistics) {
            statisticsData = encodedData
        }
    }
    
    func getStatistics() -> [Statistic] {
        return statistics
    }
    
    func deleteStatistics(at indexSet: IndexSet) {
        statistics.remove(atOffsets: indexSet)
        saveStatistics()
    }
    
    func deleteAllData() {
        statistics.removeAll()
        saveStatistics()
    }
}
