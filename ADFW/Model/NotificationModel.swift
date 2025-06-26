//
//  NotificationModel.swift
//  ADFW
//  Created by MultiTV on 25/06/25.
//

import Foundation

struct NotificationModel : Codable {
    let status : Bool?
    let message : String?
    let data : NotificationResponse?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case message = "message"
        case data = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        data = try values.decodeIfPresent(NotificationResponse.self, forKey: .data)
    }

}


struct NotificationResponse : Codable {
    let data : [NotificationData]?
    let pagination : Pagination?

    enum CodingKeys: String, CodingKey {

        case data = "data"
        case pagination = "pagination"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent([NotificationData].self, forKey: .data)
        pagination = try values.decodeIfPresent(Pagination.self, forKey: .pagination)
    }

}


struct NotificationData : Codable {
    let id : Int?
    let title : String?
    let description : String?
    let logo : String?
    let date : String?
    //let is_deleted : Bool?
   // let createdAt : String?
   // let updatedAt : String?
   // let publishedAt : String?
  //  let isScheduled : Bool?
   // let isSent : Bool?
 //   let creator : Creator?
  //  let modifiedBy : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case title = "title"
        case description = "description"
        case logo = "logo"
        case date = "date"
//        case is_deleted = "is_deleted"
//        case createdAt = "createdAt"
//        case updatedAt = "updatedAt"
//        case publishedAt = "publishedAt"
//        case isScheduled = "isScheduled"
//        case isSent = "isSent"
//      //  case creator = "creator"
//        case modifiedBy = "modifiedBy"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        logo = try values.decodeIfPresent(String.self, forKey: .logo)
        date = try values.decodeIfPresent(String.self, forKey: .date)
//        is_deleted = try values.decodeIfPresent(Bool.self, forKey: .is_deleted)
//        createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
//        updatedAt = try values.decodeIfPresent(String.self, forKey: .updatedAt)
//        publishedAt = try values.decodeIfPresent(String.self, forKey: .publishedAt)
//        isScheduled = try values.decodeIfPresent(Bool.self, forKey: .isScheduled)
//        isSent = try values.decodeIfPresent(Bool.self, forKey: .isSent)
//        //creator = try values.decodeIfPresent(Creator.self, forKey: .creator)
//        modifiedBy = try values.decodeIfPresent(String.self, forKey: .modifiedBy)
    }

}


struct Creator : Codable {
    let firstName : String?
    let lastName : String?

    enum CodingKeys: String, CodingKey {

        case firstName = "firstName"
        case lastName = "lastName"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        firstName = try values.decodeIfPresent(String.self, forKey: .firstName)
        lastName = try values.decodeIfPresent(String.self, forKey: .lastName)
    }

}

