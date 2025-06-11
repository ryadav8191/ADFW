//
//  AgandaViewModel.swift
//  ADFW
//
//  Created by MultiTV on 10/06/25.
//

import Foundation
import UIKit


class EventAgandaViewModel {
    
    func agandaData(date: String, page: Int, pageSize: Int = 50, id: Int, in view: UIView, completion: @escaping (Result<[EventAgandaData], Error>) -> Void) {
        let urlString = APIEndpoints.getAgendaByDateURL(date: date, id: id)

        NetworkManager.shared.fetchData(from: urlString, in: view) { (result: Result<AgandaModel, Error>) in
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
