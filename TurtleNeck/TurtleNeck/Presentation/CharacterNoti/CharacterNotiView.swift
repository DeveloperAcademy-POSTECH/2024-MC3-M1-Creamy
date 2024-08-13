//
//  CharacterNotiView.swift
//  TurtleNeck
//
//  Created by 박준우 on 8/7/24.
//

import SwiftUI

struct CharacterNotiView: View {
    
    @ObservedObject var characterNotiManager: CharacterNotiManager
    
    private var viewSize: CGSize
    private var imgName: String = "CharacterNoti2"
    
    init(viewSize: CGSize, characterNotiManager: CharacterNotiManager) {
        self.viewSize = viewSize
        self.characterNotiManager = characterNotiManager
    }
    
    var body: some View {
        Image(imgName)
            .resizable()
            .scaledToFit()
            .frame(width: viewSize.width, height: viewSize.height)
            .rotationEffect(.degrees(characterNotiManager.isAppearing ? 0 : 0))
            .animation(.linear(duration: 1), value: characterNotiManager.isAppearing)
            .onTapGesture {
                characterNotiManager.removeCharacterNoti()
            }
    }
}
