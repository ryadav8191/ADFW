//
//  GlobalSearchModel.swift
//  ADFW
//
//  Created by MultiTV on 10/07/25.
//

import Foundation


struct GlobalSearchModel : Codable {
    let status : Bool?
    let message : String?
    let data : GlobalSearchData?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case message = "message"
        case data = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        data = try values.decodeIfPresent(GlobalSearchData.self, forKey: .data)
    }

}


struct GlobalSearchData : Codable {
    let agendas : GlobalSearchAgendas?
    let sessions : GlobalSearchSessions?
    let speakers : GlobalSearchSpeakers?

    enum CodingKeys: String, CodingKey {

        case agendas = "agendas"
        case sessions = "sessions"
        case speakers = "speakers"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        agendas = try values.decodeIfPresent(GlobalSearchAgendas.self, forKey: .agendas)
        sessions = try values.decodeIfPresent(GlobalSearchSessions.self, forKey: .sessions)
        speakers = try values.decodeIfPresent(GlobalSearchSpeakers.self, forKey: .speakers)
    }

}


struct GlobalSearchAgendas : Codable {
    let data : [Agendas]?
    let pagination : Pagination?

    enum CodingKeys: String, CodingKey {

        case data = "data"
        case pagination = "pagination"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent([Agendas].self, forKey: .data)
        pagination = try values.decodeIfPresent(Pagination.self, forKey: .pagination)
    }

}

struct GlobalSearchSessions : Codable {
    let data : [Agenda_sessions]?
    let pagination : Pagination?

    enum CodingKeys: String, CodingKey {

        case data = "data"
        case pagination = "pagination"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent([Agenda_sessions].self, forKey: .data)
        pagination = try values.decodeIfPresent(Pagination.self, forKey: .pagination)
    }

}


struct GlobalSearchSpeakers : Codable {
    let data : [Speakers]?
    let pagination : Pagination?

    enum CodingKeys: String, CodingKey {

        case data = "data"
        case pagination = "pagination"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent([Speakers].self, forKey: .data)
        pagination = try values.decodeIfPresent(Pagination.self, forKey: .pagination)
    }

}
