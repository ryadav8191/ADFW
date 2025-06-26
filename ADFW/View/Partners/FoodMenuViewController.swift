//
//  FoodMenuViewController.swift
//  ADFW
//
//  Created by MultiTV on 26/05/25.
//

import UIKit
import SwiftUI

class FoodMenuViewController: UIViewController {
    
    let viewModel = MenuItemsViewModel()
    var id = 0

    override func viewDidLoad() {
            super.viewDidLoad()

        viewModel.fetchMenuItems(for: id, in: self.view)
        let menuView = MenuView(viewModel: viewModel) {
            self.navigationController?.popViewController(animated: true)
        }
        let hostingController = UIHostingController(rootView: menuView)
            // Add as child
            addChild(hostingController)
            hostingController.view.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(hostingController.view)
            hostingController.didMove(toParent: self)

            // Constraints
            NSLayoutConstraint.activate([
                hostingController.view.topAnchor.constraint(equalTo: view.topAnchor),
                hostingController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                hostingController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                hostingController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            ])
        }
    }
