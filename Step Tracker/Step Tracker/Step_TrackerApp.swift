//
//  Step_TrackerApp.swift
//  Step Tracker
//
//  Created by Tyler Rhodes on 4/24/24.
//

import SwiftUI

@main
struct Step_TrackerApp: App {
    
    let hkManager = HealthKitManager()
    
    var body: some Scene {
        WindowGroup {
            DashboardView()
                .environment(hkManager)
        }
    }
}
