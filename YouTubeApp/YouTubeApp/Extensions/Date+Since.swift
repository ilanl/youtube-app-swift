//
//  Date+Friendly.swift
//  YouTubeApp
//
//  Created by IlanL on 17/11/2017.
//  Copyright © 2017 IlanL. All rights reserved.
//

import Foundation

extension Date {
    
    var since: String {
        
        get {
            
            let start = self
            let end = Date()
            let components = Calendar.current.dateComponents([.year, .month, .weekOfYear, .day, .hour, .minute, .second], from: start, to: end)
            
            var significance: String = ""
            if let years = components.year, years > 0 {
                significance = years == 1 ? "\(years) year" : "\(years) years"
            }
            else if let months = components.month, months > 0 {
                significance = months == 1 ? "\(months) month" : "\(months) months"
            }
            else if let weeks = components.weekOfYear, weeks > 0 {
                significance = weeks == 1 ? "\(weeks) week" : "\(weeks) weeks"
            }
            else if let days = components.day, days > 0 {
                significance = days == 1 ? "\(days) day" : "\(days) days"
            }
            else if let hours = components.hour, hours > 0 {
                significance = hours == 1 ? "\(hours) hour" : "\(hours) hours"
            }
            else if let minutes = components.minute, minutes > 0 {
                significance = minutes == 1 ? "\(minutes) min" : "\(minutes) mins"
            }
            else if let seconds = components.second, seconds > 0 {
                significance = seconds == 1 ? "\(seconds) second" : "\(seconds) seconds"
            }
            
            return "\(significance) ago"
        }
    }
}
