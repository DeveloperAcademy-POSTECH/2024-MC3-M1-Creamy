//
//  LaunchScreenView.swift
//  TurtleNeck
//
//  Created by Doran on 8/7/24.
//

import SwiftUI

struct LaunchScreenView: View {
    @Environment(\.appDelegate) var appDelegate: AppDelegate?
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack(spacing: 0){
            Image("LaunchScreen")
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity) // 전체 화면을 사용
        .background(Color.white) // 배경색 설정
        .edgesIgnoringSafeArea(.all) // 안전 영역 무시
    }
}

#Preview {
    LaunchScreenView()
}
