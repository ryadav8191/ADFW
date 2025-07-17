//
//  SearchViewModel.swift
//  ADFW
//
//  Created by MultiTV on 10/07/25.
//

import Foundation
import UIKit

class SearchViewModel {
    
    
    func fetchGobalSearchData(in view: UIView, search:String, completion: @escaping (Result<GlobalSearchData, Error>) -> Void) {
        let urlString = APIEndpoints.GlobalSearch(search: search)
        
        NetworkManager.shared.fetchData(from: urlString, in: view) { (result: Result<GlobalSearchModel, Error>) in
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
