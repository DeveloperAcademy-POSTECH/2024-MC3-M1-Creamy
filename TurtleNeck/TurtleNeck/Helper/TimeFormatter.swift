//
//  TimeFormatter.swift
//  TurtleNeck
//
//  Created by Doran on 8/11/24.
//

import Foundation

func formattedTime(from seconds: Int) -> String {
    let hours = seconds / 3600
    let minutes = (seconds % 3600) / 60
    let secs = seconds % 60
    
    if hours > 0 {
        return String(format: "%02d시간 %02d분 %02d초", hours, minutes, secs)
    } else if minutes > 0 {
        return String(format: "%02d분 %02d초", minutes, secs)
    } else {
        return String(format: "%02d초", secs)
    }
}
