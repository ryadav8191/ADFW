//
//  LoginViewModel.swift
//  ADFW
//
//  Created by MultiTV on 17/06/25.
//

import Foundation
import UIKit

class LoginViewModel {
    func loginWithTicket(lastName: String, ticketNumber: String, webLogin: Bool = false, in view: UIView, completion: @escaping (Result<User, Error>) -> Void) {
        
        let urlString = APIEndpoints.LoginUrl
        guard let url = URL(string: urlString) else {
            print("Invalid URL string")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        // Encode form parameters
        let bodyString = "lastName=\(lastName)&ticketNumber=\(ticketNumber)&webLogin=\(webLogin)"
        request.httpBody = bodyString.data(using: .utf8)

        NetworkManager.shared.sendRequest(request, in: view) { (result: Result<LoginModel, Error>) in
            switch result {
            case .success(let loginResponse):
                if let status = loginResponse.status, status == true {
                    if let userData = loginResponse.data?.user {
                        completion(.success(userData))
                    } else {
                        completion(.failure(NetworkError.noData))
                    }
                } else {
                    
                    let errorMessage = loginResponse.message?.isEmpty == false ? loginResponse.message! : "Something went wrong."
                    completion(.failure(NetworkError.custom(message: errorMessage)))
                    
                    
                }
                
            case .failure(let error):
                print(error.localizedDescription)
                let errorMessage =  "Something went wrong."
                completion(.failure(NetworkError.custom(message: errorMessage)))
                
            }
        }
    }
}
