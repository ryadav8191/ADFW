//
//  Helper.swift
//  ADFW
//
//  Created by MultiTV on 10/06/25.
//

import Foundation


class Helper {
    
    static func formatToDayMonth(from dateString: String) -> String? {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd"

        guard let date = inputFormatter.date(from: dateString) else {
            return nil
        }

        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "d MMM"
        return outputFormatter.string(from: date)
    }

    
    static func extractYear(from dateString: String) -> String? {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd"

        guard let date = inputFormatter.date(from: dateString) else {
            return nil
        }

        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "yyyy"
        return outputFormatter.string(from: date)
    }

    static func formatToDayFullMonth(from dateString: String) -> String? {
        // 1. Clean up any stray spaces
        let cleaned = dateString.replacingOccurrences(of: " ", with: "")

        // 2. Parse into a Date
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd"
        guard let date = inputFormatter.date(from: cleaned) else {
            return nil
        }

        // 3. Format as "day full-month"
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "d MMMM"
        return outputFormatter.string(from: date)
    }

}
