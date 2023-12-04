//
//  SubwayView.swift
//  SeoulSubway
//
//  Created by 최동호 on 12/4/23.
//

import SwiftUI

struct SubwayView: View {
    var realtimeArrivalList: [RealtimeArrivalList]
    var startStation: String

    var body: some View {
        VStack {
            Text(startStation)
                .font(.title)
                .fontWeight(.bold)
                .padding()

            List(realtimeArrivalList, id: \.btrainNo) { arrival in
                VStack(alignment: .leading) {
                    Text(arrival.trainLineNm)
                        .fontWeight(.semibold)
                    Text("도착 예정 시간: \(arrival.arvlMsg2)")
                }
            }
        }
    }
}
