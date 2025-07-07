//
//  AgandaViewModel.swift
//  ADFW
//
//  Created by MultiTV on 10/06/25.
//

import Foundation
import UIKit


class EventAgandaViewModel {
    
    func agandaData(isSessionFilter: Bool,date: String, search: String?, isSessionSearch: Bool,  page: Int, pageSize: Int = 50, id: Int?, in view: UIView, completion: @escaping (Result<[EventAgandaData], Error>) -> Void) {
        let urlString = APIEndpoints.getAgendaByDateURL(date: date, id: id, isSessionFilter: isSessionFilter, search: search, isSessionSearch: isSessionSearch)

        NetworkManager.shared.fetchData(from: urlString, in: view) { (result: Result<AgandaModel, Error>) in
            switch result {
            case .success(let response):
                if let status = response.status, status == true {
                    if let result = response.data {
                        completion(.success(result))
                    } else {
                        completion(.failure(NetworkError.noData))
                    }
                } else {
                    completion(.failure(NetworkError.unsuccessful))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    
    func agandaFilterData(page: Int, pageSize: Int = 50, id: Int, in view: UIView, completion: @escaping (Result<[AgandaFilterData], Error>) -> Void) {
        let urlString = APIEndpoints.getFilteredAgendasURL()

        NetworkManager.shared.fetchData(from: urlString, in: view) { (result: Result<AgandaFilterModel, Error>) in
            switch result {
            case .success(let response):
//                if let status = response.status, status == true {
                    if let result = response.data {
                        completion(.success(result))
                    } else {
                        completion(.failure(NetworkError.noData))
                    }
//                } else {
//                    completion(.failure(NetworkError.unsuccessful))
//                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchAgendaSessionDetail(sessionId: Int, ticketId: Int, in view: UIView, completion: @escaping (Result<FavSessionData, Error>) -> Void) {
        let urlString = APIEndpoints.getAgendaSessionDetailURL(sessionId: sessionId, ticketId: ticketId)
        
        NetworkManager.shared.fetchData(from: urlString, in: view) { (result: Result<FavSessionModel, Error>) in
            switch result {
            case .success(let response):
                if let status = response.status, status == true {
                    if let data = response.data {
                        completion(.success(data))
                    } else {
                        completion(.failure(NetworkError.noData))
                    }
                } else {
                    completion(.failure(NetworkError.unsuccessful))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    
    func removeFromFavourites(ticketId: Int, sessionId: Int, in view: UIView, completion: @escaping (Result<String, Error>) -> Void) {
        let urlString = APIEndpoints.removeFavouriteURL(ticketId: ticketId, sessionId: sessionId)
        
        guard let url = URL(string: urlString) else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        NetworkManager.shared.sendRequest(request, in: view) { (result: Result<GenericResponseModel, Error>) in
            switch result {
            case .success(let response):
                if response.status == true {
                    completion(.success(response.message ?? "Successfully removed from favourites."))
                } else {
                    completion(.failure(NetworkError.unsuccessful))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }


}
