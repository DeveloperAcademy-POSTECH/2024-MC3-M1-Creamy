//
//  ColorExtension.swift
//  TurtleNeck
//
//  Created by Doran on 7/30/24.
//

import SwiftUI
//원하는 컬러 생성
extension Color {
 
    static let green01 = Color(hex: "788A2C")
    static let green02 = Color(hex: "F8FBE9")
    static let green03 = Color(hex: "C0CA97")
    
}

extension Color {
  init(hex: String) {
    let scanner = Scanner(string: hex)
    _ = scanner.scanString("#")
    
    var rgb: UInt64 = 0
    scanner.scanHexInt64(&rgb)
    
    let r = Double((rgb >> 16) & 0xFF) / 255.0
    let g = Double((rgb >>  8) & 0xFF) / 255.0
    let b = Double((rgb >>  0) & 0xFF) / 255.0
    self.init(red: r, green: g, blue: b)
  }
}
