//
//  NotificationViewController.swift
//  ADFW
//
//  Created by MultiTV on 20/05/25.
//

import UIKit
import SwiftUI

class NotificationViewController: UIViewController {
    
    private let viewModel = NotificationViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        let swiftUIView = NotificationView(viewModel: viewModel, onBack: { [weak self] in
            guard let self = self else { return }

            self.navigationController?.popViewController(animated: true)

            // Or if it's presented modally:
            // self.dismiss(animated: true)
        })
        let hostingController = UIHostingController(rootView: swiftUIView)

        addChild(hostingController)
        view.addSubview(hostingController.view)
        hostingController.didMove(toParent: self)

        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            hostingController.view.topAnchor.constraint(equalTo: view.topAnchor),
            hostingController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            hostingController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            hostingController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])

    }
    

    
}
