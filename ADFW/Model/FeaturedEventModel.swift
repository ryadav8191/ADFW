//
//  FeaturedEvent.swift
//  ADFW
//
//  Created by MultiTV on 23/06/25.
//

import Foundation

struct FeaturedEventModel : Codable {
    let data : [FeaturedEventData]?
    let meta : Meta?

    enum CodingKeys: String, CodingKey {

        case data = "data"
        case meta = "meta"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent([FeaturedEventData].self, forKey: .data)
        meta = try values.decodeIfPresent(Meta.self, forKey: .meta)
    }

}


struct FeaturedEventData : Codable {
    let id : Int?
    let attributes : FeaturedEventAttributes?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case attributes = "attributes"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        attributes = try values.decodeIfPresent(FeaturedEventAttributes.self, forKey: .attributes)
    }

}


struct FeaturedEventAttributes : Codable {

    let image4 : String?
    

    enum CodingKeys: String, CodingKey {

     
        case image4 = "image4"
       
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        image4 = try values.decodeIfPresent(String.self, forKey: .image4)
        
    }

}
