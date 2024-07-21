//
//  ChartContainer.swift
//  Step Tracker
//
//  Created by Tyler Rhodes on 7/4/24.
//

import SwiftUI

enum ChartType {
    case stepBar(average: Int)
    case stepWeekDayPie
    case weightLine(average: Double)
    case weightDiffBar
}

struct ChartContainer<Content: View>: View {
    
    let chartType: ChartType
    
    @ViewBuilder var content: () -> Content
    
    var body: some View {
        VStack(alignment: .leading) {
            if isNav {
                navigationLinkView
            } else {
                titleView
                    .foregroundStyle(.secondary)
                    .padding(.bottom, 12)
            }
            
            content()
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 12).fill(Color(.secondarySystemBackground)))
    }
    
    var navigationLinkView: some View {
        NavigationLink(value: context) {
            HStack {
                titleView
                Spacer()
                Image(systemName: "chevron.right")
            }
        }
        .foregroundStyle(.secondary)
        .padding(.bottom, 12)
    }
    
    var titleView: some View {
        VStack(alignment: .leading) {
            Label(title, systemImage: symbol)
                .font(.title3.bold())
                .foregroundStyle(context == .steps ? .pink : .indigo)
            
            Text(subtitle)
                .font(.caption)
        }
    }
    
    var isNav: Bool {
        switch chartType {
        case .stepBar(_), .weightLine(_):
            return true
        case .stepWeekDayPie, .weightDiffBar:
            return false
        }
    }
    
    var context: HealthMetricContext {
        switch chartType {
        case .stepBar(_), .stepWeekDayPie:
                .steps
        case .weightLine(_), .weightDiffBar:
                .weight
        }
    }
    
    var title: String {
        switch chartType {
        case .stepBar(_):
                "Steps"
        case .stepWeekDayPie:
            "Averages"
        case .weightLine(_):
            "Weight"
        case .weightDiffBar:
            "Average Weight Change"
        }
    }
    
    var symbol: String {
        switch chartType {
        case .stepBar(_):
            "figure.walk"
        case .stepWeekDayPie:
            "calendar"
        case .weightLine(_), .weightDiffBar:
            "figure"
        }
    }
    
    var subtitle: String {
        switch chartType {
        case .stepBar(let average):
            "Avg: \(average.formatted()) steps"
        case .stepWeekDayPie:
            "Last 28 Days"
        case .weightLine(let average):
            "Avg: \(average.formatted(.number.precision(.fractionLength(1)))) lbs"
        case .weightDiffBar:
            "Per Weekday (Last 28 Days)"
        }
    }
}

#Preview {
    ChartContainer(chartType: .stepWeekDayPie) {
        Text("Chart Goes Here")
            .frame(minHeight: 150)
    }
}
