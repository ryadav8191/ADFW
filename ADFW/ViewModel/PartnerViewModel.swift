//
//  PartnerViewModel.swift
//  ADFW
//
//  Created by MultiTV on 06/06/25.
//



import Foundation
import UIKit






class PartnerViewModel {
    
    func fetchPartnerData(page: Int, pageSize: Int = 100, in view: UIView, completion: @escaping (Result<PartnerData, Error>) -> Void) {
        let urlString = APIEndpoints.getAllSponsors(page: page, pageSize: pageSize)

        NetworkManager.shared.fetchData(from: urlString, in: view) { (result: Result<PartnerModel, Error>) in
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
}

