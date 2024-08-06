//
//  CharacterNotiViewModel.swift
//  TurtleNeck
//
//  Created by 박준우 on 8/7/24.
//

import SwiftUI

class CharacterNotiViewModel {
    
    var panel: CharacterNotiManager?
    
    func appearCharacter() {
        panel?.setCharacterNoti()
    }
    
    func disappearCharacter() {
        panel?.removeCharacterNoti()
    }
}
