import UIKit

//
//  TicketUserViewModel.swift
//  ADFW
//
//  Created by MultiTV on 17/06/25.
//


struct GenericAPIResponse: Decodable {
    let status: Bool?
    let message: String
}

class UpdateUserViewModel {

    func updateUserProfile(userId: Int, parameters: [String: Any], in view: UIView, completion: @escaping (Result<Bool, Error>) -> Void) {
        let urlString = APIEndpoints.updateUser(userId: userId)
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")

        // Convert parameters to form-urlencoded string
        let bodyString = parameters.map { key, value in
            let encodedKey = key.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
            let encodedValue: String

            if let dict = value as? [String: String] {
                // Flatten nested dictionary as JSON string
                if let data = try? JSONSerialization.data(withJSONObject: dict),
                   let jsonString = String(data: data, encoding: .utf8) {
                    encodedValue = jsonString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
                } else {
                    encodedValue = ""
                }
            } else {
                encodedValue = "\(value)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
            }

            return "\(encodedKey)=\(encodedValue)"
        }.joined(separator: "&")

        request.httpBody = bodyString.data(using: .utf8)

        // Send the request
        NetworkManager.shared.sendRequest(request, in: view) { (result: Result<GenericAPIResponse, Error>) in
            switch result {
            case .success(let response):
                if response.status == true {
                    completion(.success(true))
                } else {
                    let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: response.message])
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
