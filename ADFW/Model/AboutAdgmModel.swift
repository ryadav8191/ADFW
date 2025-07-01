//
//  AboutAdgmModel.swift
//  ADFW
//
//  Created by MultiTV on 26/06/25.

import Foundation


struct AboutAdgmModel : Codable {
    let data : [AboutAdgmData]?
    let meta : Meta?

    enum CodingKeys: String, CodingKey {

        case data = "data"
        case meta = "meta"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent([AboutAdgmData].self, forKey: .data)
        meta = try values.decodeIfPresent(Meta.self, forKey: .meta)
    }

}


struct AboutAdgmData : Codable {
    let id : Int?
    let attributes : AboutAdgmAttributes?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case attributes = "attributes"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        attributes = try values.decodeIfPresent(AboutAdgmAttributes.self, forKey: .attributes)
    }

}
struct AboutAdgmAttributes : Codable {
    let banner_img : String?
    let banner_tittle : String?
    let banner_sub_tittle : String?
    let banner_des : String?
    let banner_content : [Banner_content]?
    let questions : [Questions]?
    let contact : [Contact]?
    let createdAt : String?
    let updatedAt : String?
    let publishedAt : String?

    enum CodingKeys: String, CodingKey {

        case banner_img = "banner_img"
        case banner_tittle = "banner_tittle"
        case banner_sub_tittle = "banner_sub_tittle"
        case banner_des = "banner_des"
        case banner_content = "banner_content"
        case questions = "questions"
        case contact = "contact"
        case createdAt = "createdAt"
        case updatedAt = "updatedAt"
        case publishedAt = "publishedAt"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        banner_img = try values.decodeIfPresent(String.self, forKey: .banner_img)
        banner_tittle = try values.decodeIfPresent(String.self, forKey: .banner_tittle)
        banner_sub_tittle = try values.decodeIfPresent(String.self, forKey: .banner_sub_tittle)
        banner_des = try values.decodeIfPresent(String.self, forKey: .banner_des)
        banner_content = try values.decodeIfPresent([Banner_content].self, forKey: .banner_content)
        questions = try values.decodeIfPresent([Questions].self, forKey: .questions)
        contact = try values.decodeIfPresent([Contact].self, forKey: .contact)
        createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
        updatedAt = try values.decodeIfPresent(String.self, forKey: .updatedAt)
        publishedAt = try values.decodeIfPresent(String.self, forKey: .publishedAt)
    }

}


struct Banner_content : Codable {
  
    let des : String?
    let url : String?
    let title : String?
    let image_url : String?

    enum CodingKeys: String, CodingKey {

        case des = "des"
       // case id = "id"
        case url = "url"
        case title = "title"
        case image_url = "image_url"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
//        id = try values.decodeIfPresent(ObjectIdentifier.self, forKey: .id)
        des = try values.decodeIfPresent(String.self, forKey: .des)
        url = try values.decodeIfPresent(String.self, forKey: .url)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        image_url = try values.decodeIfPresent(String.self, forKey: .image_url)
    }

}


struct Questions : Codable {
    let answer : String?
    let question : String?

    enum CodingKeys: String, CodingKey {

        case answer = "answer"
        case question = "question"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        answer = try values.decodeIfPresent(String.self, forKey: .answer)
        question = try values.decodeIfPresent(String.self, forKey: .question)
    }

}


struct Contact : Codable {
    let title : String?
    let address : Address?
    let social_media : Social_media?
    let working_hours : Working_hours?
    let enquiry_card : Enquiry_card?

    enum CodingKeys: String, CodingKey {

        case title = "title"
        case address = "address"
        case enquiry_card = "enquiry_card"
        case social_media = "social_media"
        case working_hours = "working_hours"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        address = try values.decodeIfPresent(Address.self, forKey: .address)
        social_media = try values.decodeIfPresent(Social_media.self, forKey: .social_media)
        enquiry_card = try values.decodeIfPresent(Enquiry_card.self, forKey: .enquiry_card)
        working_hours = try values.decodeIfPresent(Working_hours.self, forKey: .working_hours)
    }

}


