//
//  PostureMeasuringView.swift
//  TurtleNeck
//
//  Created by Hyun Jaeyeon on 7/28/24.
//

import SwiftUI

struct MeasurePostureView: View {
    @State private var isCountdownComplete = false
    @State private var countdown = 3
    
    var body: some View {
        VStack {
            if isCountdownComplete {
                MeasuringView()
            } else {
                MeasureCountDownView(countdown: $countdown)
                    .onAppear {
                        startCountdown()
                    }
            }
        }
    }
    
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

#Preview {
    MeasurePostureView()
        .frame(width: 560, height: 560)
        .background(.white)
}

struct MeasureCountDownView: View {
    @Binding var countdown: Int
    
    var body: some View {
        VStack(spacing: 16) {
            Image("countDown_\(countdown)")
            
            Spacer()
            
            Text("곧 측정이 시작돼요!")
                .font(.title3)
                .fontWeight(.semibold)
            
            Text("에어팟을 착용한 채로 바른 자세를 유지해 주세요.")
                .font(.callout)
                .foregroundColor(.subTextGray)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.top, 112)
        .padding(.bottom, 162)
        .border(.black)
    }
}

struct MeasuringView: View {
    @EnvironmentObject var router: Router
    
    @State private var progress = 0.0
    private let totalTime: Double = 5.0
    private let timer = Timer.publish(every: 0.05, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack(spacing: 16){
            ZStack {
                Image("Img_Measuring")
                
                Circle()
                    .strokeBorder(Color(hex: "EAEFD7"), style: StrokeStyle(
                        lineWidth: 10,
                        lineCap: .round
                    )
                    )
                    .frame(width: 200, height: 200)
                    .overlay(
                        Circle()
                            .trim(from: 0, to: CGFloat(progress))
                            .stroke(Color(hex: "B9C781"), style: StrokeStyle(
                                lineWidth: 10,
                                lineCap: .round
                            )
                            )
                            .rotationEffect(.degrees(-90))
                            .frame(width: 190, height: 190)
                    )
                
            }
            .padding(.top, 30)
            .onReceive(timer) { _ in
                if progress < 1.0 {
                    progress += 1.0 / (totalTime / 0.05)
                } else {
                    timer.upstream.connect().cancel()
                    
                    router.navigate(to: .measureFinish)
                }
            }
            
            Spacer()
            
            Text("측정 중이에요.")
                .font(.title3)
                .fontWeight(.semibold)
            
            Text("자세를 측정하고 있어요.\n에어팟을 착용한 상태로 바른 자세를 유지해 주세요.")
                .multilineTextAlignment(.center)
                .lineSpacing(4)
                .font(.callout)
                .foregroundColor(.subTextGray)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.top, 30)
        .padding(.bottom, 134)
        .border(.black)
    }
}
