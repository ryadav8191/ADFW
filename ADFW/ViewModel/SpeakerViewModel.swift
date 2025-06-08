//
//  SpeakerViewModel.swift
//  ADFW
//
//  Created by MultiTV on 05/06/25.
//

import Foundation
import UIKit



class SpeakerViewModel {
    
    func fetchSpeakerData(in view: UIView, completion: @escaping (Result<SpeakerData, Error>) -> Void) {
        let urlString = APIEndpoints.getSpeaker
        
        NetworkManager.shared.fetchData(from: urlString, in: view) { (result: Result<SpeakerResponseModel, Error>) in
            switch result {
            case .success(let response):
                if let results = response.data {
                    
                    completion(.success(results))
                } else {
                    completion(.failure(NetworkError.noData))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
