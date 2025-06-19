//
//  CountryResponse.swift
//  ADFW
//
//  Created by MultiTV on 18/06/25.
//


struct CountryResponse: Codable {
    let data: [CountryData]?
}

struct CountryData: Codable {
    let id: Int?
    let attributes: CountryAttributes?
}

struct CountryAttributes: Codable {
    let country: String?
    let code: String?
    let flag: String?
}
