//
//  ColorExtension.swift
//  TurtleNeck
//
//  Created by Doran on 7/30/24.
//

import SwiftUI

extension Color {
     
    static let mainText = Color(hex: "000000")
    
    static let subText = Color(hex: "1A1A1A")
    
    static let buttonText = Color(hex: "788A2C")
    
    static let buttonHover = Color(hex: "F8FBE9")
    
    static let chevronHover = Color(hex: "EDF2DB")
    
    static let chevron = Color(hex: "C0CA97")
    
    static let background = Color(hex: "FFFFFF")
    
    static let borderLine = Color(hex: "E5E5E5")
    
    static let settingBG = Color(hex: "FBFBFB")
    
    static let warning = Color(hex: "FBFBFB")
    
    static let captionText = Color(hex: "636363")
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
