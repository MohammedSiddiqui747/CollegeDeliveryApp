//
//  WidgetEntryView.swift
//  CollegeDeliveryWidgetExtension
//
//  Created by Paolo Veloso on 2023-12-11.
//

import SwiftUI
import WidgetKit

struct WidgetEntryView: View {
    let entry: Provider.Entry

    var body: some View {
            VStack {
                ForEach(entry.items, id: \.id) { item in
                    VStack(alignment: .leading) {
                        Text(item.itemName)
                            .font(.headline)
                        Text(item.itemDesc)
                            .font(.subheadline)
                        Text(item.itemLoc)
                            .font(.subheadline)
                    }
                    .padding()
                }
            }
        }
}
