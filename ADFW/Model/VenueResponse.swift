//
//  VenueResponse.swift
//  ADFW
//
//  Created by MultiTV on 18/06/25.
//


struct VenueResponse: Codable {
    let data: [VenueData]?
}

struct VenueData: Codable {
    let id: Int?
    let attributes: VenueAttributes?
}

struct VenueAttributes: Codable {
    let name: String?
    let latitude: String?
    let longitude: String?
    let image: String?
}

