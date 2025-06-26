//
//  TicketBenefitViewModel.swift
//  ADFW
//
//  Created by MultiTV on 24/06/25.
//

import Foundation
import UIKit

class TicketBenefitViewModel {
    func fetchTicketBenefits(ticketNumber: String, in view: UIView, completion: @escaping (Result<[TicketBenefitData], Error>) -> Void) {
        let urlString = APIEndpoints.fetchTicketBenefits(ticketNumber: ticketNumber)
        
        NetworkManager.shared.fetchData(from: urlString, in: view) { (result: Result<TicketBenefitModel, Error>) in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    if (response.status ?? false), let benefits = response.data {
                        completion(.success(benefits))
                    } else {
                        let message = response.message
                       
                        completion(.failure(NetworkError.custom(message: message ?? "")))
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
}

