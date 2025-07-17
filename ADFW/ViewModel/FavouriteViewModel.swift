//
//  FavouriteViewModel.swift
//  ADFW
//
//  Created by MultiTV on 02/07/25.
//


import UIKit

class FavouriteViewModel {
    
    func addToFavourites(ticketId: Int, sessionId: Int, agendaId: Int, agendaDate: String, in view: UIView, completion: @escaping (Result<String, Error>) -> Void) {
        
        let urlString = APIEndpoints.addFavorite
        guard let url = URL(string: urlString) else {
            print("Invalid URL string")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body: [String: Any] = [
            "ticketId": ticketId,
            "sessionId": sessionId,
            "agendaId": agendaId,
            "agendaDate": agendaDate
        ]
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: body, options: [])
        } catch {
            print("Failed to serialize JSON:", error)
            completion(.failure(error))
            return
        }
        
        NetworkManager.shared.sendRequest(request, in: view) { (result: Result<GenericAPIResponse, Error>) in
            switch result {
            case .success(let response):
                if response.status == true {
                    completion(.success(response.message ?? "Added to favourites successfully."))
                } else {
                    let message = response.message ?? "Failed to add to favourites."
                    completion(.failure(NetworkError.custom(message: message)))
                }
            case .failure(let error):
                print("Network error:", error.localizedDescription)
                completion(.failure(NetworkError.custom(message: "Something went wrong.")))
            }
        }
    }
    
    
    func fetchFavourites( ticketId: Int,
                          page: Int = 1,
                          pageSize: Int = 10,
                          search: String? = nil,
                          locationId: String? = nil,
                          agendaId: Int? = nil, in view: UIView, completion: @escaping (Result<[FavouriteData], Error>) -> Void) {
        let urlString = APIEndpoints.getFavouritesByTicketId(ticketId: ticketId, page: page, search: search, locationId: locationId, agendaId: agendaId)

        NetworkManager.shared.fetchData(from: urlString, in: view) { (result: Result<FavouriteModel, Error>) in
            switch result {
            case .success(let response):
                if response.status ?? false, let favourites = response.data {
                    completion(.success(favourites))
                } else {
                    completion(.failure(NetworkError.noData))
                }
            case .failure(let error):
                print("Fetch error: \(error.localizedDescription)")
                completion(.failure(error))
            }
        }
    }
}
