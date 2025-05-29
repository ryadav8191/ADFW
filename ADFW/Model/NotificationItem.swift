//
//  NotificationItem.swift
//  ADFW
//
//  Created by MultiTV on 20/05/25.
//

import Foundation


struct NotificationItem: Identifiable {
    let id = UUID()
    let date: String
    let time: String
    let title: String
    let description: String
    let iconName: String
    let isLive: Bool
}
