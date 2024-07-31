//
//  DayPostureView.swift
//  TurtleNeck
//
//  Created by Doran on 7/31/24.
//

import SwiftUI

struct DayPostureView: View {
    var body: some View {
        VStack(spacing: 0){
            Image(systemName: "tortoise.fill").resizable().scaledToFit().frame(width: 62,height: 64).foregroundColor(.black).padding(.bottom,4)
            Text("1시간 기준 어제보다").font(.system(size: 14,weight: .bold)).foregroundColor(.black)
            Text("알림을 2번 덜 받았네요").font(.system(size: 14,weight: .bold)).foregroundColor(.black)
        }.padding(.top,17)
    }
}

#Preview {
    DayPostureView()
}
