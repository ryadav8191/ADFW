//
//  SessionViewModel.swift
//  ADFW
//
//  Created by MultiTV on 21/05/25.
//

import Foundation


class SessionViewModel: ObservableObject {
    @Published var session: Session?

    init() {
        loadSession()
    }

    func loadSession() {
        // You could replace this with actual API logic
        session = Session(
            date: "09 December 2024",
            title: "An Address from the UAE Minister of Climate Change & Environment",
            description: "Speaking in the days before pivotal COP28, Dubai, the UAE Minister of Climate Change & Environment offers her position on the critical role of private finance and capital in achieving sustainability targets.",
            time: "9:30 - 10:30",
            location: "ADFW Arena",
            bannerImage: "event_banner",
            speakers: [
                Person(name: "Bhaskar Dasgupta", title: "Chairman Of The Board", organization: "Apex Group (Middle East And India)", imageName: "person1"),
                Person(name: "Wolfgang Engel", title: "General Manager", organization: "Institute Of International Finance", imageName: "person2"),
                Person(name: "Junaid Wahedna", title: "Founder And Chairman", organization: "Wahed", imageName: "person3")
            ],
            moderators: [
                Person(name: "Martina Fuchs", title: "Business Correspondent", organization: "Xinhua", imageName: "person3")
            ]
        )
    }
}
