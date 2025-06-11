//
//  APIEndpoints.swift
//  EventApp
//
//  Created by MultiTV on 19/02/25.
//

import Foundation


struct APIEndpoints {
    static let baseURL = "https://adfw.multitvsolution.com/api/"
     static private let eventId = "309"

    static var token: String {
        return APITokenManager.token ?? "6646f04e2365d"
    }

    static var homepageData: String {
        return "\(baseURL)home_new.php?id=309"
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

    static func getAgendaByDateURL(date: String, id: Int) -> String {
        let query = "?isSessionFilter=true&date=\(date)&id=\(id)"
        return baseURL + "agenda/byDate" + query
    }

    
    
   

    static var getSpeaker: String {
        return "\(baseURL)speaker/all"
    }
    
    static func getAllSpeakersURL(page: Int, pageSize: Int, searchQuery: String? = nil) -> String {
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



    
//    static var getPartner: String {
//        return "\(baseURL)about_doha.php?doha_id=11"
//    }
   
    
   

  
   
    static func  getSeatingData(id:Int) -> String {
        return "\(baseURL)seating_plan.php?user_id=\(id)"
    }
        
    
   
   
}



