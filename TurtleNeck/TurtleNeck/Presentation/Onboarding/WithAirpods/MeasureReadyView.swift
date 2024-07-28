//
//  PostureInfoView.swift
//  TurtleNeck
//
//  Created by Hyun Jaeyeon on 7/28/24.
//

import SwiftUI

struct MeasureReadyView: View {
    var body: some View {
        Text("바른 자세로 앉아주세요.")
        Text("자세 측정을 위해 에어팟을 착용하고, 바른 자세로 앉아주세요\n준비가 되면 하단의 측정 시작하기 버튼을 눌러주세요.")
        
        Button {
        
        } label: {
            Text("측정 시작하기")
        }
    }
}

#Preview {
    MeasureReadyView()
}
