//
//  EntertainmentViewModel.swift
//  ADFW
//
//  Created by MultiTV on 06/06/25.
//

import UIKit

class EntertainmentViewModel {
    
    func fetchEntertainmentData(
        page: Int,
        pageSize: Int,
        sort: String = "createdAt:desc",
        in view: UIView,
        completion: @escaping (Result<EntertainmentModel, Error>) -> Void
    ) {
        var components = URLComponents(string: APIEndpoints.entertainment)
        components?.queryItems = [
            URLQueryItem(name: "pagination[page]", value: "\(page)"),
            URLQueryItem(name: "pagination[pageSize]", value: "\(pageSize)"),
            URLQueryItem(name: "sort", value: sort)
        ]

        guard let url = components?.url?.absoluteString else {
            completion(.failure(NetworkError.invalidURL))
            return
        }

        NetworkManager.shared.fetchData(from: url, in: view) { (result: Result<EntertainmentResponseModel, Error>) in
            switch result {
            case .success(let response):
                if response.status == true {
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
