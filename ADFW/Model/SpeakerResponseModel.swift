//
//  SpeakerResponseModel.swift
//  ADFW
//
//  Created by MultiTV on 05/06/25.
//


import Foundation

// MARK: - SpeakerResponseModel
//struct SpeakerResponseModel: Codable {
//    let status: Bool?
//    let message: String?
//    let data: SpeakerData?
//}
//
//// MARK: - DataClass
//struct SpeakerData: Codable {
//    let data: [Speakers]?
//    let pagination: Pagination?
//}
//
//// MARK: - Datum
//struct Speakers: Codable {
//    let id: Int?
//    let designation: String?
//    let photoURL: String?
//    let firstName, lastName, email, companyName: String?
//    let bio, nationality: String?
//    let residentCountry: String?
//    let graduationYear, uniName: String?
//    let passportURL: String?
//    let phone, qualification: String?
//    let emiratesIDBack: String?
//    let published, isDeleted: Bool?
//    let createdAt, updatedAt, publishedAt: String?
//    let social: Bool?
//    let socialDescription: String?
//    let emiratesIDFront: String?
//    let countryCode: String?
//    let emirate: String?
//    let priority, adsff, remainingAdsff, resolve: Int?
//    let remainingResolve, executive, remainingExecutive, delegate: Int?
//    let remainingDelegate, generalAdmission, remainingGeneralAdmission, assetAbuDhabi: Int?
//    let remainingAssetAbuDhabi, fintechAbuDhabi, remainingFintechAbuDhabi, singleDay: Int?
//    let remainingSingleDay: Int?
//    let password: String?
//    let remainingPadockClub, padockClub: Int?
//    let mobileAppPhotoURL: String?
//
//    enum CodingKeys: String, CodingKey {
//        case id, designation
//        case photoURL = "photoUrl"
//        case firstName, lastName, email, companyName, bio, nationality, residentCountry, graduationYear, uniName
//        case passportURL = "passportUrl"
//        case phone, qualification
//        case emiratesIDBack = "emiratesIdBack"
//        case published
//        case isDeleted = "is_deleted"
//        case createdAt, updatedAt, publishedAt, social, socialDescription
//        case emiratesIDFront = "emiratesIdFront"
//        case countryCode, emirate, priority, adsff
//        case remainingAdsff = "remaining_adsff"
//        case resolve
//        case remainingResolve = "remaining_resolve"
//        case executive
//        case remainingExecutive = "remaining_executive"
//        case delegate
//        case remainingDelegate = "remaining_delegate"
//        case generalAdmission = "general_admission"
//        case remainingGeneralAdmission = "remaining_general_admission"
//        case assetAbuDhabi = "asset_abu_dhabi"
//        case remainingAssetAbuDhabi = "remaining_asset_abu_dhabi"
//        case fintechAbuDhabi = "fintech_abu_dhabi"
//        case remainingFintechAbuDhabi = "remaining_fintech_abu_dhabi"
//        case singleDay = "single_day"
//        case remainingSingleDay = "remaining_single_day"
//        case password
//        case remainingPadockClub = "remaining_padock_club"
//        case padockClub = "padock_club"
//        case mobileAppPhotoURL = "mobile_app_photo_url"
//    }
//}
//
//
//
// MARK: - Pagination
struct Pagination: Codable {
    let page, pageSize, pageCount, total: Int?
}

struct SpeakerResponseModel : Codable {
    let data : [SpeakerData]?
    let meta : Meta?

    enum CodingKeys: String, CodingKey {

        case data = "data"
        case meta = "meta"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent([SpeakerData].self, forKey: .data)
        meta = try values.decodeIfPresent(Meta.self, forKey: .meta)
    }

}


struct Meta : Codable {
    let pagination : Pagination?

    enum CodingKeys: String, CodingKey {

        case pagination = "pagination"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        pagination = try values.decodeIfPresent(Pagination.self, forKey: .pagination)
    }

}


