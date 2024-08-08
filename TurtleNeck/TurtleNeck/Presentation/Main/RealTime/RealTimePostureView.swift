//
//  RealTimePostureView.swift
//  TurtleNeck
//
//  Created by Doran on 7/27/24.
//

import SwiftUI

struct RealTimePostureView: View {
    @ObservedObject var motionManager: HeadphoneMotionManager
    
    var body: some View {
        VStack(spacing:0){
            
            if (motionManager.currentState == .good){
                VStack{
                    Text("아주 좋아요. 지금 이대로만").font(.pretendardRegular12).foregroundColor(.black).lineSpacing(8)
                    Text("유지해주세요").font(.pretendardRegular12).foregroundColor(.black).lineSpacing(8)
                }
                .frame(height: 32)
                .padding(.top, 32)
            }
            else {
                VStack{
                    Text("곧...바다로 돌아가시려구요?").font(.pretendardRegular12).foregroundColor(.black).lineSpacing(8)
                }
                .frame(height: 32)
                .padding(.top, 32)
            }
            
            TurtleView(motionManager: motionManager)
                .offset(x: -16, y: 32)
        }
        
        Spacer()
    }
}

