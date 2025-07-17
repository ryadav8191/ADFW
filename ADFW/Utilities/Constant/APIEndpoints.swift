//
//  APIEndpoints.swift
//  EventApp
//
//  Created by MultiTV on 19/02/25.
//

import Foundation


struct APIEndpoints {
    static let baseURL = "https://adminadfw.videostech.cloud/api/"
    static let APP_ID = "72862838-E945-44E7-8722-6B469BAD650B"
    static private let eventId = "309"
    
    static var token: String {
        return APITokenManager.token ?? "6646f04e2365d"
    }
    
    static var homepageData: String {
        return "\(baseURL)home_new.php?id=309"
    }
    
    
    static var LoginUrl: String {
        return "\(baseURL)user/login/"
    }
    
    static func getFilteredAgendasURL() -> String {
        let query = """
        ?filters[is_deleted]=false\
        &pagination[limit]=-1\
        &filters[published]=true\
        &filters[viewAgenda]=true
        """
        return baseURL + "agendas/" + query
    }
    
    static  func getAllSponsors(page: Int, pageSize: Int) -> String {
        return "\(baseURL)sponsor/all?page=\(page)&pageSize=\(pageSize)"
    }
    
    static func getHomeSessionURL() -> String {
        let query = """
        ?populate=*\
        &filters[is_deleted][$eq]=false\
        &sort=priority:asc\
        &filters[major_event]=true\
        &filters[published][$eq]=true\
        &filters[is_deleted]=false
        """
        
        return baseURL + "agendas/" + query
    }
    
    
    
    
    static var entertainment: String {
        return "\(baseURL)entertainment/findAllByDate"
    }
    
    
    static func getMajorEvent(date:String, isFilter: Bool) -> String {
        return "\(baseURL)agenda/byDate?isSessionFilter=\(isFilter)&date=\(date)"
    }
    
    static func getAgendasByDate(
        date: String?,
        searchTerm: String?
    ) -> String {
        var components = URLComponents(string: "\(baseURL)agenda/byDate")
        
        var queryItems: [URLQueryItem] = []

//        // Use `date` only if searchTerm is empty or nil
//        if let searchTerm = searchTerm, searchTerm.isEmpty, let date = date {
//            queryItems.append(URLQueryItem(name: "date", value: date))
//        } else if searchTerm == nil, let date = date {
//            queryItems.append(URLQueryItem(name: "date", value: date))
//        }

        // Always include `search`, even if empty
        queryItems.append(URLQueryItem(name: "search", value: searchTerm ?? ""))

        components?.queryItems = queryItems
        return components?.url?.absoluteString ?? "\(baseURL)agenda/byDate"
    }

    
    //    static func getAgendaByDateURL(date: String, id: Int?,isSessionFilter: Bool) -> String {
    //        var query = ""
    //
    //        if isSessionFilter {
    //            if let id = id {
    //                query = "?isSessionFilter=true&date=\(date)&id=\(id)"
    //            } else {
    //                query = "?isSessionFilter=true&date=\(date)"
    //            }
    //        } else {
    //            query = "?date=\(date)"
    //        }
    //
    //        return baseURL + "agenda/byDate" + query
    //    }
    
    static func getAgendaByDateURL(
        date: String,
        id: Int?,
        isSessionFilter: Bool,
        search: String?,
        isSessionSearch: Bool
    ) -> String {
        var queryItems: [String] = []
        
        if isSessionFilter {
            queryItems.append("isSessionFilter=true")
        }
        
        queryItems.append("date=\(date)")
        
        if let id = id {
            queryItems.append("id=\(id)")
        }
        
        if let search = search, !search.isEmpty {
            queryItems.append("search=\(search)")
            if isSessionSearch {
                queryItems.append("isSessionSearch=true")
            }
        }
        
        let query = "?" + queryItems.joined(separator: "&")
        return baseURL + "agenda/byDate" + query
    }
    
    
    static func getAllSpeakersURL(page: Int, pageSize: Int, searchQuery: String? = nil, agendaPermaLink: String? = nil) -> String {
        var query = """
        ?populate=agenda_sessions.agenda\
        &filters[published]=true\
        &sort=priority:asc\
        &filters[is_deleted][$eq]=false\
        &fields[0]=firstName\
        &fields[1]=lastName\
        &fields[2]=companyName\
        &fields[3]=designation\
        &fields[4]=photoUrl\
        &fields[5]=bio\
        &pagination[pageSize]=\(pageSize)\
        &pagination[page]=\(page)
        """
        
        if let q = searchQuery {
            let encoded = q.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
            query += """
            &filters[$or][0][firstName][$containsi]=\(encoded)\
            &filters[$or][1][lastName][$containsi]=\(encoded)
            """
        }
        
        if let permaLink = agendaPermaLink {
            let encoded = permaLink.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
            query += "&filters[agenda_sessions][agenda][permaLink][$eq]=\(encoded)"
        }
        
        return baseURL + "speakers" + query
    }
    
    
    static func getStaticSpeakerListURL(limit: Int) -> String {
        let query = """
        ?populate=agenda_sessions.agenda\
        &filters[published]=true\
        &sort=priority:asc\
        &filters[is_deleted][$eq]=false\
        &fields[0]=firstName\
        &fields[1]=lastName\
        &fields[2]=companyName\
        &fields[3]=designation\
        &fields[4]=photoUrl\
        &fields[5]=bio\
        &pagination[limit]=\(limit)
        """
        
        return baseURL + "speakers" + query
    }
    
