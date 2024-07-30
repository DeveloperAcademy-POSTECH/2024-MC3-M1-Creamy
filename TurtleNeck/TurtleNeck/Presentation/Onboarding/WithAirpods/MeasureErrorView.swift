//
//  MeasuringErrorVIew.swift
//  TurtleNeck
//
//  Created by Hyun Jaeyeon on 7/28/24.
//

import SwiftUI

struct MeasureErrorView: View {
    var body: some View {
        VStack{
            Text("측정을 실패했어요")
            Text("정확한 측정을 실패했어요\n다시 자세를 측정해 주세요.")
            
            Button {
                
            } label: {
                Text("다시 측정하기")
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    MeasureErrorView()
}
