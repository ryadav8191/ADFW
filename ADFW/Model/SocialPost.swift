//
//  SocialPost.swift
//  ADFW
//
//  Created by MultiTV on 21/05/25.
//

import Foundation


struct SocialPost: Identifiable {
    let id = UUID()
    let platform: Platform
    let imageName: String
    let title: String
    let description: String
    let tags: String
}

enum Platform: String {
    case instagram
    case facebook
    case website

    var iconName: String {
        switch self {
        case .instagram: return "camera"
        case .facebook: return "f.circle"
        case .website: return "xmark.shield"
        }
    }
}
