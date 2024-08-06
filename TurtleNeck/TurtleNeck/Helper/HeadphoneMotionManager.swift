//
//  HeadphoneMotionManager.swift
//  TurtleNeck
//
//  Created by Hyun Jaeyeon on 8/2/24.
//

import Foundation
import CoreMotion

enum PostureState {
    case good   // 나쁜자세 -> 좋은자세
    case bad  // 좋은 자세 -> 나쁜 자세
    case worse    // 나쁜 자세가 계속 지속됨
}

class HeadphoneMotionManager: ObservableObject {
    @Published var isHeadPhoneAuthorized = false
    var isTracking = false
    @Published var pitch: Double = 0.0
    @Published var roll: Double = 0.0
    @Published var yaw: Double = 0.0
    
    private let cmHeadPhoneManager = CMHeadphoneMotionManager()
    
    //TODO: SwiftData에서 goodPosture,Range 가져오기
    var goodPosture: Double? = 0.0
    var goodPostureRange: Double = 0.1
    
    @Published var isConnected: Bool = false
    @Published var currentState: PostureState?
    private var lastBadPostureTime: Date?
    private var postureCheckTimer: Timer?
    
    private var motionTimer: Timer? //에어팟을 빼고 있는 시간을 나타냅니다. 즉, 모션 데이터의 수집이 안된 시간
    
    init() {
        updateAuthorization()
//        startPostureCheckTimer()
    }
    
    /// 헤드폰 모션 추적 시작
    func startUpdates() {
        print("헤드폰 모션 추적을 시작합니다.")
        if isTracking {
            print("이미 헤드폰 모션을 추적중입니다.")
            return
        }
        
        isTracking = true
        
        // 현재 장치가 모션 데이터를 수집할 수 있는지를 나타냄
        guard cmHeadPhoneManager.isDeviceMotionAvailable else {
            print("Device motion is not available.")
            return
        }
        
        // 모션 업데이트
        cmHeadPhoneManager.startDeviceMotionUpdates(to: .main) { [weak self] (motion, error) in
            guard let self = self, let motion = motion else {
                if let error = error {
                    print("Error: \(error.localizedDescription)")
                }
                return
            }
            
            DispatchQueue.main.async {
                self.pitch = motion.attitude.pitch
                self.roll = motion.attitude.roll
                self.yaw = motion.attitude.yaw
                self.isConnected = true // 에어팟 착용 상태로 업데이트
                self.resetMotionTimer() // 모션 데이터를 받아오는 동안에 2초 동안 모션 데이터가 없으면 착용하지 않은 상태로 업데이트
            }
            
            updatePostureState() // 모션 데이터를 받아오는 동안에 실시간으로 자세 상태 파악
            
        }
        startMotionTimer() // 최초에 한번 실행하는 에어팟을 꼈는지 체크하는 함수 호출
    }
    
    
    /// 헤드폰 모션 추적 중지
    func stopUpdates() {
        print("헤드폰 모션 추적을 중지합니다.")
        
        if !isTracking {
            print("이미 헤드폰 모션이 종료되었습니다.")
        }
        
        isTracking = false
        pitch = 0
        roll = 0
        yaw = 0
        cmHeadPhoneManager.stopDeviceMotionUpdates()
        motionTimer?.invalidate()
    }
    
    /// 에어팟을 끼고 있는지를 체크
    func startMotionTimer() {
        motionTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            if self.isConnected {
                self.isConnected = false // 1초 동안 모션 데이터가 없으면 착용하지 않은 상태로 업데이트
            }
        }
    }
    
    //에어팟을 끼고 있다면 타이머를 재실행
    private func resetMotionTimer() {
        motionTimer?.invalidate() // 기존 타이머 중지
        isConnected = true // 에어팟 착용 상태 유지
        startMotionTimer() // 타이머 재시작
    }
    
    /// 권한 설정 상태를 업데이트 해주는 함수
    private func updateAuthorization() {
        switch CMHeadphoneMotionManager.authorizationStatus() {
        case .authorized:
            isHeadPhoneAuthorized = true
        case .denied, .notDetermined, .restricted:
            isHeadPhoneAuthorized = false
        @unknown default:
            isHeadPhoneAuthorized = false
        }
        print("isHeadPhoneAuthorized: \(isHeadPhoneAuthorized)")
    }
    
    deinit {
        stopUpdates()
    }
}

//MARK: - 실시간 자세 상태 업데이트
extension HeadphoneMotionManager {
    /// 현재 좋은 자세인지 판단하는 함수
    private func isWithinGoodPosture() -> Bool {
        guard let goodPosture = goodPosture else {
            print("goodPosture값이 없어요")
            return false
        }
        
        let difference = abs(pitch - goodPosture)
        return difference <= goodPostureRange
    }
    
    /// 자세 상태를 업데이트하는 함수
    private func updatePostureState() {
        let isGoodPosture = isWithinGoodPosture()

        if isGoodPosture {
            if currentState != .good {
                currentState = .good
                print("자세가 좋아졌어요")
            }
        // 자세가 안좋아졌을 경우 .bad 설정
        } else {
            if currentState == .good || currentState == nil {
                currentState = .bad
                lastBadPostureTime = Date()
                print("자세가 안좋아졌어요")
                
            //나쁜자세를 10분이상 유지했을 때 .worse 설정 (test위해 임의로 10초로 설정해뒀습니다)
            } else if let lastBadPostureTime = lastBadPostureTime,
                      Date().timeIntervalSince(lastBadPostureTime) >= 10 {
                currentState = .worse
                print("안좋은 자세를 10분간 유지했어요")
                
                // 상태를 .worse로 설정한 후 즉시(0.01초 뒤) .bad로 돌아가기
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                    self.currentState = .bad
                    print("상태가 다시 .worse로 변경됐어요")
                }
                
                // lastBadPostureTime 초기화해서 다시 interval 체크
                self.lastBadPostureTime = Date()
            }
        }
    }
    
//    private func startPostureCheckTimer() {
//        postureCheckTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
//            self?.updatePostureState()
//        }
//        updatePostureState()
//    }
}
