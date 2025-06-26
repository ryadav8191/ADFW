//
//  RestaurantViewModel.swift
//  ADFW
//
//  Created by MultiTV on 20/06/25.
//


import Foundation
import UIKit

class RestaurantViewModel {

    func fetchRestaurants(page: Int = 1, pageSize: Int = 10, in view: UIView, completion: @escaping (Result<[RestaurantData], Error>) -> Void) {
        let urlString = APIEndpoints.getAllRestaurant(page: page, pageSize: pageSize)
        
        NetworkManager.shared.fetchData(from: urlString, in: view) { (result: Result<RestaurantModel, Error>) in
            switch result {
            case .success(let response):
                if response.status == true, let restaurants = response.data {
                    completion(.success(restaurants))
                } else {
                    completion(.failure(NetworkError.noData))
                }
            case .failure(let error):
                print(error.localizedDescription)
                completion(.failure(error))
            }
        }
    }
}
