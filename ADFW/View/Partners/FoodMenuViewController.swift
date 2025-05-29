//
//  FoodMenuViewController.swift
//  ADFW
//
//  Created by MultiTV on 26/05/25.
//

import UIKit
import SwiftUI

class FoodMenuViewController: UIViewController {

    override func viewDidLoad() {
            super.viewDidLoad()

            // Create the SwiftUI view
            let menuView = MenuView()

            // Embed the SwiftUI view using UIHostingController
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
