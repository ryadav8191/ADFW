//
//  Session.swift
//  ADFW
//
//  Created by MultiTV on 21/05/25.
//


import SwiftUI

struct Session: Identifiable {
    let id = UUID()
    let date: String
    let title: String
    let description: String
    let time: String
    let location: String
    let bannerImage: String
    let speakers: [Person]
    let moderators: [Person]
}

struct Person: Identifiable {
    let id = UUID()
    let name: String
    let title: String
    let organization: String
    let imageName: String
}
