//
//  PostureMeasuringView.swift
//  TurtleNeck
//
//  Created by Hyun Jaeyeon on 7/28/24.
//

import SwiftUI

struct MeasurePostureView: View {
    @State private var isCountdownComplete = false
    @StateObject private var motionManager = HeadphoneMotionManager()
    
    var body: some View {
        VStack {
            if isCountdownComplete {
                MeasuringView(motionManager: motionManager)
                    .onAppear {
                        motionManager.startUpdates()
                    }
            } else {
                MeasureCountDownView(isCountdownComplete: $isCountdownComplete)
            }
        }
    }
}

//MARK: - 카운트다운 뷰
struct MeasureCountDownView: View {
    @State private var countdown = 3
    @Binding var isCountdownComplete: Bool
    
    var body: some View {
        VStack(spacing: 0) {
            Image("countDown_\(countdown)")
                .padding(.bottom, 85)
            
            Text("곧 측정이 시작돼요!")
                .font(.tnHeadline20)
                .padding(.bottom, 12)
            
            Text("에어팟을 착용한 채로 바른 자세를 유지해 주세요.")
                .font(.tnBodyRegular14)
                .foregroundColor(.subText)
            
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.top, 140)
        .onAppear {
            startCountdown()
        }
    }
    
    /// countdown 타이머 함수
    private func startCountdown() {
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            if countdown > 1 {
                countdown -= 1
            } else {
                timer.invalidate()
                withAnimation {
                    isCountdownComplete = true
                }
            }
        }
    }
}

//MARK: - 자세 측정 중 뷰
struct MeasuringView: View {
    @State private var pitchValues: [Double] = []
    @ObservedObject var motionManager: HeadphoneMotionManager
    @State private var progress = 0.0
    private let totalTime: Double = 6
    @State private var timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    @State private var hasExecutedElseBlock = false
    
    let userManager = UserManager()
    
    var body: some View {
        VStack(spacing: 0){
            ZStack {
                Image("Img_Measuring")
                //원모양 progress bar
                Circle()
                    .strokeBorder(Color(hex: "EAEFD7"), style: StrokeStyle(
                        lineWidth: 10,
                        lineCap: .round
                    )
                    )
                    .frame(width: 201, height: 201)
                    .overlay(
                        Circle()
                            .trim(from: 0, to: CGFloat(progress))
                            .stroke(Color(hex: "B9C781"), style: StrokeStyle(
                                lineWidth: 10,
                                lineCap: .round
                            )
                            )
                            .rotationEffect(.degrees(-90))
                            .frame(width: 191, height: 191)
                    )
                
            }
            .padding(.bottom, 45)
            // 타이머가 0.1초마다 바뀔 때의 동작 설정
            .onReceive(timer) { _ in
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    if progress < 1.0 {
                        progress += 1.0 / (totalTime / 0.1)
                        pitchValues.append(motionManager.pitch)
                    } else {
                        if !hasExecutedElseBlock {
                            hasExecutedElseBlock = true // 코드 실행 플래그 설정
                            
                            timer.upstream.connect().cancel()
                            motionManager.stopUpdates()
                            
                            let averagePitch = calculateAveragePitch()
                            
                            print("5초 동안의 평균 pitch 값: \(averagePitch)")
                            
                            userManager.setUserMode(selectedMode: averagePitch, keyPath: \User.goodPosture)
                            
                            Router.shared.navigate(to: .measureFinish)
                        }
                    }
                }
            }

            Text("측정 중이에요.")
                .font(.tnHeadline20)
                .padding(.bottom, 12)
            
            Text("자세를 측정하고 있어요.\n에어팟을 착용한 상태로 바른 자세를 유지해 주세요.")
                .multilineTextAlignment(.center)
                .lineSpacing(4)
                .font(.tnBodyRegular14)
                .foregroundColor(.subText)
            
            Spacer()
        }
        .padding(.top, 60)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    ///pitch값의 평균을 구하는 함수
    private func calculateAveragePitch() -> Double {
        let total = pitchValues.reduce(0, +)
        let average = total / Double(pitchValues.count)
        return average
    }
}

#Preview {
    MeasurePostureView()
        .frame(width: 560, height: 560)
        .background(.white)
}
