//
//  FinishMeasuringView.swift
//  TurtleNeck
//
//  Created by Hyun Jaeyeon on 7/28/24.
//

import SwiftUI

struct MeasureFinishView: View {
    var body: some View {
        VStack{
            Text("측정이 끝났어요.")
            Text("자세가 흐트러지면 알려드릴게요!\n에어팟 사용 관련 설정은 세팅에서 바꿀 수 있어요.")
            
            Button {
                
            } label: {
                Text("시작하기")
            }
        }
    }
}

#Preview {
    MeasureFinishView()
}
