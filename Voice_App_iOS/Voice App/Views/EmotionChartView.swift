//
//  EmotionChartView.swift
//  Voice App
//
//  Created by Sergey Prybysh on 11/19/23.
//

import SwiftUI
import Charts

struct EmotionChartView: View {
    let barData: [Bar]
    
    var body: some View {
        Chart {
            ForEach(barData, id: \.name) { item in
                BarMark(
                    x: .value("Name", item.name),
                    y: .value("Total", item.score)
                )
                .foregroundStyle(by: .value("Color", item.color))
            }
        }
    }
}
