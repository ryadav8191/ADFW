//
//  PartnerViewModels.swift
//  ADFW
//
//  Created by MultiTV on 17/06/25.
//


import Foundation
import Combine

struct PartnerViewModels: Identifiable {
    var id: String { title } // use title as ID
    let title: String
    var logos: [String]
}

class PartnerGridViewModel: ObservableObject {
    @Published var partnerSections: [PartnerViewModels] = []

    func removeInvalidLogo(_ logo: String, from sectionTitle: String) {
        if let index = partnerSections.firstIndex(where: { $0.title == sectionTitle }) {
            partnerSections[index].logos.removeAll { $0 == logo }
        }
    }
}
