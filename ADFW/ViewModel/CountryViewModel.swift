//
//  CountryViewModel.swift
//  ADFW
//
//  Created by MultiTV on 18/06/25.
//

import UIKit
import Kingfisher


class CountryViewModel {
    
    func fetchCountries(in view: UIView, completion: @escaping (Result<[CountryAttributes], Error>) -> Void) {
        let urlString = APIEndpoints.getCountry()
        
        NetworkManager.shared.fetchData(from: urlString, in: view) { (result: Result<CountryResponse, Error>) in
            switch result {
            case .success(let response):
                if let countries = response.data?.compactMap({ $0.attributes }) {
                    completion(.success(countries))
                } else {
                    completion(.failure(NetworkError.noData))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func loadFlagImage(for country: String?, completion: @escaping (UIImage) -> Void) {
        guard let flagCode = country?.lowercased(),
              let flagURL = URL(string: "https://flagcdn.com/w40/\(flagCode).png") else {
            completion(UIImage(systemName: "flag") ?? UIImage())
            return
        }

        KingfisherManager.shared.retrieveImage(with: flagURL) { result in
            switch result {
            case .success(let imageResult):
                completion(imageResult.image)
            case .failure:
                completion(UIImage(systemName: "flag") ?? UIImage())
            }
        }
    }

}
