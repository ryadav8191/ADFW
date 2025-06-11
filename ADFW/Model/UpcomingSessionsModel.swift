//
//  UpcomingSessionsModel.swift
//  ADFW
//
//  Created by MultiTV on 10/06/25.
//

import Foundation


struct UpcomingSessionsModel : Codable {
    let data : [UpcomingSessionsData]?
    let meta : Meta?

    enum CodingKeys: String, CodingKey {

        case data = "data"
        case meta = "meta"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent([UpcomingSessionsData].self, forKey: .data)
        meta = try values.decodeIfPresent(Meta.self, forKey: .meta)
    }

}


struct UpcomingSessionsData : Codable {
    let id : Int?
    let attributes : UpcomingSessions?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case attributes = "attributes"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        attributes = try values.decodeIfPresent(UpcomingSessions.self, forKey: .attributes)
    }

}

struct UpcomingSessions : Codable {
    let title : String?
    let description : String?
//    let image : String?
//    let date : String?
    let time : String?
//    let published : Bool?
    let color : String?
//    let is_deleted : Bool?
//    let isFeatured : Bool?
//    let createdAt : String?
//    let updatedAt : String?
//    let publishedAt : String?
//    let banner : String?
//    let image2 : String?
//    let major_event : Bool?
//    let logo : String?
//    let priority : Double?
//    let viewDetails : Bool?
//    let image3 : String?
//    let sponsers : [Sponsers]?
//    let banner2 : String?
//    let viewAgenda : Bool?
//    let viewWebsite : Bool?
//    let websiteLink : String?
//    let image4 : String?
//    let subHeading : String?
//    let textColor : String?
//    let permaLink : String?
//    let metaTitle : String?
//    let metaDescription : String?
//    let showFilter : Bool?
//    let isPrivateEvent : Bool?
//    let bannerLogo : String?
//    let mobileBanner : String?
//    let agendaMobileBanner : String?
//    let publishVideo : String?
//    let mobile_app_image : String?
//    let mobile_app_mobile_banner : String?
//    let mobile_app_agenda_mobile_banner : String?
//    let privateSendEmail : String?
//    let privateTitle : String?
//    let privateSubTitle : String?
//    let privateShowSector : String?
//    let privateShowAgenda : String?
//    let showIframe : String?
//    let iframe : String?
   // let agendaType : AgendaType?
    let location : SessionAgandaLocation?
  //  let agenda_sessions : Agenda_sessions?
   
  

    enum CodingKeys: String, CodingKey {

