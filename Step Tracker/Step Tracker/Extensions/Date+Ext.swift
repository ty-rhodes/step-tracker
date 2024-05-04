//
//  Date+Ext.swift
//  Step Tracker
//
//  Created by Tyler Rhodes on 5/3/24.
//

import Foundation

extension Date {
    var weekdayInt: Int {
        Calendar.current.component(.weekday, from: self)
    }
    
    var weekdayTitle: String {
        self.formatted(.dateTime.weekday(.wide))
    }
}
