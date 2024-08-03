//
//  HealthMetric.swift
//  Step Tracker
//
//  Created by Tyler Rhodes on 4/30/24.
//

import Foundation

struct HealthMetric: Identifiable {
    let id = UUID()
    let date: Date
    let value: Double
}
