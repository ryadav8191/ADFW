import UIKit

//
//  TicketUserViewModel.swift
//  ADFW
//
//  Created by MultiTV on 17/06/25.
//


struct GenericAPIResponse: Decodable {
    let status: Bool?
    let message: String?
}

class UpdateUserViewModel {

    func updateUserProfile(userId: Int, parameters: [String: Any], in view: UIView, completion: @escaping (Result<UpdateProfileData?, Error>) -> Void) {
        let urlString = APIEndpoints.updateUser(userId: userId)
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        // Wrap parameters in a "data" dictionary as shown in your cURL
        let wrappedParameters = ["data": parameters]

        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: wrappedParameters, options: [])
        } catch {
            print("Failed to serialize JSON: \(error)")
            completion(.failure(error))
            return
        }

        // Send the request
        NetworkManager.shared.sendRequest(request, in: view) { (result: Result<UpdateProfileModel, Error>) in
            switch result {
            case .success(let response):
                if let data = response.data {
                    completion(.success(data))
                } else {
                   
                    completion(.failure(NetworkError.noData))
                }
            case .failure:
                completion(.failure(NetworkError.custom(message: "Something went wrong")))
            }
        }
    }

}
