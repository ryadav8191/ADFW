//
//  RestaurantModel.swift
//  ADFW
//
//  Created by MultiTV on 20/06/25.
//

import Foundation



struct RestaurantModel : Codable {
    var data : [RestaurantData]?
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
        data = try values.decodeIfPresent([RestaurantData].self, forKey: .data)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        pagination = try values.decodeIfPresent(Pagination.self, forKey: .pagination)
    }

}


struct RestaurantData : Codable {
    let venue_id : Int?
    let venue_name : String?
    let venue_image : String?
    let venue_banner_logo : String?
    var restaurants : [Restaurants]?

    enum CodingKeys: String, CodingKey {

        case venue_id = "venue_id"
        case venue_name = "venue_name"
        case venue_image = "venue_image"
        case venue_banner_logo = "venue_banner_logo"
        case restaurants = "restaurants"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        venue_id = try values.decodeIfPresent(Int.self, forKey: .venue_id)
        venue_name = try values.decodeIfPresent(String.self, forKey: .venue_name)
        venue_image = try values.decodeIfPresent(String.self, forKey: .venue_image)
        venue_banner_logo = try values.decodeIfPresent(String.self, forKey: .venue_banner_logo)
        restaurants = try values.decodeIfPresent([Restaurants].self, forKey: .restaurants)
    }

}



struct Restaurants : Codable {
    let restaurant_id : Int?
    let restaurant_name : String?
    let restaurant_logo : String?
    let restaurant_description : String?
    let restaurant_order : Int?
    let restaurant_perma_link : String?

    enum CodingKeys: String, CodingKey {

        case restaurant_id = "restaurant_id"
        case restaurant_name = "restaurant_name"
        case restaurant_logo = "restaurant_logo"
        case restaurant_description = "restaurant_description"
        case restaurant_order = "restaurant_order"
        case restaurant_perma_link = "restaurant_perma_link"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        restaurant_id = try values.decodeIfPresent(Int.self, forKey: .restaurant_id)
        restaurant_name = try values.decodeIfPresent(String.self, forKey: .restaurant_name)
        restaurant_logo = try values.decodeIfPresent(String.self, forKey: .restaurant_logo)
        restaurant_description = try values.decodeIfPresent(String.self, forKey: .restaurant_description)
        restaurant_order = try values.decodeIfPresent(Int.self, forKey: .restaurant_order)
        restaurant_perma_link = try values.decodeIfPresent(String.self, forKey: .restaurant_perma_link)
    }

}
