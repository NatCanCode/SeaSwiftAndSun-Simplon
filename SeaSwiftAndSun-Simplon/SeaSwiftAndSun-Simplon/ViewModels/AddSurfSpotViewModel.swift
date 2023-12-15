//
//  AddSurfSpotViewModel.swift
//  SeaSwiftAndSun-Simplon
//
//  Created by Esteban SEMELLIER on 15/12/2023.
//

import Foundation
import SwiftUI

class AddSurfSpotViewModel: ObservableObject {
    
    // MARK: - Variables
    @Published var surfSpot = SurfSpotFields(peakSurfSeasonBegins: "", destinationStateCountry: "", peakSurfSeasonEnds: "", influencers: [""], surfBreak: [""], magicSeaweedLink: "", photos: [Photo(id: "", width: 0, height: 0, url: "", filename: "", size: 0, type: "", thumbnails: Thumbnails(small: Thumbnail(url: "", width: 0, height: 0), large: Thumbnail(url: "", width: 0, height: 0), full: Thumbnail(url: "", width: 0, height: 0)))], difficultyLevel: 0, destination: "", travellers: [""], coordinates: "", address: "")
    
    @Published var influencers: [String] = []
    @Published var travellers: [String] = []
    @Published var surfBreak: String = ""
    

    // MARK: - Methods
    func postData() {
        // Add influencers & travellers
        surfSpot.influencers = influencers
        surfSpot.travellers = travellers
        // Send request
        NetworkManager.shared.postSurfSpot(surfSpotData: surfSpot) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    print("Success")
                case .failure:
                    print("Error")
                }
            }
        }
    }
}
