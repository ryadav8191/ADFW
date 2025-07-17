//
//  ProfileViewModel.swift
//  ADFW
//
//  Created by MultiTV on 18/06/25.
//

import Foundation
import UIKit

struct SaveInterestRequest: Codable {
    let ticketId: Int
    let interests: [UserInterestData]
}

class InterestViewModel {
    
    func fetchInterests(in view: UIView, completion: @escaping (Result<[InterestData], Error>) -> Void) {
        let urlString = APIEndpoints.getAllInterest
        
        NetworkManager.shared.fetchData(from: urlString, in: view) { (result: Result<InterestModel, Error>) in
            switch result {
            case .success(let response):
                if let interests = response.data {
                    completion(.success(interests))
                } else {
                  
                    completion(.failure(NetworkError.noData))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchInterestById(id: Int, in view: UIView, completion: @escaping (Result<[UserInterestData], Error>) -> Void) {
            let urlString = APIEndpoints.getInterestByIdURL(id)
            
            NetworkManager.shared.fetchData(from: urlString, in: view) { (result: Result<UserInterestModel, Error>) in
                switch result {
                case .success(let response):
                    if let status = response.status, status == true, let data = response.data {
                        completion(.success(data))
                    } else {
                        completion(.failure(NetworkError.unsuccessful))
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    
    func saveInterests(ticketId: Int, interests: [UserInterestData], in view: UIView, completion: @escaping (Result<String, Error>) -> Void) {
            let urlString = APIEndpoints.createInterestURL()
            
            guard let url = URL(string: urlString) else {
                completion(.failure(NetworkError.invalidURL))
                return
            }

            let requestBody = SaveInterestRequest(ticketId: ticketId, interests: interests)

            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            do {
                let jsonData = try JSONEncoder().encode(requestBody)
                request.httpBody = jsonData
            } catch {
                completion(.failure(NetworkError.decodingError(error)))
                return
            }

        NetworkManager.shared.sendRequest(request, in: view) { (result: Result<GenericAPIResponse, Error>) in
                switch result {
                case .success(let response):
                    if response.status == true {
                        completion(.success(response.message ?? "Interest saved successfully"))
                    } else {
                        completion(.failure(NetworkError.unsuccessful))
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
}
