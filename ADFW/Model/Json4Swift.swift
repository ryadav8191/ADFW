//
//  Json4Swift.swift
//  ADFW
//
//  Created by MultiTV on 07/07/25.
//

import Foundation

struct UserInterestModel : Codable {
	let status : Bool?
	let message : String?
	let data : [UserInterestData]?

	enum CodingKeys: String, CodingKey {

		case status = "status"
		case message = "message"
		case data = "data"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		status = try values.decodeIfPresent(Bool.self, forKey: .status)
		message = try values.decodeIfPresent(String.self, forKey: .message)
		data = try values.decodeIfPresent([UserInterestData].self, forKey: .data)
	}

}
struct UserInterestData : Codable,Hashable {
//    let id : Int?
    let label : String?
    let value : String?
//    let is_deleted : Bool?
//    let createdAt : String?
//    let updatedAt : String?
//    let publishedAt : String?

    enum CodingKeys: String, CodingKey {

//        case id = "id"
        case label = "label"
        case value = "value"
//        case is_deleted = "is_deleted"
//        case createdAt = "createdAt"
//        case updatedAt = "updatedAt"
//        case publishedAt = "publishedAt"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
//        id = try values.decodeIfPresent(Int.self, forKey: .id)
        label = try values.decodeIfPresent(String.self, forKey: .label)
        value = try values.decodeIfPresent(String.self, forKey: .value)
//        is_deleted = try values.decodeIfPresent(Bool.self, forKey: .is_deleted)
//        createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
//        updatedAt = try values.decodeIfPresent(String.self, forKey: .updatedAt)
//        publishedAt = try values.decodeIfPresent(String.self, forKey: .publishedAt)
    }
    
    init(label:String, value:String) {
        self.label = label
        self.value = value
    }

}
