//
//  ContentView.swift
//  TurtleNeck
//
//  Created by 박준우 on 7/26/24.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var router = Router()
    @State var isFirst: Bool = true
    
    var body: some View {
        NavigationStack(path: $router.navPath) {
            VStack{
                if isFirst{
                    NotiPermissionView()
                } else{
                    NotiPermissionView()
                }
            }
            .navigationDestination(for: Router.Destination.self) { destination in
                destinationPath(destination: destination)
            }
        }
        .environmentObject(router)
    }
}

#Preview {
    ContentView()
}
