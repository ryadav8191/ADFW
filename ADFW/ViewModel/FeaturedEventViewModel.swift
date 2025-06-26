//
//  AgendaViewModel.swift
//  ADFW
//
//  Created by MultiTV on 23/06/25.
//


import Foundation
import UIKit

class FeaturedEventViewModel {
    
    func fetchAgendas(in view: UIView, completion: @escaping (Result<[FeaturedEventData], Error>) -> Void) {
        let urlString = APIEndpoints.fetchFeaturedAgendas()
        
        NetworkManager.shared.fetchData(from: urlString, in: view) { (result: Result<FeaturedEventModel, Error>) in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    let agendas =  response.data
                    completion(.success(agendas ?? []))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
}
