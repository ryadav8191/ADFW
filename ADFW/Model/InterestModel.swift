//
//  IntertestModel.swift
//  ADFW
//
//  Created by MultiTV on 18/06/25.
//


import Foundation

struct InterestModel: Codable {
    var data : [InterestData]?
    let meta : Meta?

    enum CodingKeys: String, CodingKey {

        case data = "data"
        case meta = "meta"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent([InterestData].self, forKey: .data)
        meta = try values.decodeIfPresent(Meta.self, forKey: .meta)
    }

}


struct InterestData : Codable {
    let id : Int?
    var attributes : InterstestAttributes?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case attributes = "attributes"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        attributes = try values.decodeIfPresent(InterstestAttributes.self, forKey: .attributes)
    }

}


struct InterstestAttributes : Codable {
    let label : String?
    let value : String?
    var is_deleted : Bool?
    let createdAt : String?
    let updatedAt : String?
    let publishedAt : String?

    enum CodingKeys: String, CodingKey {

        case label = "label"
        case value = "value"
        case is_deleted = "is_deleted"
        case createdAt = "createdAt"
        case updatedAt = "updatedAt"
        case publishedAt = "publishedAt"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        label = try values.decodeIfPresent(String.self, forKey: .label)
        value = try values.decodeIfPresent(String.self, forKey: .value)
        is_deleted = try values.decodeIfPresent(Bool.self, forKey: .is_deleted)
        createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
        updatedAt = try values.decodeIfPresent(String.self, forKey: .updatedAt)
        publishedAt = try values.decodeIfPresent(String.self, forKey: .publishedAt)
    }

}
