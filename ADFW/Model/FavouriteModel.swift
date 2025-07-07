//
//  FavouriteModel.swift
//  ADFW
//
//  Created by MultiTV on 02/07/25.
//

import Foundation


struct FavouriteModel : Codable {
    let data : [FavouriteData]?
    let status : Bool?
    let message : String?
    let meta : Meta?

    enum CodingKeys: String, CodingKey {

        case data = "data"
        case status = "status"
        case message = "message"
        case meta = "meta"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent([FavouriteData].self, forKey: .data)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        meta = try values.decodeIfPresent(Meta.self, forKey: .meta)
    }

}


struct FavouriteData : Codable {
    let date : String?
    let agendas : [FavouriteAgendas]?

    enum CodingKeys: String, CodingKey {

        case date = "date"
        case agendas = "agendas"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        date = try values.decodeIfPresent(String.self, forKey: .date)
        agendas = try values.decodeIfPresent([FavouriteAgendas].self, forKey: .agendas)
    }

}


struct FavouriteAgendas : Codable {
    let agenda_id : Int?
    let agenda_title : String?
    let agenda_banner : String?
    let agenda_logo : String?
    let agenda_mobile_banner : String?
    let agenda_agenda_mobile_banner : String?
    let location : String?
    let sessions : [FavouriteSessions]?

    enum CodingKeys: String, CodingKey {

        case agenda_id = "agenda_id"
        case agenda_title = "agenda_title"
        case agenda_banner = "agenda_banner"
        case agenda_logo = "agenda_logo"
        case agenda_mobile_banner = "agenda_mobile_banner"
        case agenda_agenda_mobile_banner = "agenda_agenda_mobile_banner"
        case location = "location"
        case sessions = "sessions"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        agenda_id = try values.decodeIfPresent(Int.self, forKey: .agenda_id)
        agenda_title = try values.decodeIfPresent(String.self, forKey: .agenda_title)
        agenda_banner = try values.decodeIfPresent(String.self, forKey: .agenda_banner)
        agenda_logo = try values.decodeIfPresent(String.self, forKey: .agenda_logo)
        agenda_mobile_banner = try values.decodeIfPresent(String.self, forKey: .agenda_mobile_banner)
        agenda_agenda_mobile_banner = try values.decodeIfPresent(String.self, forKey: .agenda_agenda_mobile_banner)
        location = try values.decodeIfPresent(String.self, forKey: .location)
        sessions = try values.decodeIfPresent([FavouriteSessions].self, forKey: .sessions)
    }

}


struct FavouriteSessions : Codable {
    let session_id : Int?
    let session_title : String?
    let session_from_time : String?
    let session_to_time : String?
    let session_video : String?
    let session_type : Session_type?
    let speakers : [FavouriteSpeakers]?
    let moderators : [FavouriteSpeakers]?

    enum CodingKeys: String, CodingKey {

        case session_id = "session_id"
        case session_title = "session_title"
        case session_from_time = "session_from_time"
        case session_to_time = "session_to_time"
        case session_video = "session_video"
        case session_type = "session_type"
        case speakers = "speakers"
        case moderators = "moderators"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        session_id = try values.decodeIfPresent(Int.self, forKey: .session_id)
        session_title = try values.decodeIfPresent(String.self, forKey: .session_title)
        session_from_time = try values.decodeIfPresent(String.self, forKey: .session_from_time)
        session_to_time = try values.decodeIfPresent(String.self, forKey: .session_to_time)
        session_video = try values.decodeIfPresent(String.self, forKey: .session_video)
        session_type = try values.decodeIfPresent(Session_type.self, forKey: .session_type)
        speakers = try values.decodeIfPresent([FavouriteSpeakers].self, forKey: .speakers)
        moderators = try values.decodeIfPresent([FavouriteSpeakers].self, forKey: .moderators)
    }

}


struct Session_type : Codable {
    let id : Int?
    let icon : String?
    let name : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case icon = "icon"
        case name = "name"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        icon = try values.decodeIfPresent(String.self, forKey: .icon)
        name = try values.decodeIfPresent(String.self, forKey: .name)
    }

}


struct FavouriteSpeakers : Codable {
    let id : Int?
    let last_name : String?
    let photo_url : String?
    let first_name : String?
    let  designation, companyName: String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case last_name = "last_name"
        case photo_url = "photo_url"
        case first_name = "first_name"
        case designation
                case companyName = "company_name"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        last_name = try values.decodeIfPresent(String.self, forKey: .last_name)
        photo_url = try values.decodeIfPresent(String.self, forKey: .photo_url)
        first_name = try values.decodeIfPresent(String.self, forKey: .first_name)
        designation = try values.decodeIfPresent(String.self, forKey: .designation)
        companyName = try values.decodeIfPresent(String.self, forKey: .companyName)
    }

}
