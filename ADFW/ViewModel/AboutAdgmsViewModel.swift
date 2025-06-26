//
//  AboutAdgmsViewModel.swift
//  ADFW
//
//  Created by MultiTV on 26/06/25.
//


import Foundation
import UIKit

class AboutAdgmsViewModel: ObservableObject {
    @Published var aboutData: AboutAdgmAttributes?
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?

    func fetchAboutAdgms(in view: UIView, completion: @escaping (Result<AboutAdgmAttributes?, Error>) -> Void) {
        isLoading = true
        let url = APIEndpoints.getAboutADGMData

        NetworkManager.shared.fetchData(from: url, in: view) { (result: Result<AboutAdgmModel, Error>) in
            DispatchQueue.main.async {
                self.isLoading = false
                switch result {
                case .success(let response):
                    if let data = response.data{
                        self.aboutData = data.first?.attributes
                        completion(.success(data.first?.attributes))
                    } else {
                        let error = NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data found"])
                        self.errorMessage = error.localizedDescription
                        completion(.failure(error))
                    }
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                    completion(.failure(error))
                }
            }
        }
    }
}
