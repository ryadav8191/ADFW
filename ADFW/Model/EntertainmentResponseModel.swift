//
//  EntertainmentResponseModel.swift
//  ADFW
//
//  Created by MultiTV on 06/06/25.
//


import Foundation

// MARK: - EntertainmentResponseModel
struct EntertainmentResponseModel: Codable {
    let status: Bool?
    let message: String?
    let data: EntertainmentModel?
}

// MARK: - DataClass
struct EntertainmentModel: Codable {
    let entertainments: [Entertainment]?
    let pagination: EnetrPagination?
}

// MARK: - Entertainment
struct Entertainment: Codable {
    let banner: String?
    let name: String?
    let artists: [Artist]?
}

// MARK: - Artist
struct Artist: Codable {
    let date: String?
    let shows: [Show]?
}

// MARK: - Show
struct Show: Codable {
    let id: Int?
    let name: String?
    let image: String?
    let bio, time: String?
    let isDeleted: Bool?
    let day: String?
    let date, createdAt, updatedAt, publishedAt: String?
    let location: EnterLocation?

    enum CodingKeys: String, CodingKey {
        case id, name, image, bio, time
        case isDeleted = "is_deleted"
        case day, date, createdAt, updatedAt, publishedAt, location
    }
}

// MARK: - Location
struct EnterLocation: Codable {
    let id: Int?
    let name: String?
    let isDeleted: Bool?
    let label, createdAt, updatedAt, publishedAt: String?
    let fullAddress: String?
    let latitude, longitude: String?
    let hideFilter: Bool?
    let image: String?
    let showMap: Bool?
    let bannerLogo: String?

    enum CodingKeys: String, CodingKey {
        case id, name
        case isDeleted = "is_deleted"
        case label, createdAt, updatedAt, publishedAt, fullAddress, latitude, longitude, hideFilter, image, showMap, bannerLogo
    }
}

// MARK: - Pagination
struct EnetrPagination: Codable {
    let page, pageSize, pageCount, total: Int?
}
