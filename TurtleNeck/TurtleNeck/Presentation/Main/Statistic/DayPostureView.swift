//
//  DayPostureView.swift
//  TurtleNeck
//
//  Created by Doran on 7/31/24.
//

import SwiftUI

struct DayPostureView: View {
    var body: some View {
        VStack{
            Image("SmileTurtle").resizable().scaledToFit().frame(width: 100,height: 100).padding(.top,32)
            Text("1시간 기준 어제보다").font(.pretendardRegular12).foregroundColor(.black).padding(.top,8)
            Text("알림을 n번 더 받았네요.").font(.pretendardRegular12).foregroundColor(.black)
            
        }
    }
}

#Preview {
    DayPostureView()
}