    static func  getSeatingData(id:Int) -> String {
        return "\(baseURL)seating_plan.php?user_id=\(id)"
    }
    
    
    
    
    static func getCountry() -> String {
        return "\(baseURL)countries?pagination[limit]=-1"
    }
    
    //   "https://api-prod.adfw.com/api/"
    
    //"https://api-prod.adfw.com/api/"
    
    static func updateUser(userId: Int) -> String {
        return "\(baseURL)ticket-masters/\(userId)"
    }
    
    
    static var getVenue: String {
        return "\(baseURL)venues?filters[is_deleted]=false&pagination[limit]=-1"
    }
    
    
    
    
    static  func getAllRestaurant(page: Int, pageSize: Int) -> String {
        return "\(baseURL)restaurant/byLocation?page=\(page)&pageSize=\(pageSize)"
    }
    
    static func fetchItems(forRestaurantId id: Int) -> String {
        return "\(baseURL)restaurant/findAllItems/\(id)"
    }
    
    
    // https://api-prod.adfw.com/api/agendas/?populate=*&filters[is_deleted][$eq]=false&sort=priority:asc&filters[major_event]=true&filters[published][$eq]=true&filters[is_deleted]=false
    
    
    static func fetchFeaturedAgendas() -> String {
        return "\(baseURL)agendas/?populate=*&filters[is_deleted][$eq]=false&sort=priority:asc&filters[major_event]=true&filters[published][$eq]=true"
    }
    
    
    
    static var getAllInterest: String {
        return "\(baseURL)interests?pagination[page]=1&pagination[pageSize]=10&sort=createdAt:desc"
    }
    
    
    static func fetchTicketBenefits(ticketNumber: String) -> String {
        return "\(baseURL)ticket-benefit/\(ticketNumber)"
    }
    
    static func fetchNotifications(page: Int, pageSize: Int) -> String {
        return "\(baseURL)notification/all?page=\(page)&pageSize=\(pageSize)"
    }
    
    
    static func getHomeBanner(page: Int, pageSize: Int) -> String {
        return "\(baseURL)homes?pagination[page]=\(page)&pagination[pageSize]=\(pageSize)&sort=createdAt:desc"
    }
    
    static var getAboutADGMData: String {
        return "\(baseURL)about-adgms"
    }
    
    static var addFavorite: String {
        return "\(baseURL)favourites/add"
    }
    
    
    static func getFavouritesByTicketId(
        ticketId: Int,
        page: Int,
        pageSize: Int = 100,
        search: String?,
        locationId: String?,
        agendaId: Int?
    ) -> String {
        var components = URLComponents(string: "\(baseURL)favourites/findByTicketId/\(ticketId)")
        
        var queryItems: [URLQueryItem] = [
            URLQueryItem(name: "page", value: "\(page)"),
            URLQueryItem(name: "pageSize", value: "\(pageSize)")
        ]
        
        if let search = search, !search.isEmpty {
            queryItems.append(URLQueryItem(name: "search", value: search))
        }
        if let locationId = locationId, !locationId.isEmpty {
            queryItems.append(URLQueryItem(name: "locationId", value: locationId))
        }
        if let agendaId = agendaId {
            queryItems.append(URLQueryItem(name: "agendaId", value: String(agendaId)))
        }
        
        components?.queryItems = queryItems
        return components?.url?.absoluteString ?? "\(baseURL)favourites/findByTicketId/\(ticketId)"
    }

    
    static func getAgendaSessionDetailURL(sessionId: Int, ticketId: Int) -> String {
        return "\(baseURL)agenda-sessions/findOne/\(sessionId)?ticketId=\(ticketId)"
    }
    
    static func removeFavouriteURL(ticketId: Int, sessionId: Int) -> String {
        return "\(baseURL)favourites/remove/\(ticketId)/\(sessionId)"
    }
    
    
    static func getInterestByIdURL(_ id: Int) -> String {
        return "\(baseURL)interests/findById/\(id)"
    }

    static func createInterestURL() -> String {
        return "\(baseURL)interests/create"
    }

    //https://adminadfw.videostech.cloud/api/uploadImageorPdf
    
    
    static var uploadFile: String {
        return "\(baseURL)uploadImageorPdf"
    }
    
    static func GlobalSearch(search: String) -> String {
        return "\(baseURL)global-search?search=\(search)"
    }
    
}



