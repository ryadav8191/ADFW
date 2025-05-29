//
//  SpeakerProfile.swift
//  ADFW
//
//  Created by MultiTV on 22/05/25.
//

import Foundation
import UIKit


struct SpeakerProfile {
    let name: String
    let title: String
    let descriptionShort: String
    let descriptionLong: String
    let imageName: String
    let tags: [Tag]
}

struct Tag: Identifiable {
    let id = UUID()
    let title: String
    let color: UIColor
}
