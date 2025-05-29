//
//  EnterntainmentViewController.swift
//  ADFW
//
//  Created by MultiTV on 28/05/25.
//

import UIKit
import SwiftUI

class EnterntainmentViewController: UIViewController {

    override func viewDidLoad() {
           super.viewDidLoad()

           // Embed the SwiftUI view in UIKit using UIHostingController
           let entertainmentView = EntertainmentView()
           let hostingController = UIHostingController(rootView: entertainmentView)

           // Add the hosting controller as a child
           addChild(hostingController)
           view.addSubview(hostingController.view)

           // Set constraints
           hostingController.view.translatesAutoresizingMaskIntoConstraints = false
           NSLayoutConstraint.activate([
               hostingController.view.topAnchor.constraint(equalTo: view.topAnchor),
               hostingController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
               hostingController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
               hostingController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor)
           ])

           hostingController.didMove(toParent: self)
       }
   }
