//
//  CharacterNotiView.swift
//  TurtleNeck
//
//  Created by 박준우 on 8/7/24.
//

import SwiftUI

struct CharacterNotiView: View {
    
    var viewModel: CharacterNotiViewModel
    var viewSize: CGSize
    var imgName: String
    
    var body: some View {
        Image(imgName)
            .resizable()
            .frame(width: viewSize.width, height: viewSize.height)
            .onTapGesture {
                viewModel.disappearCharacter()
            }
    }
}
