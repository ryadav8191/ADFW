//
//  Session.swift
//  ADFW
//
//  Created by MultiTV on 21/05/25.
//


import SwiftUI
import Foundation



struct Session: Identifiable {
    let id: Int
    let agandaId: Int
    let date: String
    let year: String
    let title: String
    let description: String
    let time: String
    let location: String
    let bannerImage: String
    let speakers: [Speaker]
    let moderators: Speaker?
}






struct Speaker: Identifiable {
    let id: Int
    let name: String
    let role: String
    let imageUrl: String
    let companyName: String?
}


extension Speaker {
    init(from model: EventAgandaSpeakers?) {
        self.id = model?.id ?? 0
        let first = model?.firstName ?? ""
        let last = model?.lastName ?? ""
        self.name = "\(first) \(last)".trimmingCharacters(in: .whitespaces)
        self.role = model?.designation ?? ""
        self.imageUrl = model?.photoUrl ?? ""
       
        self.companyName = model?.companyName ?? ""
    }

    init(from model: FavouriteSpeakers?) {
        self.id = model?.id ?? 0
        let first = model?.first_name ?? ""
        let last = model?.last_name ?? ""
        self.name = "\(first) \(last)".trimmingCharacters(in: .whitespaces)
        self.role = model?.designation ?? ""
        self.imageUrl = model?.photo_url ?? ""
        self.companyName = model?.companyName ?? ""
    }
}



struct Person: Identifiable {
    let id = UUID()
    let name: String
    let title: String
    let organization: String
    let imageName: String
}