struct Address : Codable {
    let city : String?
    let po_box : String?
    let heading : String?
    let building : String?
    let location : String?

    enum CodingKeys: String, CodingKey {

        case city = "city"
        case po_box = "po_box"
        case heading = "heading"
        case building = "building"
        case location = "location"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        city = try values.decodeIfPresent(String.self, forKey: .city)
        po_box = try values.decodeIfPresent(String.self, forKey: .po_box)
        heading = try values.decodeIfPresent(String.self, forKey: .heading)
        building = try values.decodeIfPresent(String.self, forKey: .building)
        location = try values.decodeIfPresent(String.self, forKey: .location)
    }

}


struct Social_media : Codable {
    let heading : String?
    let platforms : [Platforms]?

    enum CodingKeys: String, CodingKey {

        case heading = "heading"
        case platforms = "platforms"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        heading = try values.decodeIfPresent(String.self, forKey: .heading)
        platforms = try values.decodeIfPresent([Platforms].self, forKey: .platforms)
    }

}

struct Platforms : Codable {
    let img : String?
    let link : String?

    enum CodingKeys: String, CodingKey {

        case img = "img"
        case link = "link"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        img = try values.decodeIfPresent(String.self, forKey: .img)
        link = try values.decodeIfPresent(String.self, forKey: .link)
    }

}



struct Working_hours : Codable {
    let friday : Friday?
    let heading : String?
    let monday_to_thursday : Monday_to_thursday?

    enum CodingKeys: String, CodingKey {

        case friday = "friday"
        case heading = "heading"
        case monday_to_thursday = "monday_to_thursday"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        friday = try values.decodeIfPresent(Friday.self, forKey: .friday)
        heading = try values.decodeIfPresent(String.self, forKey: .heading)
        monday_to_thursday = try values.decodeIfPresent(Monday_to_thursday.self, forKey: .monday_to_thursday)
    }

}


struct Monday_to_thursday : Codable {
    let days : String?
    let time : String?

    enum CodingKeys: String, CodingKey {

        case days = "days"
        case time = "time"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        days = try values.decodeIfPresent(String.self, forKey: .days)
        time = try values.decodeIfPresent(String.self, forKey: .time)
    }

}


struct Friday : Codable {
    let days : String?
    let time : String?

    enum CodingKeys: String, CodingKey {

        case days = "days"
        case time = "time"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        days = try values.decodeIfPresent(String.self, forKey: .days)
        time = try values.decodeIfPresent(String.self, forKey: .time)
    }

}


struct Enquiry_card : Codable {
    let title : Title?
    let button : CustomButton?
    let description : String?

    enum CodingKeys: String, CodingKey {

        case title = "title"
        case button = "button"
        case description = "description"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        title = try values.decodeIfPresent(Title.self, forKey: .title)
        button = try values.decodeIfPresent(CustomButton.self, forKey: .button)
        description = try values.decodeIfPresent(String.self, forKey: .description)
    }

}


//struct Title : Codable {
//    let text : String?
//    let highlight : [String]?
//
//    enum CodingKeys: String, CodingKey {
//
//        case text = "text"
//        case highlight = "highlight"
//    }
//
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        text = try values.decodeIfPresent(String.self, forKey: .text)
//        highlight = try values.decodeIfPresent([String].self, forKey: .highlight)
//    }
//
//}


struct CustomButton : Codable {
    let icon : String?
    let text : String?
    let action : String?

    enum CodingKeys: String, CodingKey {

        case icon = "icon"
        case text = "text"
        case action = "action"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        icon = try values.decodeIfPresent(String.self, forKey: .icon)
        text = try values.decodeIfPresent(String.self, forKey: .text)
        action = try values.decodeIfPresent(String.self, forKey: .action)
    }

}
