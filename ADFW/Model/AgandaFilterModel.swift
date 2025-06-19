//
//  AgandaFilterModel.swift
//  ADFW
//
//  Created by MultiTV on 11/06/25.
//

import Foundation


import Foundation
struct AgandaFilterModel : Codable {
    let data : [AgandaFilterData]?
    let meta : Meta?

    enum CodingKeys: String, CodingKey {

        case data = "data"
        case meta = "meta"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent([AgandaFilterData].self, forKey: .data)
        meta = try values.decodeIfPresent(Meta.self, forKey: .meta)
    }

}


struct AgandaFilterData : Codable {
    let id : Int?
    let attributes : AgandaFilter?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case attributes = "attributes"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        attributes = try values.decodeIfPresent(AgandaFilter.self, forKey: .attributes)
    }

}


struct AgandaFilter : Codable {
    let title : String?
    

    enum CodingKeys: String, CodingKey {

        case title = "title"

    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        
    }

}
