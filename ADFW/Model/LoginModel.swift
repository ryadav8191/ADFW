//
//  LoginModel.swift
//  ADFW
//
//  Created by MultiTV on 17/06/25.
//

import Foundation


import Foundation

struct LoginModel : Codable {
    let status : Bool?
    let message : String?
    let data : LoginData?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case message = "message"
        case data = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        data = try values.decodeIfPresent(LoginData.self, forKey: .data)
    }

}


struct LoginData : Codable {
    let user : User?
    let token : String?

    enum CodingKeys: String, CodingKey {

        case user = "user"
        case token = "token"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        user = try values.decodeIfPresent(User.self, forKey: .user)
        token = try values.decodeIfPresent(String.self, forKey: .token)
    }

}



struct User : Codable {
    let id : Int?
    let type : String?
    let ticketNumber : String?
    let status : String?
    let firstName : String?
    let lastName : String?
    let email : String?
    let company : String?
    let sector : String?
    let designation : String?
    let nationality : String?
    let residanceCountry : String?
    let countryCode : String?
    let mobile : String?
    let photo : String?
    let createdAt : String?
    let updatedAt : String?
    let publishedAt : String?
    let is_deleted : Bool?
   // let day : UserDay?
    let orderNumber : String?
    let emirate : String?
//    let utm_source : String?
//    let utm_medium : String?
//    let utm_campaign : String?
//    let ticketHolder : String?
//    let utm_id : String?
//    let utm_content : String?
    let token : String?
//    let notes : String?
//    let tag : String?
    let badgeCategory : String?
//    let paymentStatus : String?
//    let allowEmail : Bool?
//    let subSector : String?
//    let dayShort : String?
    let isTermsAgreed : Bool?
//    let allowChat : Bool?
//    let fcmToken : [String]?
//    let inviteeName : String?
//    let isUBSSponsor : String?
//    let openingCeremony : String?
//    let openingNight : String?
//    let isConfirmed : String?
//    let isSyncEvento : String?
//    let ticket_id : Ticket_id?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case type = "type"
        case ticketNumber = "ticketNumber"
        case status = "status"
        case firstName = "firstName"
        case lastName = "lastName"
        case email = "email"
        case company = "company"
        case sector = "sector"
        case designation = "designation"
        case nationality = "nationality"
        case residanceCountry = "residanceCountry"
        case countryCode = "countryCode"
        case mobile = "mobile"
        case photo = "photo"
        case createdAt = "createdAt"
        case updatedAt = "updatedAt"
        case publishedAt = "publishedAt"
        case is_deleted = "is_deleted"
//        case day = "day"
        case orderNumber = "orderNumber"
        case emirate = "emirate"
//        case utm_source = "utm_source"
//        case utm_medium = "utm_medium"
//        case utm_campaign = "utm_campaign"
//        case ticketHolder = "ticketHolder"
//        case utm_id = "utm_id"
//        case utm_content = "utm_content"
        case token = "token"
//        case notes = "notes"
//        case tag = "tag"
        case badgeCategory = "badgeCategory"
//        case paymentStatus = "paymentStatus"
//        case allowEmail = "allowEmail"
//        case subSector = "subSector"
//        case dayShort = "dayShort"
        case isTermsAgreed = "isTermsAgreed"
//        case allowChat = "allowChat"
//        case fcmToken = "fcmToken"
//        case inviteeName = "inviteeName"
//        case isUBSSponsor = "isUBSSponsor"
//        case openingCeremony = "openingCeremony"
//        case openingNight = "openingNight"
//        case isConfirmed = "isConfirmed"
//        case isSyncEvento = "isSyncEvento"
//        case ticket_id = "ticket_id"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        type = try values.decodeIfPresent(String.self, forKey: .type)
        ticketNumber = try values.decodeIfPresent(String.self, forKey: .ticketNumber)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        firstName = try values.decodeIfPresent(String.self, forKey: .firstName)
        lastName = try values.decodeIfPresent(String.self, forKey: .lastName)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        company = try values.decodeIfPresent(String.self, forKey: .company)
        sector = try values.decodeIfPresent(String.self, forKey: .sector)
        designation = try values.decodeIfPresent(String.self, forKey: .designation)
        nationality = try values.decodeIfPresent(String.self, forKey: .nationality)
        residanceCountry = try values.decodeIfPresent(String.self, forKey: .residanceCountry)
        countryCode = try values.decodeIfPresent(String.self, forKey: .countryCode)
        mobile = try values.decodeIfPresent(String.self, forKey: .mobile)
        photo = try values.decodeIfPresent(String.self, forKey: .photo)
        createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
        updatedAt = try values.decodeIfPresent(String.self, forKey: .updatedAt)
        publishedAt = try values.decodeIfPresent(String.self, forKey: .publishedAt)
        is_deleted = try values.decodeIfPresent(Bool.self, forKey: .is_deleted)
      //  day = try values.decodeIfPresent(UserDay.self, forKey: .day)
        orderNumber = try values.decodeIfPresent(String.self, forKey: .orderNumber)
        emirate = try values.decodeIfPresent(String.self, forKey: .emirate)
//        utm_source = try values.decodeIfPresent(String.self, forKey: .utm_source)
//        utm_medium = try values.decodeIfPresent(String.self, forKey: .utm_medium)
//        utm_campaign = try values.decodeIfPresent(String.self, forKey: .utm_campaign)
//        ticketHolder = try values.decodeIfPresent(String.self, forKey: .ticketHolder)
//        utm_id = try values.decodeIfPresent(String.self, forKey: .utm_id)
//        utm_content = try values.decodeIfPresent(String.self, forKey: .utm_content)
        token = try values.decodeIfPresent(String.self, forKey: .token)
//        notes = try values.decodeIfPresent(String.self, forKey: .notes)
//        tag = try values.decodeIfPresent(String.self, forKey: .tag)
        badgeCategory = try values.decodeIfPresent(String.self, forKey: .badgeCategory)
//        paymentStatus = try values.decodeIfPresent(String.self, forKey: .paymentStatus)
//        allowEmail = try values.decodeIfPresent(Bool.self, forKey: .allowEmail)
//        subSector = try values.decodeIfPresent(String.self, forKey: .subSector)
//        dayShort = try values.decodeIfPresent(String.self, forKey: .dayShort)
        isTermsAgreed = try values.decodeIfPresent(Bool.self, forKey: .isTermsAgreed)
//        allowChat = try values.decodeIfPresent(Bool.self, forKey: .allowChat)
//        fcmToken = try values.decodeIfPresent([String].self, forKey: .fcmToken)
//        inviteeName = try values.decodeIfPresent(String.self, forKey: .inviteeName)
//        isUBSSponsor = try values.decodeIfPresent(String.self, forKey: .isUBSSponsor)
//        openingCeremony = try values.decodeIfPresent(String.self, forKey: .openingCeremony)
//        openingNight = try values.decodeIfPresent(String.self, forKey: .openingNight)
//        isConfirmed = try values.decodeIfPresent(String.self, forKey: .isConfirmed)
//        isSyncEvento = try values.decodeIfPresent(String.self, forKey: .isSyncEvento)
//        ticket_id = try values.decodeIfPresent(Ticket_id.self, forKey: .ticket_id)
    }

}

