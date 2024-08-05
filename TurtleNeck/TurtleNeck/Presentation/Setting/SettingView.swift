//
//  SettingView.swift
//  TurtleNeck
//
//  Created by 박준우 on 7/26/24.
//

import SwiftUI

struct SettingView: View {
    @Environment(\.appDelegate) var appDelegate: AppDelegate?
    
    @State private var notiWindow: Bool = true
    @State private var notiSound: Bool = true
    @State private var postureMeasure: Bool = true
    @State private var selectedOption: String = "Option 1"
    @State private var showPicker: Bool = false
    @State private var selected = 1
    @State private var speed = 50.0
    @State private var isEditing = false

    var body: some View {

        VStack(alignment: .leading, spacing: 0){
            Text("설정")
                .font(.pretendardMedium16).fontWeight(.bold)
                .foregroundColor(.black)
                .padding(.top, 19)
            
            notificationView
            postureMeasureView
            postureReminderView
            
            Spacer()
        }
        .frame(width: 560, height: 684)
    }
    
    private var notificationView: some View {
        Section {
            Text("알림 관련")
                .font(.headline)
                .foregroundColor(.black)
                .padding(.top, 16)
            
            ZStack{
                HStack{
                    VStack(alignment: .leading, spacing: 0){
                        Text("시스템 기본 설정 열기").font(.pretendardRegular13).foregroundColor(.black)
                        Text("알림 및 Mac 시스템 기본 설정에서 알림 및 포커스를 열어 TurtleNeck에서 알림을 보내고 모양과 소리를 변경 할 수 있도록 해주세요.").font(.pretendardRegular11).foregroundColor(.black).opacity(0.5)
                            .frame(width: 353)
                            .padding(.top, 2)
                    }
                    Spacer()
                    Button(action: {}){
                        Text("설정 열기").font(.pretendardRegular13).foregroundColor(.black)
                    }
                }
                .padding(.horizontal, 10)
            }
            .frame(width: 520, height: 66)
            .background(Color.listColor)
            .cornerRadius(6)
            .overlay(
                RoundedRectangle(cornerRadius: 6)
                    .stroke(Color.borderLine, lineWidth: 1)
            )
            .padding(.top, 8)
            
            ZStack{
                VStack{
                    HStack(alignment:.center){
                        VStack(alignment: .leading, spacing: 0){
                            Text("알림창").font(.pretendardRegular13).foregroundColor(.black)
                            Text("시스템 환경 설정에서 알림 허용 여부를 확인해주세요.").font(.pretendardRegular11).foregroundColor(.black).opacity(0.5)
                                .padding(.top, 2)
                        }
                        Spacer()
                        Toggle("확인", isOn: $notiWindow)
                            .toggleStyle(SwitchToggleStyle(tint: .chart))
                    }
                    Rectangle().frame(height: 1).foregroundColor(Color.borderLine)
                    
                    HStack(alignment:.center){
                        VStack(alignment: .leading, spacing: 0){
                            Text("소리").font(.pretendardRegular13).foregroundColor(.black).padding(.top,2)
                        }
                        Spacer()
                        Toggle("확인", isOn: $notiSound)
                            .toggleStyle(SwitchToggleStyle(tint: .chart))
                    }
                    Rectangle().frame(height: 1).foregroundColor(Color.borderLine)
                    
                    HStack(alignment:.center){
                        VStack(alignment: .leading, spacing: 0){
                            Text("소리 선택").font(.pretendardRegular13).foregroundColor(.black).padding(.top,2)
                        }
                        Spacer()
                        
                    }
                    Rectangle().frame(height: 1).foregroundColor(Color.borderLine)
                    
                    HStack(alignment:.center){
                        VStack(alignment: .leading, spacing: 0){
                            Text("알림 크기").font(.pretendardRegular13).foregroundColor(.black).padding(.top,2)
                        }
                        Spacer()
                        Slider(value: $speed, in: 0...100)
                            .tint(.chart)
                            .frame(width: 150)
                    }
                    
                }
                .padding(.horizontal, 10)
            }
            .frame(width: 520, height: 160)
            .background(Color.listColor)
            .cornerRadius(6)
            .overlay(
                RoundedRectangle(cornerRadius: 6)
                    .stroke(Color.borderLine, lineWidth: 1)
            )
            .padding(.top, 8)
        }
    }
    
    private var postureMeasureView: some View {
        Section {
            Text("자세 측정모드")
                .font(.headline)
                .foregroundColor(.black)
                .padding(.top, 16)
            
            Text("에어팟이 있어야 사용할 수 있어요")
                .font(.body)
                .foregroundColor(.gray01)
                .padding(.top, 4)
            
            ZStack{
                VStack{
                    HStack(alignment:.center){
                        VStack(alignment: .leading, spacing: 0){
                            Text("자세 측정").font(.pretendardRegular13).foregroundColor(.black)
                        }
                        Spacer()
                        Toggle("확인", isOn: $postureMeasure)
                            .toggleStyle(SwitchToggleStyle(tint: .chart))
                    }
                    Rectangle().frame(height: 1).foregroundColor(Color.borderLine)
                    
                    HStack(alignment:.center){
                        VStack(alignment: .leading, spacing: 0){
                            Text("자세 재설정").font(.pretendardRegular13).foregroundColor(.black).padding(.top,2)
                        }
                        Spacer()
                        Button(action: {}){
                            Text("자세 설정하러 가기").font(.pretendardRegular13).foregroundColor(.black)
                        }
                    }
                    Rectangle().frame(height: 1).foregroundColor(Color.borderLine)
                    
                    VStack(spacing: 0){
                        HStack(alignment:.center){
                            Text("민감도").font(.pretendardRegular13).foregroundColor(.black)
                                .padding(.top,2)
                            Spacer()
                        }
                        Slider(value: $speed, in: 0...100)
                            .tint(.chart)
                    }
                    
                    Rectangle().frame(height: 1).foregroundColor(Color.borderLine)
                    
                    HStack(alignment:.center){
                        VStack(alignment: .leading, spacing: 0){
                            Text("알림 시점").font(.pretendardRegular13).foregroundColor(.black).padding(.top,2)
                        }
                        Spacer()
                        
                    }
                    
                }
                .padding(.horizontal, 10)
            }
            .frame(width: 520, height: 170)
            .background(Color.listColor)
            .cornerRadius(6)
            .overlay(
                RoundedRectangle(cornerRadius: 6)
                    .stroke(Color.borderLine, lineWidth: 1)
            )
            .padding(.top, 8)
        }
    }
    
    private var postureReminderView: some View {
        Section {
            Text("자세 리마인더")
                .font(.headline)
                .foregroundColor(.black)
                .padding(.top, 16)
            
            ZStack{
                HStack{
                    VStack(alignment: .leading, spacing: 0){
                        Text("알림 주기").font(.pretendardRegular13).foregroundColor(.black)
                        Text("에어팟이 없을 때 주기적으로 자세에 대한 알림을 보내드려요.").font(.pretendardRegular11).foregroundColor(.black).opacity(0.5).padding(.top, 2)
                    }
                    Spacer()
                }
                .padding(.horizontal, 10)
            }
            .frame(width: 520, height: 52)
            .background(Color.listColor)
            .cornerRadius(6)
            .overlay(
                RoundedRectangle(cornerRadius: 6)
                    .stroke(Color.borderLine, lineWidth: 1)
            )
            .padding(.top, 8)
        }
    }
}
