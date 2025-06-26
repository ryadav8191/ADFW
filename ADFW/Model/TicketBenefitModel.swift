//
//  TicketBenefitModel.swift
//  ADFW
//
//  Created by MultiTV on 24/06/25.
//

import Foundation


struct TicketBenefitModel : Codable {
    let status : Bool?
    let message : String?
    let data : [TicketBenefitData]?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case message = "message"
        case data = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        data = try values.decodeIfPresent([TicketBenefitData].self, forKey: .data)
    }

}


struct TicketBenefitData : Codable {
    let day : String?
    let benefits : [Benefits]?

    enum CodingKeys: String, CodingKey {

        case day = "day"
        case benefits = "benefits"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        day = try values.decodeIfPresent(String.self, forKey: .day)
        benefits = try values.decodeIfPresent([Benefits].self, forKey: .benefits)
    }

}


struct Benefits : Codable {
    let name : String?
    let id : Int?
    let venue : Venue?

    enum CodingKeys: String, CodingKey {

        case name = "name"
        case id = "id"
        case venue = "venue"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        venue = try values.decodeIfPresent(Venue.self, forKey: .venue)
    }

}


struct Venue : Codable {
    let name : String?

    enum CodingKeys: String, CodingKey {

        case name = "name"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decodeIfPresent(String.self, forKey: .name)
    }

}
