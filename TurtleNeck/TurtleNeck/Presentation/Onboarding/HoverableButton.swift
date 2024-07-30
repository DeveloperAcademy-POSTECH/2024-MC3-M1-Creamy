//
//  ButtonView.swift
//  TurtleNeck
//
//  Created by Hyun Jaeyeon on 7/30/24.
//

import SwiftUI

struct HoverableButton: View {
    let action: () -> Void
    let label: String
    let width: CGFloat
    let height: CGFloat
    let defaultBackgroundColor: Color
    let hoverBackgroundColor: Color
    
    @State private var isHovered: Bool = false
    
    var body: some View {
        Button(action: action) {
            Text(label)
                .frame(width: width, height: height)
                .foregroundColor(.primary)
                .background(isHovered ? hoverBackgroundColor : defaultBackgroundColor)
                .cornerRadius(12)
        }
        .buttonStyle(.plain)
        .onHover { hovering in
            isHovered = hovering
        }
    }
}

#Preview {
    HoverableButtonView()
}
