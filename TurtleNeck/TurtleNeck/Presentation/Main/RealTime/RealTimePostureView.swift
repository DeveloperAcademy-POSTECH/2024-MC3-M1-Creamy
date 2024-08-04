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
            
            TurtleView()
                .offset(x: -16, y: 32)
        }
        
        Spacer()
    }
}

#Preview {
    RealTimePostureView()
}

