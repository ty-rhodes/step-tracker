//
//  WeightLineChart.swift
//  Step Tracker
//
//  Created by Tyler Rhodes on 5/17/24.
//

import SwiftUI
import Charts

struct WeightLineChart: View {
    
    @State private var rawSelectedDate: Date?
    @State private var selectedDay: Date?
    
    var chartData: [DateValueChartData]
    
    var minValue: Double {
        chartData.map { $0.value }.min() ?? 0
    }
    
    var selectedData: DateValueChartData? {
        ChartHelper.parseSelectedData(from: chartData, in: rawSelectedDate)
    }
    
    var subtitle: String {
        let average = chartData.map { $0.value}.average
        return "Avg: \(average.formatted(.number.precision(.fractionLength(1)))) lbs"
    }
    
    var body: some View {
        ChartContainer(title: "Weight",
                       symbol: "figure",
                       subtitle: subtitle,
                       context: .weight,
                       isNav: true) {
            Chart {
                if let selectedData {
                    RuleMark(x: .value("Selected Metric", selectedData.date, unit: .day))
                        .foregroundStyle(Color.secondary.opacity(0.3))
                        .offset(y: -10)
                        .annotation(position: .top,
                                    spacing: 0,
                                    overflowResolution: .init(x: .fit(to: .chart), y: .disabled)) {
                            ChartAnnotationView(data: selectedData, context: .weight)
                        }
                }
                
                RuleMark(y: .value("Goal", 155))
                    .foregroundStyle(.mint)
                    .lineStyle(.init(lineWidth: 1, dash: [5]))
                
                ForEach(chartData) { weight in
                    AreaMark(x: .value("Day", weight.date),
                             yStart: .value("Value", weight.value),
                             yEnd: .value("Min Value", minValue)
                    )
                    .foregroundStyle(Gradient(colors: [.indigo.opacity(0.5), .clear]))
                    .interpolationMethod(.catmullRom)
                    
                    LineMark(
                        x: .value("Day", weight.date, unit: .day),
                        y: .value("Value", weight.value)
                    )
                    .foregroundStyle(.indigo)
                    .interpolationMethod(.catmullRom)
                    .symbol(.circle)
                }
            }
            .frame(height: 150)
            .chartXSelection(value: $rawSelectedDate)
            .chartYScale(domain: .automatic(includesZero: false))
            .chartXAxis {
                AxisMarks {
                    AxisValueLabel(format: .dateTime.month(.defaultDigits).day())
                }
            }
            .chartYAxis {
                AxisMarks { value in
                    AxisGridLine()
                        .foregroundStyle(Color.secondary.opacity(0.3))
                    AxisValueLabel()
                }
            }
            if chartData.isEmpty {
                ChartEmptyView(systemImageName: "chart.line.downtrend.xy", title: "No Data", description: "There is no weight data from the Health App")
            }
        }
                       .sensoryFeedback(.selection, trigger: selectedDay)
                       .onChange(of: rawSelectedDate) { oldValue, newValue in
                           if oldValue?.weekdayInt != newValue?.weekdayInt {
                               selectedDay = newValue
                           }
                       }
    }
}

#Preview {
    WeightLineChart(chartData: ChartHelper.convert(data: MockData.weights))
}
