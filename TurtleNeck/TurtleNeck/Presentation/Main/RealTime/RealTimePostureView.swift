//
//  RealTimePostureView.swift
//  TurtleNeck
//
//  Created by Doran on 7/27/24.
//

import SwiftUI

struct RealTimePostureView: View {
    
    var body: some View {
        VStack(spacing:0){
            VStack{
                Text("아주 좋아요. 지금 이대로만").font(.pretendardRegular12).foregroundColor(.black).lineSpacing(8)
                Text("유지해주세요").font(.pretendardRegular12).foregroundColor(.black).lineSpacing(8)
            }
            .padding(.top, 32)
            
            ZStack(alignment: .center) {
                Color.white
                
                Image("Neck+cloth")
                    .resizable()
                    .frame(width: 30.33, height: 77.16)
                    .offset(x: 56, y: -9)
                
                Image("Body")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 175.67, height: 147.61)
                    .offset(x:24, y: 48)
                
                Image("Head")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 64.21, height: 58.99)
                    
                    .offset(x: 43, y: -36)
                
            }
            .frame(width: 188,height: 114)
            .offset(x: -16, y: 32)
        }
        Spacer()
    }
}

#Preview {
    RealTimePostureView()
}

