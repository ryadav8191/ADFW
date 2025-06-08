//
//  SpeakerResponseModel.swift
//  ADFW
//
//  Created by MultiTV on 05/06/25.
//


import Foundation

// MARK: - SpeakerResponseModel
struct SpeakerResponseModel: Codable {
    let status: Bool?
    let message: String?
    let data: SpeakerData?
}

// MARK: - DataClass
struct SpeakerData: Codable {
    let data: [Speakers]?
    let pagination: Pagination?
}

// MARK: - Datum
struct Speakers: Codable {
    let id: Int?
    let designation: String?
    let photoURL: String?
    let firstName, lastName, email, companyName: String?
    let bio, nationality: String?
    let residentCountry: String?
    let graduationYear, uniName: String?
    let passportURL: String?
    let phone, qualification: String?
    let emiratesIDBack: String?
    let published, isDeleted: Bool?
    let createdAt, updatedAt, publishedAt: String?
    let social: Bool?
    let socialDescription: String?
    let emiratesIDFront: String?
    let countryCode: String?
    let emirate: String?
    let priority, adsff, remainingAdsff, resolve: Int?
    let remainingResolve, executive, remainingExecutive, delegate: Int?
    let remainingDelegate, generalAdmission, remainingGeneralAdmission, assetAbuDhabi: Int?
    let remainingAssetAbuDhabi, fintechAbuDhabi, remainingFintechAbuDhabi, singleDay: Int?
    let remainingSingleDay: Int?
    let password: String?
    let remainingPadockClub, padockClub: Int?
    let mobileAppPhotoURL: String?

    enum CodingKeys: String, CodingKey {
        case id, designation
        case photoURL = "photoUrl"
        case firstName, lastName, email, companyName, bio, nationality, residentCountry, graduationYear, uniName
        case passportURL = "passportUrl"
        case phone, qualification
        case emiratesIDBack = "emiratesIdBack"
        case published
        case isDeleted = "is_deleted"
        case createdAt, updatedAt, publishedAt, social, socialDescription
        case emiratesIDFront = "emiratesIdFront"
        case countryCode, emirate, priority, adsff
        case remainingAdsff = "remaining_adsff"
        case resolve
        case remainingResolve = "remaining_resolve"
        case executive
        case remainingExecutive = "remaining_executive"
        case delegate
        case remainingDelegate = "remaining_delegate"
        case generalAdmission = "general_admission"
        case remainingGeneralAdmission = "remaining_general_admission"
        case assetAbuDhabi = "asset_abu_dhabi"
        case remainingAssetAbuDhabi = "remaining_asset_abu_dhabi"
        case fintechAbuDhabi = "fintech_abu_dhabi"
        case remainingFintechAbuDhabi = "remaining_fintech_abu_dhabi"
        case singleDay = "single_day"
        case remainingSingleDay = "remaining_single_day"
        case password
        case remainingPadockClub = "remaining_padock_club"
        case padockClub = "padock_club"
        case mobileAppPhotoURL = "mobile_app_photo_url"
    }
}



// MARK: - Pagination
struct Pagination: Codable {
    let page, pageSize, pageCount, total: Int?
}
