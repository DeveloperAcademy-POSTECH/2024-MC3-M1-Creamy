//
//  TurtleNeckApp.swift
//  TurtleNeck
//
//  Created by 박준우 on 7/26/24.
//

import Foundation
import SwiftUI
import SwiftData
import UserNotifications

var modelContainer: ModelContainer = {
    let schema = Schema([User.self, NotiStatistic.self])
    let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
     
    do {
        return try ModelContainer(for: schema,
                                  configurations: [modelConfiguration])
    } catch {
        fatalError("modelContainer가 생성되지 않았습니다: \(error)")
    }
}()

@main
struct TurtleNeckApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @AppStorage("isFirst") var isFirst: Bool = true
    
    var body: some Scene {
        WindowGroup {
            if isFirst == true {
                ContentView()
                    .environment(\.appDelegate, appDelegate)
                    .modelContainer(modelContainer)
                    .frame(width: 560, height: 560)
                    .background(.white)
            }
            EmptyView()
        }
        .windowStyle(.hiddenTitleBar)
        .windowToolbarStyle(.expanded)
        .windowResizability(.contentSize)
    }
}


class AppDelegate: NSObject, NSApplicationDelegate, UNUserNotificationCenterDelegate {
    var statusItem: NSStatusItem!
    var popover: NSPopover!
    var newWindowController: NSWindowController?
    var isMenuBarIconVisible = false
    @AppStorage("isFirst") var isFirst: Bool = true
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        UNUserNotificationCenter.current().delegate = self
        /// 강제 라이트모드 설정
        if let appearance = NSAppearance(named: .aqua) {
            NSApp.appearance = appearance
        }
        popover = NSPopover()
        popover.setValue(true, forKeyPath: "shouldHideAnchor")
        popover.contentSize = NSSize(width: 348, height: 232)
        popover.behavior = .transient
        
        if !isFirst {
            openLaunchScreenView()
        }
        
        let mainView = MainView()
            .environment(\.appDelegate, self)
            .modelContainer(modelContainer)
        
        popover.contentViewController = NSHostingController(rootView: mainView)
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.badge, .banner, .sound])
    }
    
    func createMenuBarIcon() {
        guard !isMenuBarIconVisible else { return }
        
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        
        /// 강제 라이트모드 설정
        if let appearance = NSAppearance(named: .aqua) {
            NSApp.appearance = appearance
        }
        
        if let button = statusItem.button {
            let image: NSImage = {
                let img = NSImage(named: "menubarIcon")!
                let ratio = img.size.height / img.size.width
                img.size.height = 30
                img.size.width = 30 / ratio
                return img
            }()
            
            button.image = image
            button.action = #selector(togglePopover(_:))
        }
        
        isMenuBarIconVisible = true
    }
    
    @objc func togglePopover(_ sender: Any?) {
        if popover.isShown {
            popover.performClose(sender)
        } else {
            showPopover()
        }
    }
    
    func showPopover() {
        if let button = statusItem.button {
            popover.show(relativeTo: button.bounds, of: button, preferredEdge: NSRectEdge.minY)
        }
    }
    
    func openLaunchScreenView(){
        let contentView = LaunchScreenView()
        let newWindow = NSWindow(contentRect: NSMakeRect(0, 0, 560, 560),
                                 styleMask: [.borderless], // 제목 바 없는 스타일
                                 backing: .buffered,
                                 defer: false)
        
        newWindow.isReleasedWhenClosed = false
        newWindow.center()
        newWindow.level = .floating
        newWindow.setFrameAutosaveName("LaunchScreenWindow")
        
        newWindow.contentView = NSHostingView(rootView: LaunchScreenView().environment(\.appDelegate, self).modelContainer(modelContainer))
        
        
        newWindowController = NSWindowController(window: newWindow)
        newWindowController?.showWindow(self)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.createMenuBarIcon()
            newWindow.close()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                self.showPopover()
            }
        }
        
    }
    
    func openAlwaysOnTopView(isMute: Binding<Bool>, motionManager: HeadphoneMotionManager) {
        let newWindow = NSWindow(contentRect: NSMakeRect(100, 100, 286, 160),
                                 styleMask: [.titled, .closable, .resizable, .fullSizeContentView],
                                 backing: .buffered,
                                 defer: false)
        
        newWindow.titlebarAppearsTransparent = true
        newWindow.titleVisibility = .hidden
        
        // NSVisualEffectView 생성 및 설정
        let visualEffectView = NSVisualEffectView(frame: newWindow.contentRect(forFrameRect: newWindow.frame))
        visualEffectView.autoresizingMask = [.width, .height]
        visualEffectView.blendingMode = .behindWindow
        visualEffectView.state = .active
        visualEffectView.material = .light
        
        // NSHostingView 생성
        let hostingView = NSHostingView(rootView: PIPView(isMute: isMute, motionManager: motionManager).environment(\.appDelegate, self).modelContainer(modelContainer))
        hostingView.frame = visualEffectView.bounds
        hostingView.autoresizingMask = [.width, .height]
        
        // visualEffectView에 hostingView 추가
        visualEffectView.addSubview(hostingView)
        
        newWindow.contentView = visualEffectView
        
        newWindow.center()
        newWindow.level = .floating
        newWindow.isMovableByWindowBackground = true
        newWindow.setFrameAutosaveName("AlwaysOnTopWindow")
        
        newWindowController = NSWindowController(window: newWindow)
        newWindowController?.showWindow(self)
    }
    
    func openSettingView() {
        let newWindow = NSWindow(contentRect: NSMakeRect(100, 100, 560, 684),
                                 styleMask: [.titled, .closable, .resizable],
                                 backing: .buffered,
                                 defer: false)
        
        newWindow.title = "TurtleNeck"
        newWindow.backgroundColor = .white
        
        newWindow.center()
        newWindow.level = .normal
        newWindow.isMovableByWindowBackground = true
        newWindow.setFrameAutosaveName("SettingWindow")
        
        newWindow.contentView = NSHostingView(rootView: SettingView().environment(\.appDelegate, self).modelContainer(modelContainer))
        
        newWindow.delegate = self
        
        newWindowController = NSWindowController(window: newWindow)
        newWindowController?.showWindow(self)
    }
}

extension AppDelegate: NSWindowDelegate {
    func windowWillClose(_ notification: Notification) {
        // 팝오버를 다시 열기
        showPopover()
    }
}

private struct AppDelegateKey: EnvironmentKey {
    static let defaultValue: AppDelegate? = nil
}

extension EnvironmentValues {
    var appDelegate: AppDelegate? {
        get { self[AppDelegateKey.self] }
        set { self[AppDelegateKey.self] = newValue }
    }
}
