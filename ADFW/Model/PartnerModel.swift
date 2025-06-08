//
//  PartnerViewModel.swift
//  ADFW
//
//  Created by MultiTV on 06/06/25.
//

import Foundation

struct PartnerModel : Codable {
    let status : Bool?
    let message : String?
    let data : PartnerData?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case message = "message"
        case data = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        data = try values.decodeIfPresent(PartnerData.self, forKey: .data)
    }

}


struct PartnerData : Codable {
    let data : [Partner]?
    let pagination : Pagination1?

    enum CodingKeys: String, CodingKey {

        case data = "data"
        case pagination = "pagination"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent([Partner].self, forKey: .data)
        pagination = try values.decodeIfPresent(Pagination1.self, forKey: .pagination)
    }

}

struct Partner : Codable {
    let id : Int?
//    let company_name : String?
//    let horizontal_logo : String?
//    let vertical_logo : String?
//    let is_deleted : Bool?
//    let sponsor_id : String?
//    let company_url : String?
//    let company_brief : String?
//    let contact_person_name : String?
//    let contact_person_email : String?
//    let contact_person_phone : String?
//    let contact_person_designation : String?
//    let brand_guidlinesImage : String?
//    let createdAt : String?
//    let updatedAt : String?
//    let publishedAt : String?
//    let isEdited : Bool?
//    let video_file_link : String?
//    let video_link : String?
//    let contact_person_country_code : String?
//    let password : String?
//    let executive : String?
//    let delegate : String?
//    let paddock_club : String?
//    let general_admission : String?
//    let rESOLVE : String?
//    let asset_Abu_Dhabi : String?
//    let fintech_Abu_Dhabi : String?
//    let aDSFF : String?
//    let remaining_executive_count : String?
//    let remaining_delegate_count : String?
//    let remaining_padock_club_count : String?
//    let remaining_general_admission_count : String?
//    let remaining_resolve_count : String?
//    let remaining_asset_abu_dhabi_count : String?
//    let remaining_fintech_abu_dhabi_count : String?
//    let remaining_adsff_count : String?
//    let single_day_delegate : String?
//    let remaining_single_day_delegate_count : String?
    let showInWebsite : Bool?
    let websiteImage : String?
//    let priority : Double?
    let categories : Categories?
//    let orderId : OrderId?
//    let sectors_id : String?
//    let sponsor_notes : [String]?
//    let ticket_masters : [String]?
//    let creator : Creator?
//    let modifiedBy : ModifiedBy?
//    let createdBy : String?
//    let updatedBy : String?

    enum CodingKeys: String, CodingKey {
        
        case id = "id"
        //        case company_name = "company_name"
        //        case horizontal_logo = "horizontal_logo"
        //        case vertical_logo = "vertical_logo"
        //        case is_deleted = "is_deleted"
        //        case sponsor_id = "sponsor_id"
        //        case company_url = "company_url"
        //        case company_brief = "company_brief"
        //        case contact_person_name = "contact_person_name"
        //        case contact_person_email = "contact_person_email"
        //        case contact_person_phone = "contact_person_phone"
        //        case contact_person_designation = "contact_person_designation"
        //        case brand_guidlinesImage = "brand_guidlinesImage"
        //        case createdAt = "createdAt"
        //        case updatedAt = "updatedAt"
        //        case publishedAt = "publishedAt"
        //        case isEdited = "isEdited"
        //        case video_file_link = "video_file_link"
        //        case video_link = "video_link"
        //        case contact_person_country_code = "contact_person_country_code"
        //        case password = "password"
        //        case executive = "executive"
        //        case delegate = "delegate"
        //        case paddock_club = "paddock_club"
        //        case general_admission = "general_admission"
        //        case rESOLVE = "RESOLVE"
        //        case asset_Abu_Dhabi = "Asset_Abu_Dhabi"
        //        case fintech_Abu_Dhabi = "Fintech_Abu_Dhabi"
        //        case aDSFF = "ADSFF"
        //        case remaining_executive_count = "remaining_executive_count"
        //        case remaining_delegate_count = "remaining_delegate_count"
        //        case remaining_padock_club_count = "remaining_padock_club_count"
        //        case remaining_general_admission_count = "remaining_general_admission_count"
        //        case remaining_resolve_count = "remaining_resolve_count"
        //        case remaining_asset_abu_dhabi_count = "remaining_asset_abu_dhabi_count"
        //        case remaining_fintech_abu_dhabi_count = "remaining_fintech_abu_dhabi_count"
        //        case remaining_adsff_count = "remaining_adsff_count"
        //        case single_day_delegate = "single_day_delegate"
        //        case remaining_single_day_delegate_count = "remaining_single_day_delegate_count"
        case showInWebsite = "showInWebsite"
        case websiteImage = "websiteImage"
        //        case priority = "priority"
        case categories = "categories"
        
