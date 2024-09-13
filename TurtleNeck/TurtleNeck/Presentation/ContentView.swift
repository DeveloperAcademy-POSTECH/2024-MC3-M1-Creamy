//
//  ContentView.swift
//  TurtleNeck
//
//  Created by 박준우 on 7/26/24.
//

import SwiftUI

struct ContentView: View {
    @State var isFirst: Bool = true
    @State var isFromSetting: Bool = false
    @StateObject private var router = Router.shared
    
    var body: some View {
        NavigationStack(path: $router.navPath) {
            if !isFromSetting {
                VStack{
                    NotiPermissionView()
                }
                .navigationDestination(for: Destination.self) { destination in
                    destinationPath(destination: destination)
                }
            }
            else if isFromSetting {
                VStack{
                    MeasureReadyFirstView()
                }
                .navigationDestination(for: Destination.self) { destination in
                    destinationPath(destination: destination)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
