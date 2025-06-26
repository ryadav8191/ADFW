//
//  MenuModel.swift
//  ADFW
//
//  Created by MultiTV on 20/06/25.
//

import Foundation

struct MenuModel : Codable {
    let data : MenuData?
    let status : Bool?
    let message : String?
    let pagination : Pagination?

    enum CodingKeys: String, CodingKey {

        case data = "data"
        case status = "status"
        case message = "message"
        case pagination = "pagination"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent(MenuData.self, forKey: .data)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        pagination = try values.decodeIfPresent(Pagination.self, forKey: .pagination)
    }

}


struct MenuData : Codable {
    let name : String?
    let logo : String?
    let bannerImage : String?
    let image1 : String?
    let items : [Items]?

    enum CodingKeys: String, CodingKey {

        case name = "name"
        case logo = "logo"
        case bannerImage = "bannerImage"
        case image1 = "image1"
        case items = "items"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        logo = try values.decodeIfPresent(String.self, forKey: .logo)
        bannerImage = try values.decodeIfPresent(String.self, forKey: .bannerImage)
        image1 = try values.decodeIfPresent(String.self, forKey: .image1)
        items = try values.decodeIfPresent([Items].self, forKey: .items)
    }

}

struct Items : Codable {
 
    let category_id : Int?
    let category_name : String?
    let category_value : String?
    let category_image : String?
    let items : [ItemData]?

    enum CodingKeys: String, CodingKey {

        case category_id = "category_id"
        case category_name = "category_name"
        case category_value = "category_value"
        case category_image = "category_image"
        case items = "items"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        category_id = try values.decodeIfPresent(Int.self, forKey: .category_id)
        category_name = try values.decodeIfPresent(String.self, forKey: .category_name)
        category_value = try values.decodeIfPresent(String.self, forKey: .category_value)
        category_image = try values.decodeIfPresent(String.self, forKey: .category_image)
        items = try values.decodeIfPresent([ItemData].self, forKey: .items)
    }

}



struct ItemData : Codable {
    let item_id : Int?
    let item_name : String?
    let item_image : String?
    let item_price : Int?
    let item_description : String?
    let item_is_available : Bool?

    enum CodingKeys: String, CodingKey {

        case item_id = "item_id"
        case item_name = "item_name"
        case item_image = "item_image"
        case item_price = "item_price"
        case item_description = "item_description"
        case item_is_available = "item_is_available"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        item_id = try values.decodeIfPresent(Int.self, forKey: .item_id)
        item_name = try values.decodeIfPresent(String.self, forKey: .item_name)
        item_image = try values.decodeIfPresent(String.self, forKey: .item_image)
        item_price = try values.decodeIfPresent(Int.self, forKey: .item_price)
        item_description = try values.decodeIfPresent(String.self, forKey: .item_description)
        item_is_available = try values.decodeIfPresent(Bool.self, forKey: .item_is_available)
    }

}
