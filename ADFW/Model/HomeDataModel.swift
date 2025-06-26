//
//  HomeDataModel.swift
//  ADFW
//
//  Created by MultiTV on 25/06/25.
//

import Foundation


struct HomeDataModel: Codable {
    let data : [HomeData]?
    let meta : Meta?

    enum CodingKeys: String, CodingKey {

        case data = "data"
        case meta = "meta"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent([HomeData].self, forKey: .data)
        meta = try values.decodeIfPresent(Meta.self, forKey: .meta)
    }

}


struct HomeData : Codable {
    let id : Int?
    let attributes : HomeAttributes?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case attributes = "attributes"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        attributes = try values.decodeIfPresent(HomeAttributes.self, forKey: .attributes)
    }

}


struct HomeAttributes : Codable {
    let banner_tittle : String?
    let banner_image : String?
    let createdAt : String?
    let updatedAt : String?
    let publishedAt : String?
    let banner_button : String?
    let banner_des : String?
    let banner_presented_by : String?
    let sec_tittle : String?
    let sec_des : String?
    let explore_image : String?
    let explore_tittle : String?
    let explore_des : String?
    let explore_button : String?
    let banner_date : String?
    let banner_date_text : String?
    let days_to_go : String?
    let hash_tag : String?
    let sec_content : String?
    let highlights_tittle : String?
//    let highlights_content : [Highlights_content]?
    let feature_tittle : String?
    let feature_des : String?
    let feature_content : [Feature_content]?
    let mobile_banner : [Mobile_banner]?
    let about_adgm : [About_adgm]?

    enum CodingKeys: String, CodingKey {

        case banner_tittle = "banner_tittle"
        case banner_image = "banner_image"
        case createdAt = "createdAt"
        case updatedAt = "updatedAt"
        case publishedAt = "publishedAt"
        case banner_button = "banner_button"
        case banner_des = "banner_des"
        case banner_presented_by = "banner_presented_by"
        case sec_tittle = "sec_tittle"
        case sec_des = "sec_des"
        case explore_image = "explore_image"
        case explore_tittle = "explore_tittle"
        case explore_des = "explore_des"
        case explore_button = "explore_button"
        case banner_date = "banner_date"
        case banner_date_text = "banner_date_text"
        case days_to_go = "days_to_go"
        case hash_tag = "hash_tag"
        case sec_content = "sec_content"
        case highlights_tittle = "highlights_tittle"
//        case highlights_content = "highlights_content"
        case feature_tittle = "feature_tittle"
        case feature_des = "feature_des"
        case feature_content = "feature_content"
        case mobile_banner = "mobile_banner"
        case about_adgm = "about_adgm"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        banner_tittle = try values.decodeIfPresent(String.self, forKey: .banner_tittle)
        banner_image = try values.decodeIfPresent(String.self, forKey: .banner_image)
        createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
        updatedAt = try values.decodeIfPresent(String.self, forKey: .updatedAt)
        publishedAt = try values.decodeIfPresent(String.self, forKey: .publishedAt)
        banner_button = try values.decodeIfPresent(String.self, forKey: .banner_button)
        banner_des = try values.decodeIfPresent(String.self, forKey: .banner_des)
        banner_presented_by = try values.decodeIfPresent(String.self, forKey: .banner_presented_by)
        sec_tittle = try values.decodeIfPresent(String.self, forKey: .sec_tittle)
        sec_des = try values.decodeIfPresent(String.self, forKey: .sec_des)
        explore_image = try values.decodeIfPresent(String.self, forKey: .explore_image)
        explore_tittle = try values.decodeIfPresent(String.self, forKey: .explore_tittle)
        explore_des = try values.decodeIfPresent(String.self, forKey: .explore_des)
        explore_button = try values.decodeIfPresent(String.self, forKey: .explore_button)
        banner_date = try values.decodeIfPresent(String.self, forKey: .banner_date)
        banner_date_text = try values.decodeIfPresent(String.self, forKey: .banner_date_text)
        days_to_go = try values.decodeIfPresent(String.self, forKey: .days_to_go)
        hash_tag = try values.decodeIfPresent(String.self, forKey: .hash_tag)
        sec_content = try values.decodeIfPresent(String.self, forKey: .sec_content)
        highlights_tittle = try values.decodeIfPresent(String.self, forKey: .highlights_tittle)
//        highlights_content = try values.decodeIfPresent([Highlights_content].self, forKey: .highlights_content)
        feature_tittle = try values.decodeIfPresent(String.self, forKey: .feature_tittle)
        feature_des = try values.decodeIfPresent(String.self, forKey: .feature_des)
        feature_content = try values.decodeIfPresent([Feature_content].self, forKey: .feature_content)
        mobile_banner = try values.decodeIfPresent([Mobile_banner].self, forKey: .mobile_banner)
        about_adgm = try values.decodeIfPresent([About_adgm].self, forKey: .about_adgm)
    }

}


struct Feature_content : Codable {
    let des : String?
    let image_url : String?

    enum CodingKeys: String, CodingKey {

        case des = "des"
        case image_url = "image_url"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        des = try values.decodeIfPresent(String.self, forKey: .des)
        image_url = try values.decodeIfPresent(String.self, forKey: .image_url)
    }

}


struct Mobile_banner : Codable {
    let image_url : String?

    enum CodingKeys: String, CodingKey {

        case image_url = "image_url"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        image_url = try values.decodeIfPresent(String.self, forKey: .image_url)
    }

}

struct About_adgm : Codable {
    let page : Page?
    let sidebarMenu : SidebarMenu?

    enum CodingKeys: String, CodingKey {

        case page = "page"
        case sidebarMenu = "sidebarMenu"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        page = try values.decodeIfPresent(Page.self, forKey: .page)
        sidebarMenu = try values.decodeIfPresent(SidebarMenu.self, forKey: .sidebarMenu)
    }

}


struct Page : Codable {
    let sections : [Sections]?

    enum CodingKeys: String, CodingKey {

        case sections = "sections"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        sections = try values.decodeIfPresent([Sections].self, forKey: .sections)
    }

}
