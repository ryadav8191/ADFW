//
//  MajorEventAgandaViewModel.swift
//  ADFW
//
//  Created by MultiTV on 07/06/25.
//

import Foundation
import UIKit


class MajorEventAgandaViewModel {
    
    func fetchMajorAgandaData(date: String, page: Int, pageSize: Int = 50, in view: UIView, completion: @escaping (Result<[MajorEventAgandaData], Error>) -> Void) {
        let urlString = APIEndpoints.getMajorEvent(date: date, isFilter: true)

        NetworkManager.shared.fetchData(from: urlString, in: view) { (result: Result<MajorEventAgandaModel, Error>) in
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

