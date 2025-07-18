//
//  TicketViewController.swift
//  ADFW
//
//  Created by MultiTV on 20/05/25.
//

import UIKit
import SwiftUI

enum PageType {
    case present
    case push
}

class TicketViewController: UIViewController {
    
    var pageType:PageType = .present

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        let swiftUIView = TicketView(onBack: { [weak self] in
            guard let self = self else { return }

           
                self.tabBarController?.selectedIndex = 0            
             
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
