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
    
    static func formattedTimeString(from dateString: String) -> String? {
        let inputFormatter = ISO8601DateFormatter()
        inputFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]

        guard let date = inputFormatter.date(from: dateString) else {
            return nil
        }

        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "hh:mm a"
        outputFormatter.locale = Locale(identifier: "en_US_POSIX")
        return outputFormatter.string(from: date)
    }

    static func formattedDateString(from dateString: String) -> String? {
        let inputFormatter = ISO8601DateFormatter()
        inputFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]

        guard let date = inputFormatter.date(from: dateString) else {
            return nil
        }

        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "MMM d"
        outputFormatter.locale = Locale(identifier: "en_US_POSIX")
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
 
    static func extractYearFromISODate(_ dateString: String) -> String? {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        inputFormatter.locale = Locale(identifier: "en_US_POSIX")
        inputFormatter.timeZone = TimeZone(secondsFromGMT: 0)

        guard let date = inputFormatter.date(from: dateString) else {
            return nil
        }

        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "yyyy"
        return outputFormatter.string(from: date)
    }
    
    static func extractDate(from isoString: String) -> String? {
        let isoFormatter = ISO8601DateFormatter()
        isoFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]

        guard let date = isoFormatter.date(from: isoString) else {
            return nil
        }

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.timeZone = TimeZone.current // Or use TimeZone(abbreviation: "UTC")

        return dateFormatter.string(from: date)
    }

   
    static func formatISODateToDayFullMonth(_ dateString: String) -> String? {
        let cleaned = dateString.replacingOccurrences(of: " ", with: "")

        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        inputFormatter.locale = Locale(identifier: "en_US_POSIX")
        inputFormatter.timeZone = TimeZone(secondsFromGMT: 0)

        guard let date = inputFormatter.date(from: cleaned) else {
            return nil
        }

        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "d MMMM"
        return outputFormatter.string(from: date)
    }

}