struct Ticket_id : Codable {
    let id : Int?
    let title : String?
    let price : Int?
    let reccomented : Bool?
    let details : Details?
    let status : Bool?
    let createdAt : String?
    let updatedAt : String?
    let publishedAt : String?
    let is_deleted : Bool?
    let sold_out : Bool?
    let id_short : String?
    let days : String?
    let description : String?
    let isPublic : Bool?
    let isSponsor : Bool?
    let google_tag : Google_tag?
    let priority : Int?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case title = "title"
        case price = "price"
        case reccomented = "reccomented"
        case details = "details"
        case status = "status"
        case createdAt = "createdAt"
        case updatedAt = "updatedAt"
        case publishedAt = "publishedAt"
        case is_deleted = "is_deleted"
        case sold_out = "sold_out"
        case id_short = "id_short"
        case days = "days"
        case description = "description"
        case isPublic = "isPublic"
        case isSponsor = "isSponsor"
        case google_tag = "google_tag"
        case priority = "priority"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        price = try values.decodeIfPresent(Int.self, forKey: .price)
        reccomented = try values.decodeIfPresent(Bool.self, forKey: .reccomented)
        details = try values.decodeIfPresent(Details.self, forKey: .details)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
        updatedAt = try values.decodeIfPresent(String.self, forKey: .updatedAt)
        publishedAt = try values.decodeIfPresent(String.self, forKey: .publishedAt)
        is_deleted = try values.decodeIfPresent(Bool.self, forKey: .is_deleted)
        sold_out = try values.decodeIfPresent(Bool.self, forKey: .sold_out)
        id_short = try values.decodeIfPresent(String.self, forKey: .id_short)
        days = try values.decodeIfPresent(String.self, forKey: .days)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        isPublic = try values.decodeIfPresent(Bool.self, forKey: .isPublic)
        isSponsor = try values.decodeIfPresent(Bool.self, forKey: .isSponsor)
        google_tag = try values.decodeIfPresent(Google_tag.self, forKey: .google_tag)
        priority = try values.decodeIfPresent(Int.self, forKey: .priority)
    }

}


struct Details : Codable {
    let events : [UserEvents]?

    enum CodingKeys: String, CodingKey {

        case events = "events"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        events = try values.decodeIfPresent([UserEvents].self, forKey: .events)
    }

}


struct UserEvents : Codable {
    let id : Int?
    let name : String?
    let subEvents : [SubEvents]?
    let isAvailable : Bool?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case name = "name"
        case subEvents = "subEvents"
        case isAvailable = "isAvailable"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        subEvents = try values.decodeIfPresent([SubEvents].self, forKey: .subEvents)
        isAvailable = try values.decodeIfPresent(Bool.self, forKey: .isAvailable)
    }

}


struct SubEvents : Codable {
    let id : Int?
    let name : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case name = "name"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
    }

}


struct Google_tag : Codable {
    let google_item_id : String?
    let google_item_name : String?
    let google_item_category2 : String?

    enum CodingKeys: String, CodingKey {

        case google_item_id = "google_item_id"
        case google_item_name = "google_item_name"
        case google_item_category2 = "google_item_category2"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        google_item_id = try values.decodeIfPresent(String.self, forKey: .google_item_id)
        google_item_name = try values.decodeIfPresent(String.self, forKey: .google_item_name)
        google_item_category2 = try values.decodeIfPresent(String.self, forKey: .google_item_category2)
    }

}


struct UserDay : Codable {
    let id : String?
    let event : String?
    let value : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case event = "event"
        case value = "value"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        event = try values.decodeIfPresent(String.self, forKey: .event)
        value = try values.decodeIfPresent(String.self, forKey: .value)
    }

}
