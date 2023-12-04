//
//  SubwayView.swift
//  SeoulSubway
//
//  Created by 최동호 on 12/4/23.
//

import SwiftUI

struct StartView: View {
    @ObservedObject var vm: SubwayVM
    
    var body: some View {
        VStack{
            Spacer()
            HStack {
                Rectangle()
                    .fill(Color.green)
                    .frame(height: 40)
                ZStack {
                    Circle()
                        .fill(Color.clear)
                        .frame(width: 150, height: 150)
                        .overlay(Circle().stroke(Color.green, lineWidth: 20))
                    Text("서울시")
                        .font(.title)
                        .bold()
                        .padding()
                }
                Rectangle()
                    .fill(Color.green)
                    .frame(height: 40)
            }

            Spacer()
            Text("지하철역을 입력해주세요")
                .font(.subheadline)
                .foregroundColor(.gray)
                .padding()
            TextField("", text: $vm.startStation)
                .padding()
                .bold()
                .frame(width: 200)
                .background(.black.opacity(0.1))
                .clipShape(RoundedRectangle(cornerRadius: 15))
            Spacer()
            Button {
                Task {
                    await vm.fetchStationData()
                    vm.navigateToSubwayView = true
                }
            } label: {
                Text("알아보기")
                    .font(.title3)
                    .padding()
                    .foregroundStyle(.white)
                    .background(.green)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
            }.padding()
            Spacer()
        }
        .sheet(isPresented: $vm.navigateToSubwayView) {
            SubwayView(realtimeArrivalList: vm.realtimeArrivalList, startStation: vm.startStation)
        }
    }
}

#Preview {
    StartView(vm: SubwayVM())
}
