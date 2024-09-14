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

private var modelContainer: ModelContainer = {
    let schema = Schema([NotiStatistic.self])
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
    var user = UserManager().loadUser() ??  User(isFirst: true)
    
    var body: some Scene {
        WindowGroup {
            if user.isFirst == true {
                ContentView()
                    .environment(\.appDelegate, appDelegate)
                    .modelContainer(modelContainer)
                    .frame(width: 560, height: 532)
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
    private var launchWindowController: NSWindowController?
    private var settingWindowController: NSWindowController?
    private var alwaysOnTopWindowController: NSWindowController?
    private var measureWindowController: NSWindowController?
    private var statusItem: NSStatusItem!
    private var popover: NSPopover!
    private var isMenuBarIconVisible = false
    private var user = UserManager().loadUser() ??  User(isFirst: true)
    
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
        
        if !user.isFirst {
            openLaunchScreenView()
        }
        
        let mainView = MainView()
            .environment(\.appDelegate, self)
            .modelContainer(modelContainer)
        
        popover.contentViewController = NSHostingController(rootView: mainView)
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.banner, .sound])
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
        let newWindow = NSWindow(contentRect: NSMakeRect(0, 0, 560, 560),
                                 styleMask: [.borderless], // 제목 바 없는 스타일
                                 backing: .buffered,
                                 defer: false)
        
        newWindow.backgroundColor = .clear
        
        let visualEffectView = NSVisualEffectView()
        visualEffectView.translatesAutoresizingMaskIntoConstraints = false
        visualEffectView.wantsLayer = true
        visualEffectView.layer?.cornerRadius = 10.0

        
        let hostingView = NSHostingView(rootView: LaunchScreenView().environment(\.appDelegate, self).modelContainer(modelContainer))
        hostingView.frame = visualEffectView.bounds
        hostingView.autoresizingMask = [.width, .height]
        ///
        visualEffectView.addSubview(hostingView)
        
        newWindow.contentView = visualEffectView
        
        newWindow.isReleasedWhenClosed = false
        newWindow.center()
        newWindow.level = .floating
        newWindow.setFrameAutosaveName("LaunchScreenWindow")
        
        guard let constraints =  newWindow.contentView else {
          return
        }

        visualEffectView.leadingAnchor.constraint(equalTo: constraints.leadingAnchor).isActive = true
        visualEffectView.trailingAnchor.constraint(equalTo: constraints.trailingAnchor).isActive = true
        visualEffectView.topAnchor.constraint(equalTo: constraints.topAnchor).isActive = true
        visualEffectView.bottomAnchor.constraint(equalTo: constraints.bottomAnchor).isActive = true
        
        
        launchWindowController = NSWindowController(window: newWindow)
        launchWindowController?.showWindow(self)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.createMenuBarIcon()
            newWindow.close()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                self.showPopover()
            }
        }
    }
    
    func openAlwaysOnTopView(motionManager: HeadphoneMotionManager) {
        let newWindow = NSWindow(contentRect: NSMakeRect(100, 100, 286, 160),
                                 styleMask: [.titled, .closable, .fullSizeContentView],
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
        let hostingView = NSHostingView(rootView: PIPView( motionManager: motionManager).environment(\.appDelegate, self).modelContainer(modelContainer))
        hostingView.frame = visualEffectView.bounds
        hostingView.autoresizingMask = [.width, .height]
        
        // visualEffectView에 hostingView 추가
        visualEffectView.addSubview(hostingView)
        
        newWindow.contentView = visualEffectView
        
        newWindow.center()
        newWindow.level = .floating
        newWindow.isMovableByWindowBackground = true
        newWindow.setFrameAutosaveName("AlwaysOnTopWindow")
        
        if alwaysOnTopWindowController == nil {
            alwaysOnTopWindowController = NSWindowController(window: newWindow)
            alwaysOnTopWindowController?.showWindow(self)
        }
        else{
            alwaysOnTopWindowController?.window?.makeKeyAndOrderFront(nil)
        }
    }
    
    func openSettingView(motionManager: HeadphoneMotionManager) {
        let newWindow = NSWindow(contentRect: NSMakeRect(100, 100, 560, 684),
                                 styleMask: [.titled, .closable, .resizable],
                                 backing: .buffered,
                                 defer: false)
        
        newWindow.title = "TurtleNeck"
        newWindow.backgroundColor = .white
        
        newWindow.center()
        newWindow.level = .floating
        newWindow.isMovableByWindowBackground = true
        newWindow.setFrameAutosaveName("SettingWindow")
        
        newWindow.contentView = NSHostingView(rootView: SettingView(motionManager: motionManager).environment(\.appDelegate, self).modelContainer(modelContainer))
        
        newWindow.delegate = self
        if settingWindowController == nil {
            settingWindowController = NSWindowController(window: newWindow)
            settingWindowController?.showWindow(self)
        }
        else{
            settingWindowController?.window?.makeKeyAndOrderFront(nil)
        }
    }
    
    func openMeasureView() {
        let newWindow = NSWindow(contentRect: NSMakeRect(100, 100, 560, 532),
                                 styleMask: [.titled, .closable, .resizable],
                                 backing: .buffered,
                                 defer: false)
        
        newWindow.title = "TurtleNeck"
        newWindow.backgroundColor = .white
        
        newWindow.center()
        newWindow.level = .normal
        newWindow.isMovableByWindowBackground = true
        newWindow.setFrameAutosaveName("MeasureWindow")
        
        newWindow.contentView = NSHostingView(rootView: 
                                                ContentView(isFromSetting: true)
            .environment(\.appDelegate, self)
            .modelContainer(modelContainer)
            .background(.white))
        
        newWindow.delegate = self
        if measureWindowController == nil {
            measureWindowController = NSWindowController(window: newWindow)
            measureWindowController?.showWindow(self)
        }
        else{
            measureWindowController?.window?.makeKeyAndOrderFront(nil)
        }
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