        //        case sectors_id = "sectors_id"
        //  case sponsor_notes = "sponsor_notes"
        //    case ticket_masters = "ticket_masters"
        
        //  case modifiedBy = "modifiedBy"
        //        case createdBy = "createdBy"
        //        case updatedBy = "updatedBy"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        //        company_name = try values.decodeIfPresent(String.self, forKey: .company_name)
        //        horizontal_logo = try values.decodeIfPresent(String.self, forKey: .horizontal_logo)
        //        vertical_logo = try values.decodeIfPresent(String.self, forKey: .vertical_logo)
        //        is_deleted = try values.decodeIfPresent(Bool.self, forKey: .is_deleted)
        //        sponsor_id = try values.decodeIfPresent(String.self, forKey: .sponsor_id)
        //        company_url = try values.decodeIfPresent(String.self, forKey: .company_url)
        //        company_brief = try values.decodeIfPresent(String.self, forKey: .company_brief)
        //        contact_person_name = try values.decodeIfPresent(String.self, forKey: .contact_person_name)
        //        contact_person_email = try values.decodeIfPresent(String.self, forKey: .contact_person_email)
        //        contact_person_phone = try values.decodeIfPresent(String.self, forKey: .contact_person_phone)
        //        contact_person_designation = try values.decodeIfPresent(String.self, forKey: .contact_person_designation)
        //        brand_guidlinesImage = try values.decodeIfPresent(String.self, forKey: .brand_guidlinesImage)
        //        createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
        //        updatedAt = try values.decodeIfPresent(String.self, forKey: .updatedAt)
        //        publishedAt = try values.decodeIfPresent(String.self, forKey: .publishedAt)
        //        isEdited = try values.decodeIfPresent(Bool.self, forKey: .isEdited)
        //        video_file_link = try values.decodeIfPresent(String.self, forKey: .video_file_link)
        //        video_link = try values.decodeIfPresent(String.self, forKey: .video_link)
        //        contact_person_country_code = try values.decodeIfPresent(String.self, forKey: .contact_person_country_code)
        //        password = try values.decodeIfPresent(String.self, forKey: .password)
        //        executive = try values.decodeIfPresent(String.self, forKey: .executive)
        //        delegate = try values.decodeIfPresent(String.self, forKey: .delegate)
        //        paddock_club = try values.decodeIfPresent(String.self, forKey: .paddock_club)
        //        general_admission = try values.decodeIfPresent(String.self, forKey: .general_admission)
        //        rESOLVE = try values.decodeIfPresent(String.self, forKey: .rESOLVE)
        //        asset_Abu_Dhabi = try values.decodeIfPresent(String.self, forKey: .asset_Abu_Dhabi)
        //        fintech_Abu_Dhabi = try values.decodeIfPresent(String.self, forKey: .fintech_Abu_Dhabi)
        //        aDSFF = try values.decodeIfPresent(String.self, forKey: .aDSFF)
        //        remaining_executive_count = try values.decodeIfPresent(String.self, forKey: .remaining_executive_count)
        //        remaining_delegate_count = try values.decodeIfPresent(String.self, forKey: .remaining_delegate_count)
        //        remaining_padock_club_count = try values.decodeIfPresent(String.self, forKey: .remaining_padock_club_count)
        //        remaining_general_admission_count = try values.decodeIfPresent(String.self, forKey: .remaining_general_admission_count)
        //        remaining_resolve_count = try values.decodeIfPresent(String.self, forKey: .remaining_resolve_count)
        //        remaining_asset_abu_dhabi_count = try values.decodeIfPresent(String.self, forKey: .remaining_asset_abu_dhabi_count)
        //        remaining_fintech_abu_dhabi_count = try values.decodeIfPresent(String.self, forKey: .remaining_fintech_abu_dhabi_count)
        //        remaining_adsff_count = try values.decodeIfPresent(String.self, forKey: .remaining_adsff_count)
        //        single_day_delegate = try values.decodeIfPresent(String.self, forKey: .single_day_delegate)
        //        remaining_single_day_delegate_count = try values.decodeIfPresent(String.self, forKey: .remaining_single_day_delegate_count)
        showInWebsite = try values.decodeIfPresent(Bool.self, forKey: .showInWebsite)
        websiteImage = try values.decodeIfPresent(String.self, forKey: .websiteImage)
        //        priority = try values.decodeIfPresent(Double.self, forKey: .priority)
        categories = try values.decodeIfPresent(Categories.self, forKey: .categories)
        //    orderId = try values.decodeIfPresent(OrderId.self, forKey: .orderId)
        //        sectors_id = try values.decodeIfPresent(String.self, forKey: .sectors_id)
        //   sponsor_notes = try values.decodeIfPresent([String].self, forKey: .sponsor_notes)
        //   ticket_masters = try values.decodeIfPresent([String].self, forKey: .ticket_masters)
        //   creator = try values.decodeIfPresent(Creator.self, forKey: .creator)
        //  modifiedBy = try values.decodeIfPresent(ModifiedBy.self, forKey: .modifiedBy)
        //        createdBy = try values.decodeIfPresent(String.self, forKey: .createdBy)
        //        updatedBy = try values.decodeIfPresent(String.self, forKey: .updatedBy)
    }

}






