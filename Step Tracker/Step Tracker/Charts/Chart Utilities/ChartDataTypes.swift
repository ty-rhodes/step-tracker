//
//  ChartDataTypes.swift
//  Step Tracker
//
//  Created by Tyler Rhodes on 5/3/24.
//

import Foundation

struct DateValueChartData: Identifiable, Equatable {
    let id = UUID()
    let date: Date
    let value: Double
}
