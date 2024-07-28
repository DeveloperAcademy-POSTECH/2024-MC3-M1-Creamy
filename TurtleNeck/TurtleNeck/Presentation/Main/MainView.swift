//
//  MainView.swift
//  TurtleNeck
//
//  Created by 박준우 on 7/26/24.
//

import SwiftUI

struct MainView: View {
    @State var isRealTime: Bool = true
    @State var isMute: Bool = false
    
    var body: some View {
        VStack{
            HStack(alignment: .center){
                Spacer()
                Button(action: {
                    isMute.toggle()
                }){
                    Image(systemName: isMute ? "speaker" : "speaker.slash")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 14, height: 14)
                        .foregroundColor(.black)
                }
                Button(action: {
                    
                }){
                    Image(systemName: "gear")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 14,height: 14)
                        .foregroundColor(.black)
                }
            }
            .padding(.top, 12)
            
            HStack(spacing: 13){
                Button(action: {
                    isRealTime = true
                }){
                    Text("실시간").font(.system(size: 14,weight: isRealTime ? .bold : .regular)).foregroundColor(isRealTime ? .black : .gray)
                }
                Button(action:{
                    isRealTime = false
                }){
                    Text("통계").font(.system(size: 14,weight: isRealTime ? .regular : .bold)).foregroundColor(isRealTime ? .gray : .black)
                }
            }
            .padding(.top, 7)
            
            showView(isRealTime: isRealTime)
            
            Spacer()
        }
        .padding(.horizontal,16)
        .frame(width: 344,height: 240)
        .background(.white)

    }
}

extension MainView {
    @ViewBuilder
    private func showView(isRealTime: Bool) -> some View {
        if isRealTime {
            RealTimePostureView()
        }
        else {
            WeekPostureView()
        }
    }
}

#Preview {
    MainView()
}
