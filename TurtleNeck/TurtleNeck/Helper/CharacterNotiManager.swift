//
//  CharacterNotiManager.swift
//  TurtleNeck
//
//  Created by 박준우 on 8/7/24.
//

import AppKit
import SwiftUI

class CharacterNotiManager: NSPanel, ObservableObject {
    
    @Published var isAppearing: Bool = false
    
    private var contentSize : CGSize = CGSize(width: 235, height: 145)
    private var contentPosition : CGPoint
    
    init() {
        print("CharacterNotiManager init")
        self.contentPosition = CGPoint(x: NSScreen.main!.frame.size.width - self.contentSize.width, y: -self.contentSize.height)
        
        super.init(contentRect: NSRect(x: contentPosition.x + contentSize.width, y: contentSize.height, width: contentSize.width, height: contentSize.height), styleMask: [.fullSizeContentView, .nonactivatingPanel], backing: .buffered, defer: false)
        
        backgroundColor = .clear
        isFloatingPanel = true
        hasShadow = false
        level = .floating
        isReleasedWhenClosed = true
        collectionBehavior = [.canJoinAllSpaces, .fullScreenAuxiliary]
    }
    
    // 캐릭터 알림 설정
    func setCharacterNoti() {
        self.isAppearing = true
        self.contentView = NSHostingView(rootView: CharacterNotiView(viewSize: contentSize, characterNotiManager: self))
        self.orderFront(nil)
        NSAnimationContext.runAnimationGroup({ context in
            let newFrame = NSRect(x: contentPosition.x + 35, y: contentSize.height, width: contentSize.width, height: contentSize.height)
            context.duration = 2
            self.animator().setFrame(newFrame, display: true)
        }, completionHandler: {})
    }
    
    // 캐릭터 알림 제거
    func removeCharacterNoti() {
        self.isAppearing = false
        NSAnimationContext.runAnimationGroup({ context in
            let newFrame = NSRect(x: contentPosition.x + contentSize.width, y: 0, width: contentSize.width, height: contentSize.height)
            context.duration = 2
            self.animator().setFrame(newFrame, display: true)
        }, completionHandler: {
            self.orderOut(nil)
            self.contentView = nil
        })
    }
}