struct Categories : Codable {
    let id : Int?
    let label : String?
    let value : String?
    let createdAt : String?
    let updatedAt : String?
    let publishedAt : String?
    let is_video_link : Bool?
    let showWebsite : Bool?
    let priority : Int?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case label = "label"
        case value = "value"
        case createdAt = "createdAt"
        case updatedAt = "updatedAt"
        case publishedAt = "publishedAt"
        case is_video_link = "is_video_link"
        case showWebsite = "showWebsite"
        case priority = "priority"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        label = try values.decodeIfPresent(String.self, forKey: .label)
        value = try values.decodeIfPresent(String.self, forKey: .value)
        createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
        updatedAt = try values.decodeIfPresent(String.self, forKey: .updatedAt)
        publishedAt = try values.decodeIfPresent(String.self, forKey: .publishedAt)
        is_video_link = try values.decodeIfPresent(Bool.self, forKey: .is_video_link)
        showWebsite = try values.decodeIfPresent(Bool.self, forKey: .showWebsite)
        priority = try values.decodeIfPresent(Int.self, forKey: .priority)
    }

}





struct Pagination1 : Codable {
    let page : Int?
    let pageSize : Int?
    let pageCount : Int?
    let total : Int?

    enum CodingKeys: String, CodingKey {

        case page = "page"
        case pageSize = "pageSize"
        case pageCount = "pageCount"
        case total = "total"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        page = try values.decodeIfPresent(Int.self, forKey: .page)
        pageSize = try values.decodeIfPresent(Int.self, forKey: .pageSize)
        pageCount = try values.decodeIfPresent(Int.self, forKey: .pageCount)
        total = try values.decodeIfPresent(Int.self, forKey: .total)
    }

}





