//
//  SettingView.swift
//  TurtleNeck
//
//  Created by 박준우 on 7/26/24.
//

import SwiftUI

struct SettingView: View {
    @Environment(\.appDelegate) var appDelegate: AppDelegate?
    @EnvironmentObject private var statisticManager: StatisticManager
    @EnvironmentObject private var userManager: UserManager
    
    // TODO: 민감도 조절 값으로 변경
    @State private var slideValue: Double = 2
    @ObservedObject var notificationManager: NotificationManager
    @ObservedObject var motionManager: HeadphoneMotionManager
    @ObservedObject var timerManager: TimerManager
    
    private let notiPreferenceURL = URL(string: "x-apple.systempreferences:com.apple.preference.notifications?id=\(Bundle.main.bundleIdentifier!)")!
    private let motionPreferenceURL = URL(string: "x-apple.systempreferences:com.apple.preference.security?Privacy_Motion")!
    
    init(notificationManager: NotificationManager, motionManager: HeadphoneMotionManager, timerManager: TimerManager) {
        print("SettingView init")
        self.notificationManager = notificationManager
        self.motionManager = motionManager
        self.timerManager = timerManager
    }
    
    var body: some View {
        // MARK: 개발자 모드가 들어가 있으므로 추후에 프레임 크기를 .frame(width: 560, height: 684)로 수정해야 합니다.
        VStack(spacing: 0){
            List {
                // MARK: 설정 타이틀
                Text("설정")
                    .foregroundColor(.black)
                    .font(.tnBodyMedium16)
                    .fontWeight(.bold)
                    .padding(.top, 18)
                
                // MARK: 시스템 기본 설정 열기
                Section {
                    HStack {
                        VStack(alignment: .leading, spacing: 0){
                            Text("시스템 기본 설정 열기")
                                .foregroundColor(.black)
                            Text("알림 및 Mac 시스템 기본 설정에서 알림 및 포커스를 열어 TurtleNeck에서\n알림을 보내고 모양과 소리를 변경 할 수 있도록 해주세요.")
                                .foregroundColor(.black.opacity(0.5))
                                .font(.tnBodyRegular11)
                                .padding(.top, 2)
                        }
                        Spacer()
                        Button {
                            NSWorkspace.shared.open(notiPreferenceURL)
                        } label: {
                            Text("설정 열기")
                                .foregroundColor(.black)
                        }
                        .shadow(radius: 1)
                    }
                    .padding(10)
                    .background{
                        RoundedRectangle(cornerRadius: 6)
                            .fill(Color.settingBG)
                            .stroke(Color.borderLine, lineWidth: 1)
                    }
                } header: {
                    Text("알림 관련")
                        .font(.headline)
                        .foregroundColor(.black)
                }
                .listRowSeparator(.hidden)
                
                // MARK: 받고싶은 알림 / 알림소리 켜기 / 알림소리 변경
                Section {
                    VStack(spacing: 0) {
                        HStack {
                            Text("받고싶은 알림")
                            Spacer()
                            Picker("", selection: $userManager.user.notificationMode) {
                                Text("자세 측정 알림").tag(NotificationMode.posture)
                                Text("기본 알림").tag(NotificationMode.default)
                            }
                            .onChange(of: userManager.user.notificationMode, {
                                userManager.saveUser()
                                notificationManager.removeNoti()
                                
                                if userManager.user.notificationMode == .default {
                                    motionManager.isConnected = false
                                    motionManager.stopUpdates()
                                    
                                    notificationManager.settingTimeNoti(state: .normal)
                                    
                                    timerManager.resetTimer(statistics: &statisticManager.statistics)
                                }
                                else {
                                    motionManager.isConnected = true
                                    motionManager.startUpdates()
                                }
                            })
                            .pickerStyle(.radioGroup)
                            .horizontalRadioGroupLayout()
                            .accentColor(.buttonText)
                        }
                        .padding(10)
                        
                        Divider()
                            .padding(.horizontal, 10)
                        
                        HStack {
                            Toggle(isOn: $userManager.user.isSoundOn, label: {
                                Text("알림소리 켜기")
                            })
                            .tint(.buttonText)
                            .toggleStyle(.switch)
                            .onChange(of: userManager.user.isSoundOn) {
                                userManager.saveUser()
                            }
                        }
                        .padding(10)
                        
                        // TODO: 추후 알림소리 변경 기능 추가
                        /*
                        Divider()
                            .padding(.horizontal, 10)
                        
                        HStack {
                            Text("소리 선택")
                            Menu {
                                Button {
                                    
                                } label: {
                                    Text("기본")
                                }
                                Button {
                                    
                                } label: {
                                    Text("커스텀")
                                }
                            } label: {
                                Text("기본")
                            }
                            .tint(.buttonText)
                            .padding(.leading, 310)
                        }
                        .padding(10)
                         */
                    }
                }
                .background{
                    RoundedRectangle(cornerRadius: 6)
                        .fill(Color.settingBG)
                        .stroke(Color.borderLine, lineWidth: 1)
                }
                .listRowSeparator(.hidden)
                .padding(.bottom)
                
                // MARK: 모션 데이터 접근 허용 설정 열기
                Section {
                    HStack {
                        VStack(alignment: .leading, spacing: 0) {
                            Text("모션 데이터 접근 허용 설정 열기")
                                .foregroundColor(.black)
                                .font(.tnBodyRegular13)
                            Text("알림 및 Mac 시스템 기본 설정에서 알림 및 포커스를 열어 TurtleNeck에서\n알림을 보내고 모양과 소리를 변경 할 수 있도록 해주세요.")
                                .foregroundColor(.black.opacity(0.5))
                                .font(.tnBodyRegular11)
                                .padding(.top, 2)
                        }
                        Spacer()
                        Button{
                            NSWorkspace.shared.open(motionPreferenceURL)
                        } label: {
                            Text("설정 열기")
                                .foregroundColor(.black)
                                .font(.tnBodyRegular13)
                        }
                        .shadow(radius: 1)
                    }
                    .padding(10)
                    .background{
                        RoundedRectangle(cornerRadius: 6)
                            .fill(Color.settingBG)
                            .stroke(Color.borderLine, lineWidth: 1)
                    }
                    
//                    Rectangle().frame(height: 1).foregroundColor(Color.borderLine)
                    
                    VStack(spacing: 0){
                        HStack(alignment:.center){
                            Text("민감도")
                                .font(.headline)
                                .foregroundColor(.black)
                                .padding(.top,2)
                            
                            Spacer()
                        }
                    }
                } header: {
                    VStack(alignment: .leading, spacing: 0){
                        Text("자세 측정 알림")
                            .foregroundColor(.black)
                            .font(.headline)
                        Text("자세를 측정해 흐트러진 순간 알림을 보내드려요. 에어팟이 있어야 사용할 수 있어요.")
                            .font(.subheadline)
                            .foregroundColor(.black.opacity(0.5))
                            .padding(.top, 4)
                    }
                }
                .listRowSeparator(.hidden)
                
                // MARK: 자세 측정 민감도 / 알림 시점 / 자세 재설정
                Section {
                    Group {
                        VStack(spacing: 0) {
                            HStack {
                                Text("자세 측정 민감도")
                                Spacer()
                            }
                            .padding(10)
                            
                            HStack {
                                Rectangle()
                                    .foregroundStyle(userManager.user.notificationMode == .default ? Color.clear : Color(hex: "FFB0B0"))
                                    .frame(width: 480 * test(motionManager.pitch), height: 3)
                                Spacer(minLength: 0)
                            }
                            .padding(.init(top: 10, leading: 12, bottom: 0, trailing: 10))
                            .overlay {
                                HStack(spacing: 0){
                                    Rectangle()
                                        .frame(width: 480 *  slideValue/4, height: 4)
                                        .foregroundStyle(userManager.user.notificationMode == .default ? Color.clear : Color.buttonText)
                                    Spacer(minLength: 0)
                                }
                                .padding(.init(top: 10, leading: 12, bottom: 0, trailing: 10))
                            }
                            .overlay {
                                NSSliderView(value: $slideValue, minValue: 0, maxValue: 4, countOfMark: 5)
                                    .padding(.init(top: 10, leading: 10, bottom: 0, trailing: 10))
                                    .frame(width: 500)
                                    .onChange(of: slideValue) {
                                        updateGoodPostureRange()
                                        print("슬라이드 값 변경")
                                    }
                            }
                            
                            HStack {
                                Text("Low")
                                Spacer()
                                Text("High")
                            }
                            .foregroundStyle(Color.settingSub)
                            .padding(10)
                            .font(.caption)
                            Divider()
                                .padding(.horizontal, 10)
                            
                            HStack {
                                VStack(alignment: .leading, spacing: 0){
                                    Text("알림 시점")
                                        .foregroundColor(.black)
                                    Text("자세가 흐트러진 순간부터 계산해 알림을 보내드려요.")
                                        .foregroundColor(.black.opacity(0.5))
                                        .font(.tnBodyRegular11)
                                        .padding(.top, 2)
                                }
                                Spacer()
                                Picker("", selection: $userManager.user.badNotiCycle) {
                                    ForEach([5.0, 10.0, 15.0], id: \.self) { time in
                                        Text("\(Int(time))초")
                                    }
                                }
                                .pickerStyle(.radioGroup)
                                .horizontalRadioGroupLayout()
                                .accentColor(.buttonText)
                                .onChange(of: userManager.user.badNotiCycle) {
                                    userManager.saveUser()
                                }
                            }
                            .padding(10)
                            
                            Divider()
                                .padding(.horizontal, 10)
                            
                            HStack {
                                Text("자세 재설정")
                                Spacer()
                                Button {
                                    timerManager.resetTimer(statistics: &statisticManager.statistics)
                                    appDelegate?.openMeasureView()
                                    Router.shared.navigateToRoot()
                                } label: {
                                    Text("자세 설정하러 가기")
                                        .foregroundColor(userManager.user.notificationMode == .default ? .gray : .black)
                                }
                                .shadow(radius: 1)
                            }
                            .padding(10)
                        }
                    }
                    .disabled(userManager.user.notificationMode == .default)
                }
                .listRowSeparator(.hidden)
                .background{
                    RoundedRectangle(cornerRadius: 6)
                        .fill(Color.settingBG)
                        .stroke(Color.borderLine, lineWidth: 1)
                }
                .padding(.bottom)
                
                // MARK: 알림 주기
                Section {
                    HStack {
                        VStack(alignment: .leading, spacing: 0){
                            Text("알림 주기")
                                .foregroundColor(.black)
                            Text("주기적으로 자세에 대한 알림을 보내드려요.")
                                .foregroundColor(.black.opacity(0.5))
                                .font(.tnBodyRegular11)
                                .padding(.top, 2)
                        }

                        Menu {
                            Button {
                                userManager.user.timeNotiCycle = 15 * 60
                                userManager.saveUser()
                            } label: {
                                Text("15분")
                            }
                            Button {
                                userManager.user.timeNotiCycle = 30 * 60
                                userManager.saveUser()
                            } label: {
                                Text("30분")
                            }
                            Button {
                                userManager.user.timeNotiCycle = 45 * 60
                                userManager.saveUser()
                            } label: {
                                Text("45분")
                            }
                            Button {
                                userManager.user.timeNotiCycle = 60 * 60
                                userManager.saveUser()
                            } label: {
                                Text("60분")
                            }
                            
                        } label: {
                            Text("\(Int(userManager.user.timeNotiCycle / 60))분")
                        }
                        .tint(.buttonText)
                        .padding(.leading, 200)
                        .onChange(of: userManager.user.timeNotiCycle) {
                            userManager.saveUser()
                            notificationManager.removeNoti()
                            notificationManager.settingTimeNoti(state: .normal)
                        }
                        .disabled(userManager.user.notificationMode == .posture)
                    }
                    .padding(10)
                    .background{
                        RoundedRectangle(cornerRadius: 6)
                            .fill(Color.settingBG)
                            .stroke(Color.borderLine, lineWidth: 1)
                    }
                } header: {
                    VStack(alignment: .leading, spacing: 0){
                        Text("기본 알림")
                            .foregroundColor(.black)
                            .font(.headline)
                        Text("주기적으로 자세에 대한 알림을 보내드려요.")
                            .foregroundColor(.black.opacity(0.5))
                            .font(.tnBodyRegular11)
                            .padding(.top, 4)
                    }
                }
                .listRowSeparator(.hidden)
                
                // MARK: TurtleNeck 종료하기
                HStack {
                    Button{
                        userManager.deleteUser()
                        statisticManager.deleteAllData()
                    } label: {
                        Text("테스트용 데이터 삭제: 출시 전에 삭제해주세요")
                            .foregroundColor(.black)
                    }
                    .shadow(radius: 1)
                    
                    Spacer()
                    Button{
                        exit(0)
                        // NSApplication.shared.terminate(nil)
                    } label: {
                        Text("TurtleNeck 종료하기")
                            .foregroundColor(.black)
                    }
                    .shadow(radius: 1)
                }
                .padding(.top, 29)
            }
            .listStyle(.plain)
            .padding(.horizontal, 20)
        }
        .frame(width: 560, height: 788)
        .background(.white)
    }
}

extension SettingView {
    
    private func test(_ pitch: CGFloat) -> CGFloat {
        // -0.32 / -0.24 / -0.16 / 0.08 / 0
        switch pitch {
        case -10 ... -0.32:
            return 0
        case 0 ... 10:
            return 1
        default:
            return (0.32 + pitch) / 0.32
        }
    }
    
    /// 슬라이더 값에 따라 goodPostureRange값 조정
    private func updateGoodPostureRange() {
        // 슬라이더 한단계 값-> 0.05
        let rangeAdjustment = (slideValue - 2) * 0.05
        userManager.updateUser(keyPath: \.goodPostureRange, value: userManager.user.goodPostureRange + rangeAdjustment)
        print(userManager.user.goodPostureRange)
        userManager.saveUser()
        
    }
}

#Preview {
    SettingView(notificationManager: NotificationManager(), motionManager: HeadphoneMotionManager(), timerManager: TimerManager())
}
