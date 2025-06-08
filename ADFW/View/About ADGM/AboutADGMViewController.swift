//
//  AboutADGMViewController.swift
//  ADFW
//
//  Created by MultiTV on 23/05/25.
//

import UIKit
import SwiftUI

class AboutADGMViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let swiftUIView = MainView(onBack: { [weak self] in
            guard let self = self else { return }

            self.navigationController?.popViewController(animated: true)

        })
        
        let hostingController = UIHostingController(rootView: swiftUIView)
        addChild(hostingController)
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(hostingController.view)
        NSLayoutConstraint.activate([
            hostingController.view.topAnchor.constraint(equalTo: view.topAnchor),
            hostingController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            hostingController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            hostingController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        hostingController.didMove(toParent: self)
    }
    
//    {
//        self.dismiss(animated: true, completion: nil)
//    }
    
}
