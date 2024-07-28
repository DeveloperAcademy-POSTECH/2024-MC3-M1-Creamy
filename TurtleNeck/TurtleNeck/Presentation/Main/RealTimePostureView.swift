//
//  RealTimePostureView.swift
//  TurtleNeck
//
//  Created by Doran on 7/27/24.
//

import SwiftUI

struct RealTimePostureView: View {
    var body: some View {
        HStack(spacing:30){
            ZStack{
                Circle().frame(width: 100,height: 100).foregroundColor(.gray)
                Image(systemName: "tortoise.fill").resizable().scaledToFit().frame(width: 100,height: 100)
            }
            VStack{
                Text("실시간 자세가").font(.system(size: 20,weight: .bold)).foregroundColor(.black)
                Text("어쩌구 저쩌구").font(.system(size: 20,weight: .bold)).foregroundColor(.black)
            }
        }
        .padding(.top,7)
    }
}

#Preview {
    RealTimePostureView()
}
