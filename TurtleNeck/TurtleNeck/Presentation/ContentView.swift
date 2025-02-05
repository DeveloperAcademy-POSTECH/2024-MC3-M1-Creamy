//
//  ContentView.swift
//  TurtleNeck
//
//  Created by 박준우 on 7/26/24.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject private var userManager: UserManager
    @State var isFromSetting: Bool = false
    @StateObject private var router = NavigationManager.shared
    
    var body: some View {
        NavigationStack(path: $router.navPath) {
            VStack(spacing: 0){
                if !isFromSetting {
                    NotiPermissionView()
                }
                else {
                    MeasureReadyFirstView()
                }
            }
            .navigationDestination(for: Destination.self) { destination in
                destinationPath(destination: destination)
                    .environmentObject(userManager)
            }
        }
    }
}



#Preview {
    ContentView()
}
