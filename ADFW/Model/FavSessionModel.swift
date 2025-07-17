//
//  FavSessionModel.swift
//  ADFW
//
//  Created by MultiTV on 07/07/25.
//

import Foundation
struct FavSessionModel : Codable {
    let status : Bool?
    let message : String?
    let data : FavSessionData?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case message = "message"
        case data = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        data = try values.decodeIfPresent(FavSessionData.self, forKey: .data)
    }

}

struct FavSessionData : Codable {
    let id : Int?
    let title : String?
    let description : String?
    let fromTime : String?
    let toTime : String?
    let day : String?
    let date : String?
    let color : String?
    let image : String?
    let video : String?
    let published : Bool?
    let publishVideo : Bool?
    let isBreak : Bool?
    let agenda : FavAgenda?
    let sessionType : SessionType?
    let moderator : EventAgandaSpeakers?
    let location : String?
    let speakers : [EventAgandaSpeakers]?
    let isFavourite : Bool?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case title = "title"
        case description = "description"
        case fromTime = "fromTime"
        case toTime = "toTime"
        case day = "day"
        case date = "date"
        case color = "color"
        case image = "image"
        case video = "video"
        case published = "published"
        case publishVideo = "publishVideo"
        case isBreak = "isBreak"
        case agenda = "agenda"
        case sessionType = "sessionType"
        case moderator = "moderator"
        case location = "location"
        case speakers = "speakers"
        case isFavourite = "isFavourite"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        fromTime = try values.decodeIfPresent(String.self, forKey: .fromTime)
        toTime = try values.decodeIfPresent(String.self, forKey: .toTime)
        day = try values.decodeIfPresent(String.self, forKey: .day)
        date = try values.decodeIfPresent(String.self, forKey: .date)
        color = try values.decodeIfPresent(String.self, forKey: .color)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        video = try values.decodeIfPresent(String.self, forKey: .video)
        published = try values.decodeIfPresent(Bool.self, forKey: .published)
        publishVideo = try values.decodeIfPresent(Bool.self, forKey: .publishVideo)
        isBreak = try values.decodeIfPresent(Bool.self, forKey: .isBreak)
agenda = try values.decodeIfPresent(FavAgenda.self, forKey: .agenda)
        sessionType = try values.decodeIfPresent(SessionType.self, forKey: .sessionType)
        moderator = try values.decodeIfPresent(EventAgandaSpeakers.self, forKey: .moderator)
        location = try values.decodeIfPresent(String.self, forKey: .location)
        speakers = try values.decodeIfPresent([EventAgandaSpeakers].self, forKey: .speakers)
        isFavourite = try values.decodeIfPresent(Bool.self, forKey: .isFavourite)
    }

}


struct FavAgenda : Codable {
    let id : Int?
    let title : String?
    let date : String?
    let logo : String?
    let mobileBanner : String?
    let agendaMobileBanner : String?
    let color : String?
    let location : FavLocation?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case title = "title"
        case date = "date"
        case logo = "logo"
        case mobileBanner = "mobileBanner"
        case agendaMobileBanner = "agendaMobileBanner"
        case color = "color"
        case location = "location"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        date = try values.decodeIfPresent(String.self, forKey: .date)
        logo = try values.decodeIfPresent(String.self, forKey: .logo)
        mobileBanner = try values.decodeIfPresent(String.self, forKey: .mobileBanner)
        agendaMobileBanner = try values.decodeIfPresent(String.self, forKey: .agendaMobileBanner)
        color = try values.decodeIfPresent(String.self, forKey: .color)
        location = try values.decodeIfPresent(FavLocation.self, forKey: .location)
    }

}


struct FavLocation : Codable {
    let name : String?

    enum CodingKeys: String, CodingKey {

        case name = "name"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decodeIfPresent(String.self, forKey: .name)
    }

}
