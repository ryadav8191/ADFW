//
//  HeaderInfo.swift
//  ADFW
//
//  Created by MultiTV on 23/05/25.
//

import Foundation


// MARK: - Models

struct HeaderInfo: Identifiable {
    let id = UUID()
    let imageURL: URL
    let title: String
    let subtitle: String
    let description: String
}

struct CardInfo: Identifiable {
    let id = UUID()
    let imageURL: URL
    let title: String
    let description: String
}

struct FAQItem: Identifiable {
    let id = UUID()
    let question: String
    let answer: String
}

struct ContactInfo {
    let address: String
    let hours: [ContactHour]
    let socialMediaLinks: [URL]
}

struct ContactHour: Identifiable {
    let id = UUID()
    let day: String
    let time: String
}
