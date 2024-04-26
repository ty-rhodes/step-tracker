//
//  HealthKitManager.swift
//  Step Tracker
//
//  Created by Tyler Rhodes on 4/26/24.
//

import Foundation
import HealthKit
import Observation

@Observable class HealthKitManager {
    
    let store = HKHealthStore()
    
    let types: Set = [HKQuantityType(.stepCount), HKQuantityType(.bodyMass)]
}
