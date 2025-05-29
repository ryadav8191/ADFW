//
//  DateUtils.swift
//  MSVC2025
//
//  Created by MultiTV on 12/04/25.
//

import Foundation

class DateUtils {
    
    /// Converts a date string like "2025-12-01" to a readable format like "1st Dec"
    static func convertToReadableDate(_ dateString: String, inputFormat: String = "yyyy-MM-dd") -> String? {
        let formatter = DateFormatter()
        formatter.dateFormat = inputFormat
        formatter.locale = Locale(identifier: "en_US_POSIX") // Ensures consistent parsing
        
        guard let date = formatter.date(from: dateString) else { return nil }
        
        let calendar = Calendar.current
        let day = calendar.component(.day, from: date)
        let month = calendar.monthSymbols[calendar.component(.month, from: date) - 1]
        
        return "\(day)\(daySuffix(for: day)) \(month)"
    }
    
    
       static func daySuffix(for day: Int) -> String {
           switch day {
           case 11, 12, 13: return "th"
           default:
               switch day % 10 {
               case 1: return "st"
               case 2: return "nd"
               case 3: return "rd"
               default: return "th"
               }
           }
       }
    
}