        case title = "title"
        case description = "description"
//        case image = "image"
//        case date = "date"
        case time = "time"
//        case published = "published"
        case color = "color"
//        case is_deleted = "is_deleted"
//        case isFeatured = "isFeatured"
//        case createdAt = "createdAt"
//        case updatedAt = "updatedAt"
//        case publishedAt = "publishedAt"
//        case banner = "banner"
//        case image2 = "image2"
//        case major_event = "major_event"
//        case logo = "logo"
//        case priority = "priority"
//        case viewDetails = "viewDetails"
//        case image3 = "image3"
//        case sponsers = "sponsers"
//        case banner2 = "banner2"
//        case viewAgenda = "viewAgenda"
//        case viewWebsite = "viewWebsite"
//        case websiteLink = "websiteLink"
//        case image4 = "image4"
//        case subHeading = "subHeading"
//        case textColor = "textColor"
//        case permaLink = "permaLink"
//        case metaTitle = "metaTitle"
//        case metaDescription = "metaDescription"
//        case showFilter = "showFilter"
//        case isPrivateEvent = "isPrivateEvent"
//        case bannerLogo = "bannerLogo"
//        case mobileBanner = "mobileBanner"
//        case agendaMobileBanner = "agendaMobileBanner"
//        case publishVideo = "publishVideo"
//        case mobile_app_image = "mobile_app_image"
//        case mobile_app_mobile_banner = "mobile_app_mobile_banner"
//        case mobile_app_agenda_mobile_banner = "mobile_app_agenda_mobile_banner"
//        case privateSendEmail = "privateSendEmail"
//        case privateTitle = "privateTitle"
//        case privateSubTitle = "privateSubTitle"
//        case privateShowSector = "privateShowSector"
//        case privateShowAgenda = "privateShowAgenda"
//        case showIframe = "showIframe"
//        case iframe = "iframe"
//        case agendaType = "agendaType"
        case location = "location"
//        case agenda_sessions = "agenda_sessions"
       
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        description = try values.decodeIfPresent(String.self, forKey: .description)
//        image = try values.decodeIfPresent(String.self, forKey: .image)
//        date = try values.decodeIfPresent(String.self, forKey: .date)
        time = try values.decodeIfPresent(String.self, forKey: .time)
//        published = try values.decodeIfPresent(Bool.self, forKey: .published)
        color = try values.decodeIfPresent(String.self, forKey: .color)
//        is_deleted = try values.decodeIfPresent(Bool.self, forKey: .is_deleted)
//        isFeatured = try values.decodeIfPresent(Bool.self, forKey: .isFeatured)
//        createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
//        updatedAt = try values.decodeIfPresent(String.self, forKey: .updatedAt)
//        publishedAt = try values.decodeIfPresent(String.self, forKey: .publishedAt)
//        banner = try values.decodeIfPresent(String.self, forKey: .banner)
//        image2 = try values.decodeIfPresent(String.self, forKey: .image2)
//        major_event = try values.decodeIfPresent(Bool.self, forKey: .major_event)
//        logo = try values.decodeIfPresent(String.self, forKey: .logo)
//        priority = try values.decodeIfPresent(Double.self, forKey: .priority)
//        viewDetails = try values.decodeIfPresent(Bool.self, forKey: .viewDetails)
//        image3 = try values.decodeIfPresent(String.self, forKey: .image3)
//        sponsers = try values.decodeIfPresent([Sponsers].self, forKey: .sponsers)
//        banner2 = try values.decodeIfPresent(String.self, forKey: .banner2)
//        viewAgenda = try values.decodeIfPresent(Bool.self, forKey: .viewAgenda)
//        viewWebsite = try values.decodeIfPresent(Bool.self, forKey: .viewWebsite)
//        websiteLink = try values.decodeIfPresent(String.self, forKey: .websiteLink)
//        image4 = try values.decodeIfPresent(String.self, forKey: .image4)
//        subHeading = try values.decodeIfPresent(String.self, forKey: .subHeading)
//        textColor = try values.decodeIfPresent(String.self, forKey: .textColor)
//        permaLink = try values.decodeIfPresent(String.self, forKey: .permaLink)
//        metaTitle = try values.decodeIfPresent(String.self, forKey: .metaTitle)
//        metaDescription = try values.decodeIfPresent(String.self, forKey: .metaDescription)
//        showFilter = try values.decodeIfPresent(Bool.self, forKey: .showFilter)
//        isPrivateEvent = try values.decodeIfPresent(Bool.self, forKey: .isPrivateEvent)
//        bannerLogo = try values.decodeIfPresent(String.self, forKey: .bannerLogo)
//        mobileBanner = try values.decodeIfPresent(String.self, forKey: .mobileBanner)
//        agendaMobileBanner = try values.decodeIfPresent(String.self, forKey: .agendaMobileBanner)
//        publishVideo = try values.decodeIfPresent(String.self, forKey: .publishVideo)
//        mobile_app_image = try values.decodeIfPresent(String.self, forKey: .mobile_app_image)
//        mobile_app_mobile_banner = try values.decodeIfPresent(String.self, forKey: .mobile_app_mobile_banner)
//        mobile_app_agenda_mobile_banner = try values.decodeIfPresent(String.self, forKey: .mobile_app_agenda_mobile_banner)
//        privateSendEmail = try values.decodeIfPresent(String.self, forKey: .privateSendEmail)
//        privateTitle = try values.decodeIfPresent(String.self, forKey: .privateTitle)
//        privateSubTitle = try values.decodeIfPresent(String.self, forKey: .privateSubTitle)
//        privateShowSector = try values.decodeIfPresent(String.self, forKey: .privateShowSector)
//        privateShowAgenda = try values.decodeIfPresent(String.self, forKey: .privateShowAgenda)
//        showIframe = try values.decodeIfPresent(String.self, forKey: .showIframe)
//        iframe = try values.decodeIfPresent(String.self, forKey: .iframe)
//        agendaType = try values.decodeIfPresent(AgendaType.self, forKey: .agendaType)
        location = try values.decodeIfPresent(SessionAgandaLocation.self, forKey: .location)
//        agenda_sessions = try values.decodeIfPresent(Agenda_sessions.self, forKey: .agenda_sessions)
       
    }

}


struct SessionAgandaLocation: Codable {
    let data : AgandaLocationData?

    enum CodingKeys: String, CodingKey {
        case data = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent(AgandaLocationData.self, forKey: .data)
    }
    
}


struct AgandaLocationData : Codable {
    let id : Int?
    let attributes : AgandaLocation?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case attributes = "attributes"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        attributes = try values.decodeIfPresent(AgandaLocation.self, forKey: .attributes)
    }

}
