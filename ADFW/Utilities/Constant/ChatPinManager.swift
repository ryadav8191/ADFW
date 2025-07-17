//
//  ChatPinManager.swift
//  ADFW
//
//  Created by MultiTV on 09/07/25.
//


import Foundation

class ChatPinManager {
    
    private static let key = "PinnedUserIds"
    private(set) static var pinnedUserIds: Set<String> = []

    static func load() {
        if let saved = UserDefaults.standard.array(forKey: key) as? [String] {
            pinnedUserIds = Set(saved)
        }
    }

    static func save() {
        UserDefaults.standard.set(Array(pinnedUserIds), forKey: key)
    }

    static func pin(userId: String) {
        pinnedUserIds.insert(userId)
        save()
    }

    static func unpin(userId: String) {
        pinnedUserIds.remove(userId)
        save()
    }

    static func isPinned(userId: String) -> Bool {
        return pinnedUserIds.contains(userId)
    }
}
