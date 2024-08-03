//
//  HeadphoneMotionManager.swift
//  TurtleNeck
//
//  Created by Hyun Jaeyeon on 8/2/24.
//

import Foundation
import CoreMotion

class HeadphoneMotionManager: ObservableObject {
    @Published var isHeadPhoneAuthorized = false
    var isTracking = false
    @Published var pitch: Double = 0.0
    @Published var roll: Double = 0.0
    @Published var yaw: Double = 0.0
    
    //TODO: 나중에 자세 평균을 여기 넣으면 되겠다!
    private var initialPitch: Double = 0.0
    private var initialRoll: Double = 0.0
    private var initialYaw: Double = 0.0
    
    private let cmHeadPhoneManager = CMHeadphoneMotionManager()
    
    init() {
        updateAuthorization()
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
                self.pitch = motion.attitude.pitch - self.initialPitch
                self.roll = motion.attitude.roll - self.initialRoll
                self.yaw = motion.attitude.yaw - self.initialYaw
            }
        }
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
    
    /// 현재 자세를 기준으로 intitialPosition을 측정하는 함수
    func calibrate() {
        initialPitch = pitch
        initialRoll = roll
        initialYaw = yaw
    }
    
    deinit {
        stopUpdates()
    }
}
