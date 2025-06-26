//
//  UpdateProfileModel.swift
//  ADFW
//
//  Created by MultiTV on 23/06/25.
//

import Foundation


struct UpdateProfileModel : Codable {
    let data : UpdateProfileData?
    let meta : Meta?

    enum CodingKeys: String, CodingKey {

        case data = "data"
        case meta = "meta"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent(UpdateProfileData.self, forKey: .data)
        meta = try values.decodeIfPresent(Meta.self, forKey: .meta)
    }

}

struct UpdateProfileData : Codable {
    let id : Int?
    let attributes : User?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case attributes = "attributes"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        attributes = try values.decodeIfPresent(User.self, forKey: .attributes)
    }

}
