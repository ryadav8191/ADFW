//
//  ProfileViewModel.swift
//  ADFW
//
//  Created by MultiTV on 18/06/25.
//

import Foundation
import UIKit

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
}
