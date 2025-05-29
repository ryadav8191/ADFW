//
//  AgendaSection.swift
//  ADFW
//
//  Created by MultiTV on 21/05/25.
//

import UIKit


struct AgendaSection {
    let date: String               // e.g. "09 December 2024"
    let bannerImage: UIImage?
    let year: String           // e.g. UIImage(named: "abu_dhabi_economic_forum_banner")
    let sessions: [AgendaSession]
}

struct AgendaSession {
    let time: String              // e.g. "9:30 - 10:30"
    let title: String             // e.g. "The Keys To Managing Money & Risk"
    let type: String              // e.g. "Panel"
    let location: String          // e.g. "ADFW Arena"
    let tags: [String]            // e.g. ["DM", "2"]
    let speakers: [Speaker]
}

struct Speaker {
    let name: String              // e.g. "Alan Howard"
    let image: UIImage?          // e.g. UIImage(named: "speaker1")
}

