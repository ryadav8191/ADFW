//
//  SpeakerViewModel.swift
//  ADFW
//
//  Created by MultiTV on 05/06/25.
//

import Foundation
import UIKit



class SpeakerViewModel {
    
    func fetchSpeakerData(in view: UIView, search:String?, completion: @escaping (Result<[SpeakerData], Error>) -> Void) {
        let urlString = APIEndpoints.getAllSpeakersURL(page: 1, pageSize: 100,searchQuery: search)
        
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
    
    func fetchSpeakerLimitData(in view: UIView, search:String?, completion: @escaping (Result<[SpeakerData], Error>) -> Void) {
        let urlString = APIEndpoints.getStaticSpeakerListURL(limit: 10)
        
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
