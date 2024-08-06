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
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.appDelegate, appDelegate)
                .modelContainer(modelContainer)
                .frame(width: 560, height: 560)
                .background(.white)
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
                let img = NSImage(named: "withMax")!
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
    
    func openAlwaysOnTopView(isMute: Binding<Bool>, motionManager: HeadphoneMotionManager){
        let newWindow = NSWindow(contentRect: NSMakeRect(100, 100, 286, 160),
                                 styleMask: [.titled, .closable, .resizable],
                                 backing: .buffered,
                                 defer: false)
        
        newWindow.titlebarAppearsTransparent = true
        newWindow.titleVisibility = .hidden
        newWindow.backgroundColor = .white
        
        newWindow.center()
        newWindow.level = .floating
        newWindow.isMovableByWindowBackground = true
        newWindow.setFrameAutosaveName("AlwaysOnTopWindow")
        
        newWindow.contentView = NSHostingView(rootView: PIPView(isMute: isMute, motionManager: motionManager).environment(\.appDelegate, self))
        
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
        
        newWindow.contentView = NSHostingView(rootView: SettingView())
        
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
