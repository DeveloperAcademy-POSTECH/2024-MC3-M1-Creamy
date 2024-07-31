//
//  StatisticView.swift
//  TurtleNeck
//
//  Created by Doran on 7/31/24.
//

import SwiftUI

struct StatisticView: View {
    @State private var isToday: Bool = true
    
    var body: some View {
        VStack{
            HStack {
                Button(action: {
                    withAnimation {
                        isToday.toggle()
                    }
                }) {
                    Image(systemName: "chevron.left")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 11,height: 24)
                        .foregroundColor(.chevron)
                        .opacity(isToday ? 0 : 1)
                }
                .disabled(isToday)
                .buttonStyle(.plain)
                
                showView(isToday: isToday)
                    .frame(width: 251).padding(.horizontal,14)
                    .animation(.easeInOut, value: isToday)
                
                Button(action: {
                    withAnimation {
                        isToday.toggle()
                    }
                }) {
                    Image(systemName: "chevron.right")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 11,height: 24)
                        .foregroundColor(.chevron)
                        .opacity(isToday ? 1 : 0)
                }
                .disabled(!isToday)
                .buttonStyle(.plain)
            }
            Spacer()
        }
        .padding(.horizontal,8)
    }
}

extension StatisticView {
    @ViewBuilder
    private func showView(isToday: Bool) -> some View {
        if isToday {
           DayPostureView()
                .transition(.move(edge: .trailing))
        }
        else {
            WeekPostureView()
                .transition(.move(edge: .leading))
        }
    }
}

#Preview {
    StatisticView()
}
