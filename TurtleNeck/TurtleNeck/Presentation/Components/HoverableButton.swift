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
    
    @State private var isHovered: Bool = false
    
    var body: some View {
        Button(action: action) {
            Text(label)
                .frame(width: 200, height: 33)
                .font(.crBodyRegular)
                .foregroundColor(.buttonText)
                .background(isHovered ? Color.buttonHover : Color.clear)
                .cornerRadius(12)
        }
        .buttonStyle(.plain)
        .onHover { hovering in
            isHovered = hovering
        }
    }
}

//#Preview {
//    HoverableButton()
//}
