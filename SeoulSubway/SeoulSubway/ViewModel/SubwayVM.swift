//
//  SwiftUIView.swift
//  SeoulSubway
//
//  Created by 최동호 on 12/4/23.
//

import Foundation
import SwiftUI

class SubwayVM: ObservableObject {
    @Published var startStation = ""
    @Published var realtimeArrivalList: [RealtimeArrivalList] = []
    @Published var navigateToSubwayView = false
    @Published var showError = false
    
    let apiKey = Bundle.main.infoDictionary?["Subway_Api_Key"] ?? ""
    
    func fetchStationData() async {
        
        guard let encodedStartStation = startStation.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let url = URL(string: "http://swopenapi.seoul.go.kr/api/subway/\(apiKey)/json/realtimeStationArrival/0/100/\(encodedStartStation)") else {
            print("Invalid URL or encoding")
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decodedResponse = try JSONDecoder().decode(SubwayAPIResponse.self, from: data)
            
            DispatchQueue.main.async {
                self.realtimeArrivalList = decodedResponse.realtimeArrivalList
                print(self.realtimeArrivalList)
            }
            
        } catch {
            print("Error: \(error)")
            DispatchQueue.main.async {
                self.showError = true
            }
        }
    }
}
