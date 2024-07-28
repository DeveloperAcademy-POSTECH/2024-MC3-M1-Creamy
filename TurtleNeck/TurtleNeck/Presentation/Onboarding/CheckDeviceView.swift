//
//  AppIntroductionView.swift
//  TurtleNeck
//
//  Created by Hyun Jaeyeon on 7/28/24.
//

import SwiftUI

struct CheckDeviceView: View {
    var body: some View {
        Text("에어팟 사용 여부를 선택해 주세요.")
        Text("에어팟을 착용하면 자세가 흐트러진 정확한 시점에 알림을 드릴 수 있어요. \n 에어팟이 없다면 주기적으로 알림을 보내드려요.")
        
        HStack{
            Button {
            
            } label: {
                Text("에어팟으로 자세 측정하기")
            }
            
            Button {
            
            } label: {
                Text("에어팟 없이 알림만 받기")
            }
        }
    }
}

#Preview {
    CheckDeviceView()
}
