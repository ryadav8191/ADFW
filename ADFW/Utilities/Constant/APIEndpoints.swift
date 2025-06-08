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
    
  
  
    static var entertainment: String {
        return "\(baseURL)entertainment/findAllByDate"
    }

   
    static func getMajorEvent(date:String, isFilter: Bool) -> String {
        return "\(baseURL)agenda/byDate?isSessionFilter=\(isFilter)&date=\(date)"
    }
//https://api-prod.adfw.com/api/agenda/byDate
    
    
   

    static var getSpeaker: String {
        return "\(baseURL)speaker/all"
    }
    
    
    
//    static var getPartner: String {
//        return "\(baseURL)about_doha.php?doha_id=11"
//    }
   
    
   

  
   
    static func  getSeatingData(id:Int) -> String {
        return "\(baseURL)seating_plan.php?user_id=\(id)"
    }
        
    
   
   
}



