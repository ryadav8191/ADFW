//
//  RestaurantItemsViewModel.swift
//  ADFW
//
//  Created by MultiTV on 20/06/25.
//


import UIKit

class MenuItemsViewModel: ObservableObject {
    @Published var menuItems: MenuData?

    func fetchMenuItems(for restaurantId: Int, in view: UIView) {
        let urlString = APIEndpoints.fetchItems(forRestaurantId: restaurantId)
        NetworkManager.shared.fetchData(from: urlString, in: view) { (result: Result<MenuModel, Error>) in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    self.menuItems = response.data
                case .failure(let error):
                    print("Error fetching menu items:", error.localizedDescription)
                }
            }
        }
    }
}
