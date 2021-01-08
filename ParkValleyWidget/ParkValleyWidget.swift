//
//  ParkValleyWidget.swift
//  ParkValleyWidget
//
//  Created by Robbe on 07/01/2021.
//

import WidgetKit
import SwiftUI
import Intents

struct Provider: IntentTimelineProvider {
    
    // placeholder string
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: ConfigurationIntent(), myString: "...")
    }

    // placeholder string
    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), configuration: configuration, myString: "...")
        completion(entry)
    }

    // main logic
    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            
            // fill string here from provider
            let entry = SimpleEntry(date: entryDate, configuration: configuration, myString: DataProvider.getString())
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationIntent
    let myString: String
}

// widget look
struct ParkValleyWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        //Text(entry.date, style: .time)
        
        ZStack {
            //Color.black.edgesIgnoringSafeArea(.all)
            
            Text(entry.myString)
                .foregroundColor(.white)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(
                        Image("city-widget")
                            .resizable()
                            .scaledToFill()
                    )
            
        }
    }
}

@main
struct ParkValleyWidget: Widget {
    let kind: String = "ParkValleyWidget"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            ParkValleyWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}

// preview
struct ParkValleyWidget_Previews: PreviewProvider {
    static var previews: some View {
        ParkValleyWidgetEntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent(), myString:"Random String"))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