struct SpeakerData : Codable {
    let id : Int?
    let attributes : Speakers?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case attributes = "attributes"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        attributes = try values.decodeIfPresent(Speakers.self, forKey: .attributes)
    }

}


struct Speakers : Codable {
    let firstName : String?
    let lastName : String?
    let companyName : String?
    let designation : String?
    let photoUrl : String?
    let bio : String?
    let agenda_sessions : SpeakerAgendaSessions?

    enum CodingKeys: String, CodingKey {

        case firstName = "firstName"
        case lastName = "lastName"
        case companyName = "companyName"
        case designation = "designation"
        case photoUrl = "photoUrl"
        case bio = "bio"
        case agenda_sessions = "agenda_sessions"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        firstName = try values.decodeIfPresent(String.self, forKey: .firstName)
        lastName = try values.decodeIfPresent(String.self, forKey: .lastName)
        companyName = try values.decodeIfPresent(String.self, forKey: .companyName)
        designation = try values.decodeIfPresent(String.self, forKey: .designation)
        photoUrl = try values.decodeIfPresent(String.self, forKey: .photoUrl)
        bio = try values.decodeIfPresent(String.self, forKey: .bio)
        agenda_sessions = try values.decodeIfPresent(SpeakerAgendaSessions.self, forKey: .agenda_sessions)
    }

}






struct SpeakerAgendaSessions : Codable {
    let data : [SpeakerAgendaData]?

    enum CodingKeys: String, CodingKey {

        case data = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent([SpeakerAgendaData].self, forKey: .data)
    }

}



struct SpeakerAgendaData : Codable {
    let id : Int?
    let attributes : SpeakerAgandaAttributes?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case attributes = "attributes"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        attributes = try values.decodeIfPresent(SpeakerAgandaAttributes.self, forKey: .attributes)
    }

}

struct SpeakerAgandaAttributes : Codable {
    let day : String?
    let date : String?
    let image : String?
    let title : String?
    let description : String?
    let isBreak : Bool?
    let published : Bool?
    let fromTime : String?
    let toTime : String?
    let color : String?
    let createdAt : String?
    let updatedAt : String?
    let publishedAt : String?
    let is_deleted : Bool?
    let video : String?
    let publishVideo : Bool?
    let agenda : Aganda?

    enum CodingKeys: String, CodingKey {

        case day = "day"
        case date = "date"
        case image = "image"
        case title = "title"
        case description = "description"
        case isBreak = "isBreak"
        case published = "published"
        case fromTime = "fromTime"
        case toTime = "toTime"
        case color = "color"
        case createdAt = "createdAt"
        case updatedAt = "updatedAt"
        case publishedAt = "publishedAt"
        case is_deleted = "is_deleted"
        case video = "video"
        case publishVideo = "publishVideo"
        case agenda = "agenda"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        day = try values.decodeIfPresent(String.self, forKey: .day)
        date = try values.decodeIfPresent(String.self, forKey: .date)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        isBreak = try values.decodeIfPresent(Bool.self, forKey: .isBreak)
        published = try values.decodeIfPresent(Bool.self, forKey: .published)
        fromTime = try values.decodeIfPresent(String.self, forKey: .fromTime)
        toTime = try values.decodeIfPresent(String.self, forKey: .toTime)
        color = try values.decodeIfPresent(String.self, forKey: .color)
        createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
        updatedAt = try values.decodeIfPresent(String.self, forKey: .updatedAt)
        publishedAt = try values.decodeIfPresent(String.self, forKey: .publishedAt)
        is_deleted = try values.decodeIfPresent(Bool.self, forKey: .is_deleted)
        video = try values.decodeIfPresent(String.self, forKey: .video)
        publishVideo = try values.decodeIfPresent(Bool.self, forKey: .publishVideo)
        agenda = try values.decodeIfPresent(Aganda.self, forKey: .agenda)
    }

}
