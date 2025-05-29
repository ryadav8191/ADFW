//
//  APIEndpoints.swift
//  EventApp
//
//  Created by MultiTV on 19/02/25.
//

import Foundation


struct APIEndpoints {
    static let baseURL = "https://vapi.multitvsolution.com/msvc/"
     static private let eventId = "309"

    static var token: String {
        return APITokenManager.token ?? "6646f04e2365d"
    }

    static var homepageData: String {
        return "\(baseURL)home_new.php?id=309"
    }
  
    
    
    static var postNote: String {
        return "\(baseURL)post_notes.php"
    }
    
    
    static func notes(id:Int) -> String {
         return "\(baseURL)note_all.php?user_id=\(id)"
     }
    
   
    
    static var localisationData: String {
        return "\(baseURL)lamplight_get.php"
    }
    
    static var hotelData: String {
        return "\(baseURL)hotel.php?hotel_id=13"
    }
    
  
  
    static var feedback: String {
        return "\(baseURL)feedback_new.php"
    }

    


    static var conferenceAgandaData: String {
        return "\(baseURL)conference_agenda.php?id=309&app_id=1"
    }
    
    static var detailAganda: String {
        return "\(baseURL)agenda_details.php?agenda_id=8"
    }
    
   

    static var getSpeaker: String {
        return "\(baseURL)speaker_all.php"
    }
    
    static var getAboutDoha: String {
        return "\(baseURL)about_doha.php?doha_id=11"
    }
   
    
    static var Award: String {
        return "\(baseURL)"
    }
    
//https://vapi.multitvsolution.com/msvc/conference_page.php?id=309&parent_id=1&category=MSIL-SC
   
    static var getTravelDetail: String {
        return "\(baseURL)travel_details.php?travel_id=12"
    }
    
    static var welcomeData: String {
        return "\(baseURL)welcome_message.php?banner_id=1"
    }
   
    static var doAndDont: String {
        return "\(baseURL)do_and_dont.php?do_and_dont_id=20"
    }
    
//    static var travelAndStay: String {
//        return "\(baseURL)hotel_stay.php?hotel_stay_id=10category=\(LocalDataManager.getLoginResponse()?.category ?? "")"
//    }
   
  
    static var postQuestion: String {
        return "https://vstreamapi.multitvsolution.com/v1/ask/live/question/post"
    }
    
    static var weatherData: String {
        return "\(baseURL)get_weather.php?city=doha"
    }
    
    static var shuttleBus: String {
        return "\(baseURL)shuttle_bus_details.php?shuttle_bus_id=40"
    }
    
    
    static func speakerData(speakerID: Int) -> String {
        return "\(baseURL)"
    }
    
    static func award(id:Int) -> String {
         return "\(baseURL)awards.php?event_id=309&user_id=\(id)"
     }

    static var getDessCode: String {
        return "\(baseURL)dress_code.php?dress_id=7"
    }
    
    static var eventLocation: String {
        return "\(baseURL)event_location.php"
    }
    
    static func  getSeatingData(id:Int) -> String {
        return "\(baseURL)seating_plan.php?user_id=\(id)"
    }
        
    
    static var getFoodPlan: String {
        return "\(baseURL)food_details.php?food_id=18"
    }
    
    static var getSpouseTour: String {
        return "\(baseURL)spouse_tour.php?spouse_tour_id=16"
    }
    
    static var addInterest: String {
        return "\(baseURL)"
    }
    
    static var verifyOtp: String {
        return "\(baseURL)verify_otp.php"
    }
    
    static var login: String {
        return "\(baseURL)login.php"
    }
    
   
   
    static func  digital_exhibition(id:Int) -> String {
        return "\(baseURL)digital_exhibition.php?user_id=\(id)"
    }
   
}



