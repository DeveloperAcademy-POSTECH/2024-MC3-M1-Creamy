//
//  Int+.swift
//  TurtleNeck
//
//  Created by Doran on 8/11/24.
//

import Foundation

extension Int {
    func formattedTime() -> String {
        let minutes = (self % 3600) / 60
        let secs = self % 60
        
        if minutes > 0 {
            return String(format: "%01d분%01d초", minutes, secs)
        } else {
            return String(format: "%01d초", secs)
        }
    }
}
