//
//  Router.swift
//  TurtleNeck
//
//  Created by Hyun Jaeyeon on 7/29/24.
//

import Foundation
import SwiftUI

// 가능한 destination들을 enum으로 전부 정의해줌
enum Destination: Codable, Hashable {
    case notiPermission
    case checkDevice
    case motionPermission
    case measureReady
    case measurePosture
    case measureFinish
    case measureError
    case withoutAirpods
}

final class Router: ObservableObject {
    //싱글톤 패턴 적용
    static let shared = Router()
    
    @Published var navPath = NavigationPath()
    
    private init(){}
    
    func navigate(to destination: Destination) {
        navPath.append(destination)
    }
    
    func navigateBack() {
        navPath.removeLast()
    }
    
    func navigateToRoot() {
        navPath.removeLast(navPath.count)
    }
}


//MARK: destination을 관리하는 extension
extension View {
    @ViewBuilder
    func destinationPath(destination: Destination) -> some View {
        switch destination {
        case .notiPermission:
            NotiPermissionView()
        case .checkDevice:
            CheckDeviceView()
        case .motionPermission:
            MotionPermissionView()
        case .measureReady:
            MeasureReadyView()
        case .measurePosture:
            MeasurePostureView()
        case .measureFinish:
            MeasureFinishView()
                .navigationBarBackButtonHidden()
        case .measureError:
            MeasureErrorView()
                .navigationBarBackButtonHidden()
        case .withoutAirpods:
            WithoutAirpodsView()
        }
    }
}
