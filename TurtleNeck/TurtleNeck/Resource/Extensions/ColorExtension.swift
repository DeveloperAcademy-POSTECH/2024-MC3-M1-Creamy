//
//  ColorExtension.swift
//  TurtleNeck
//
//  Created by Doran on 7/30/24.
//

import SwiftUI
//원하는 컬러 생성
extension Color {
    /// 기능에 대한 설명
    static let subTextGray = Color(hex: "1A1A1A")
    /// buttonText + icon에 사용
    static let primary = Color(hex: "788A2C")
    
    static let chevron = Color(hex: "C0CA97")
    
    static let iconHoverBG = Color(hex: "F8FBE9")
    
    static let buttonHoverBG = Color(hex: "EDF2DB")
    
    static let chart = Color(hex: "97B66D")
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
