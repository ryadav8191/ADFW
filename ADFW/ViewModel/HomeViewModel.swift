//
//  HomeViewModel.swift
//  ADFW
//
//  Created by MultiTV on 10/06/25.
//

import Foundation
import UIKit


class HomeViewModel {
    
    func fetchHomeSessionData(page: Int, pageSize: Int = 50, in view: UIView, completion: @escaping (Result<[UpcomingSessionsData], Error>) -> Void) {
        let urlString = APIEndpoints.getHomeSessionURL()

        NetworkManager.shared.fetchData(from: urlString, in: view) { (result: Result<UpcomingSessionsModel, Error>) in
            switch result {
            case .success(let response):
//                if let status = response.status, status == true {
                    if let result = response.data {
                        completion(.success(result))
                    } else {
                        completion(.failure(NetworkError.noData))
                    }
//                } else {
//                    completion(.failure(NetworkError.unsuccessful))
//                }
            case .failure(let error):
                completion(.failure(NetworkError.custom(message: "Something Went Wrong")))

            }
        }
    }
    
    func fetchHomeBannerData(page: Int, pageSize: Int = 50, in view: UIView, completion: @escaping (Result<[HomeData], Error>) -> Void) {
        let urlString = APIEndpoints.getHomeBanner(page: page, pageSize: pageSize)

        NetworkManager.shared.fetchData(from: urlString, in: view) { (result: Result<HomeDataModel, Error>) in
            switch result {
            case .success(let response):
//                if let status = response.status, status == true {
                    if let result = response.data {
                        completion(.success(result))
                    } else {
                        completion(.failure(NetworkError.noData))
                    }
//                } else {
//                    completion(.failure(NetworkError.unsuccessful))
//                }
            case .failure(let error):
                print(error.localizedDescription)
                completion(.failure(NetworkError.custom(message: "Something Went Wrong")))
            }
        }
    }
    
}
