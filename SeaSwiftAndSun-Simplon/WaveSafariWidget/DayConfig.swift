//
//  DayConfig.swift
//  WaveSafariWidgetExtension
//
//  Created by N N on 15/12/2023.
//

import WidgetKit
import SwiftUI

struct DayConfig {
    let backgroundColor: Color
    let picture: String
    let location: String

    static func determineConfig(from date: Date) -> DayConfig {
        let dayInt = Calendar.current.component(.weekday, from: date)

        switch dayInt {
        case 1:
            return DayConfig(
                backgroundColor: .orange,
                picture: "PastaPoint",
                location: "Pasta Point"
            )
        case 2:
            return DayConfig(
                backgroundColor: .pink,
                picture: "Pipeline",
                location: "Pipeline"
            )
        case 3:
            return DayConfig(
                backgroundColor: .purple,
                picture: "PlayaChicama",
                location: "Playa Chicama"
            )
        case 4:
            return DayConfig(
                backgroundColor: .blue,
                picture: "RockawayBeach",
                location: "Rockaway Beach"
            )
        case 5:
            return DayConfig(
                backgroundColor: .mint,
                picture: "Supertubes",
                location: "Supertubes"
            )
        case 6:
            return DayConfig(
                backgroundColor: .green,
                picture: "Superbank",
                location: "Superbank"
            )
        case 7:
            return DayConfig(
                backgroundColor: .teal,
                picture: "TheBubble",
                location: "The Bubble"
            )
        default:
            return DayConfig(
                backgroundColor: .gray,
                picture: "surfSpot",
                location: "Unknown"
            )
        }
    }
}

//#Preview {
//    DayConfig(
//        backgroundColor: .teal,
//        picture: "TheBubble",
//        location: "The Bubble"
//    )
//}
