//
//  WaveSafariWidget.swift
//  WaveSafariWidget
//
//  Created by N N on 15/12/2023.
//

import WidgetKit
import SwiftUI

struct Provider: AppIntentTimelineProvider {
    // Dummy widget
    func placeholder(in context: Context) -> DayEntry {
        DayEntry(date: Date(), configuration: ConfigurationAppIntent())
    }

    func snapshot(for configuration: ConfigurationAppIntent, in context: Context) async -> DayEntry {
        DayEntry(date: Date(), configuration: configuration)
    }

    func timeline(for configuration: ConfigurationAppIntent, in context: Context) async -> Timeline<DayEntry> {
        var entries: [DayEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for dayOffset in 0 ..< 7 {
            let entryDate = Calendar.current.date(byAdding: .day, value: dayOffset, to: currentDate)!
            let startOfDate = Calendar.current.startOfDay(for: entryDate)
            let entry = DayEntry(date: startOfDate, configuration: configuration)
            entries.append(entry)
        }

        return Timeline(entries: entries, policy: .atEnd) // Update after 24 hours
    }
}

struct DayEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationAppIntent
}

struct WaveSafariWidgetEntryView : View {
    var entry: DayEntry
    var config: DayConfig

    init(entry: DayEntry) {
        self.entry = entry
        self.config = DayConfig.determineConfig(from: entry.date)
    }

    var body: some View {
        ZStack {
            // Background color in case the picture doesn't load
            ContainerRelativeShape()
                .fill(config.backgroundColor.gradient)
                .padding(.horizontal, -16)
                .padding(.vertical, -8)

            VStack(spacing: 0) {
                Text(entry.date.weekdayDisplayFormat)
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .minimumScaleFactor(0.7) // Reduce the text length if too long so that it fits in one line

                ZStack {
                    Text(entry.date.dayDisplayFormat)
                        .font(.system(size: 70, weight: .heavy))
                        .fontWeight(.bold)
                        .foregroundColor(.black.opacity(0.3))
                }
                // ToDo: Update with spot location
                Text("-\(config.location)")
                .font(.system(size: 10))
                .foregroundColor(.black.opacity(0.7))
                .fontWeight(.bold)
                .padding(.top, -4)
            }
            .background(
                // ToDo: Fix spot picture in config
//                Image(config.picture)
                Image("Superbank")
                        .resizable()
                        .scaledToFill()
                        .padding(.vertical, -24)
                )
            .padding()
        }
    }
}

struct WaveSafariWidget: Widget {
    let kind: String = "WaveSafariWidget"

    var body: some WidgetConfiguration {
        AppIntentConfiguration(kind: kind, intent: ConfigurationAppIntent.self, provider: Provider()) { entry in
            WaveSafariWidgetEntryView(entry: entry)
                .containerBackground(.fill.tertiary, for: .widget)
        }
        .configurationDisplayName("Wave Safari Widget")
        .description("The widget provides a different quote and picture every day of the week.")
        .supportedFamilies([.systemSmall])
    }
}

extension ConfigurationAppIntent {
    fileprivate static var smiley: ConfigurationAppIntent {
        let intent = ConfigurationAppIntent()
        intent.favoriteEmoji = "😀"
        return intent
    }

    fileprivate static var starEyes: ConfigurationAppIntent {
        let intent = ConfigurationAppIntent()
        intent.favoriteEmoji = "🤩"
        return intent
    }
}

extension Date {
    var weekdayDisplayFormat: String {
        self.formatted(.dateTime.weekday(.wide))
    }
    var dayDisplayFormat: String {
        self.formatted(.dateTime.day())
    }
}

#Preview(as: .systemSmall) {
    WaveSafariWidget()
} timeline: {
    DayEntry(date: .now, configuration: .smiley)
    DayEntry(date: .distantPast, configuration: .init())
    DayEntry(date: .distantFuture, configuration: .smiley)
}
