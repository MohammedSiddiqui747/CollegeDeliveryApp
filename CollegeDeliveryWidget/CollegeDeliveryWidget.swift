//
//  CollegeDeliveryWidget.swift
//  CollegeDeliveryWidget
//
//  Created by Paolo Veloso on 2023-12-11.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    typealias Entry = SimpleEntry

    func placeholder(in context: Context) -> SimpleEntry {
        // Return a placeholder entry
        SimpleEntry(date: Date(), items: [Item.example])
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> Void) {
        // Return a snapshot for preview
        let entry = SimpleEntry(date: Date(), items: [Item.example])
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> Void) {
        // Fetch actual data for the timeline
        let entry = loadItemData()
        let timeline = Timeline(entries: [entry], policy: .atEnd)
        completion(timeline)
    }

    private func loadItemData() -> SimpleEntry {
        let userDefaults = UserDefaults(suiteName: "group.com.ms.CollegeDelivery")
        guard let data = userDefaults?.data(forKey: "ItemList"),
              let items = try? JSONDecoder().decode([Item].self, from: data) else {
            return SimpleEntry(date: Date(), items: [])
        }
        return SimpleEntry(date: Date(), items: items)
    }
}

struct CollegeDeliveryWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
         VStack {
             Image("download") // Replace with your image name
                 .resizable()
                 .scaledToFit()
                 .padding()
         }
     }
}

struct CollegeDeliveryWidget: Widget {
    let kind: String = "CollegeDeliveryWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            if #available(iOS 17.0, *) {
                CollegeDeliveryWidgetEntryView(entry: entry)
                    .containerBackground(.fill.tertiary, for: .widget)
            } else {
                CollegeDeliveryWidgetEntryView(entry: entry)
                    .padding()
                    .background()
            }
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}

