//
//  SessionViewController.swift
//  ADFW
//
//  Created by MultiTV on 21/05/25.
//

import UIKit
import SwiftUI


class SessionViewController: UIViewController {
    
    var session:Session?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Embed SwiftUI View
        let swiftUIView = SessionOverviewView(session: session, onBack: { [weak self] in
            guard let self = self else { return }

            
            self.navigationController?.popViewController(animated: true)
            
            
            
        })
        let hostingController = UIHostingController(rootView: swiftUIView)

        addChild(hostingController)
        view.addSubview(hostingController.view)
        hostingController.didMove(toParent: self)

        // Add constraints
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            hostingController.view.topAnchor.constraint(equalTo: view.topAnchor),
            hostingController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            hostingController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            hostingController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
}
