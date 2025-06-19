//
//  VenueViewModel.swift
//  ADFW
//
//  Created by MultiTV on 18/06/25.
//


import Foundation
import UIKit

class VenueViewModel {

    func fetchVenueData(in view: UIView, completion: @escaping (Result<[Locations], Error>) -> Void) {
        let urlString = APIEndpoints.getVenue

        NetworkManager.shared.fetchData(from: urlString, in: view) { (result: Result<VenueResponse, Error>) in
            switch result {
            case .success(let decoded):
                let validVenues: [Locations] = (decoded.data ?? []).compactMap { venueData in
                    guard
                        let attributes = venueData.attributes,
                        let name = attributes.name,
                        let latString = attributes.latitude,
                        let lonString = attributes.longitude,
                        let lat = Double(latString),
                        let lon = Double(lonString)
                    else {
                        return nil
                    }

                    return Locations(
                        name: name,
                        subtitle: "View more details",
                        latitude: lat,
                        longitude: lon,
                        imageName: attributes.image ?? ""
                    )
                }
                completion(.success(validVenues))

            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
