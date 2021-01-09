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
    
    @AppStorage("garage", store: UserDefaults(suiteName: "group.com.robberamon.ParkValley"))
    var garageData: Data = Data()
    
    // placeholder string
    func placeholder(in context: Context) -> GarageEntry {
        GarageEntry(date: Date(), configuration: ConfigurationIntent(), text: "Recently visited garage")
    }

    // placeholder string
    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (GarageEntry) -> ()) {

        let garage = try? JSONDecoder().decode(Garage.self, from: garageData)
        
        var string = "..."
        
        if garage != nil {
            string = garage!.name!
        }
        
        let entry = GarageEntry(date: Date(), configuration: configuration, text: string)
        completion(entry)
    }

    // main logic
    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        
        
        var entries: [GarageEntry] = []
        
        let currentDate = Date()
        
        // fill string here from provider
        let garage = try? JSONDecoder().decode(Garage.self, from: garageData)
        
        var string = "..."
        
        if garage != nil {
            string = garage!.name!
        }
        
        let entry = GarageEntry(date: currentDate, configuration: configuration, text: string)
        entries.append(entry)

        // this will refresh the widget periodically documentation: https://developer.apple.com/documentation/widgetkit/keeping-a-widget-up-to-date
        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct GarageEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationIntent
    let text: String
}

// widget look
struct ParkValleyWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        //Text(entry.date, style: .time)
        
        ZStack {
            //Color.black.edgesIgnoringSafeArea(.all)
            
            Text(entry.text)
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
        .configurationDisplayName("ParkValley")
        .description("Add this widget to your phone.")
    }
}

// preview
struct ParkValleyWidget_Previews: PreviewProvider {
    static var previews: some View {
        ParkValleyWidgetEntryView(entry: GarageEntry(date: Date(), configuration: ConfigurationIntent(), text:"..."))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
