//
//  CharacterNotiManager.swift
//  TurtleNeck
//
//  Created by 박준우 on 8/7/24.
//

import AppKit
import SwiftUI

class CharacterNotiManager: NSPanel {
    
    private var viewPosition : CGPoint
    private var viewSize : CGSize
    private let viewModel = CharacterNotiViewModel()
    private var isPanelOpen : Bool = false
    
    init(position: NSRect, imgName: String) {
        self.viewPosition = CGPoint(x: position.origin.x, y: position.origin.y)
        self.viewSize = CGSize(width: position.width, height: position.height)
        
        super.init(contentRect: NSRect(x: viewPosition.x, y: -viewSize.height, width: viewSize.width, height: viewSize.height), styleMask: [.fullSizeContentView, .nonactivatingPanel], backing: .buffered, defer: false)
        
        backgroundColor = .clear
        isFloatingPanel = true
        viewModel.panel = self
        contentView = NSHostingView(rootView: CharacterNotiView(viewModel: viewModel, viewSize: viewSize, imgName: imgName))
    }
    
    // 캐릭터 알림 설정
    func setCharacterNoti() {
        if !(self.isPanelOpen){
            self.orderFront(nil)
            NSAnimationContext.runAnimationGroup({ context in
                let newFrame = NSRect(x: viewPosition.x, y: 0, width: viewSize.width, height: viewSize.height)
                context.duration = 4
                self.animator().setFrame(newFrame, display: true)
            }, completionHandler: {
                self.isPanelOpen = true
            })
        }
    }
    
    // 캐릭터 알림 제거
    func removeCharacterNoti(isWithTouch: Bool = false) {
        
        NSAnimationContext.runAnimationGroup({ context in
            let newFrame = NSRect(x: viewPosition.x, y: -viewSize.height, width: viewSize.width, height: viewSize.height)
            context.duration = 2
            self.animator().setFrame(newFrame, display: true)
        }, completionHandler: {
            self.orderOut(nil)
            self.isPanelOpen = false
        })
    }
}
