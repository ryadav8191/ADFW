//
//  EntertainmentViewModel.swift
//  ADFW
//
//  Created by MultiTV on 06/06/25.
//

import UIKit

class EntertainmentViewModel {
    
    func fetchEntertainmentData(in view: UIView, completion: @escaping (Result<EntertainmentModel, Error>) -> Void) {
        let urlString = APIEndpoints.entertainment

        NetworkManager.shared.fetchData(from: urlString, in: view) { (result: Result<EntertainmentResponseModel, Error>) in
            switch result {
            case .success(let response):
                // Check if status is true
                if response.status == true {
                    if let result = response.data {
                        completion(.success(result))
                    } else {
                        completion(.failure(NetworkError.noData))
                    }
                } else {
                    // Server responded but with an unsuccessful status
                    completion(.failure(NetworkError.unsuccessful))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
