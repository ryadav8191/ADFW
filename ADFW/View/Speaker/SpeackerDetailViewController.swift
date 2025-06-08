//
//  SpeackerDetailViewController.swift
//  ADFW
//
//  Created by MultiTV on 22/05/25.
//

import UIKit
import SwiftUI

class SpeackerDetailViewController: UIViewController {
    
    var speaker:Speakers?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let profile = SpeakerProfile(
            name: "H.E. Ahmed Jasim Al Zaabi",
            title: "Chairman, ADGM & Abu Dhabi Dept. Of Economic Development",
            descriptionShort: "His Excellency Ahmed Jasim Al Zaabi is member of the Abu Dhabi Executive Council and Chairman of the Abu Dhabi Department of Economic Development (ADDED), the catalyst for economic growth in the emirate. In this role, H.E. is spearheading strategies and initiatives to further enhance the soaring, diversified, smart, and sustainable “Falcon Economy”.A seasoned leader with a proven track record in delivering results, H.E. Al Zaabi has long-standing experience in the finance and investments sector, wherein he has managed and executed multi-billion-dollar investment transactions and led numerous restructurings and turnarounds across a multitude of sectors. H.E. is also the Chairman of Abu Dhabi Global Market (ADGM), the international financial centre located in the UAE capital and cementing Abu Dhabi’s status as a leading financial hub and “Capital of Capital”. At the helm of ADGM, H.E. has been",
            descriptionLong: "A seasoned leader with a proven track record in delivering results...",
            imageName: "speaker_photo", // This should be in Assets.xcassets
            tags: [
                Tag(title: "Abu Dhabi Economic Forum", color: .blue),
                Tag(title: "Asset Abu dhabi", color: .cyan),
                Tag(title: "Fintech Abu dhabi", color: .red),
                Tag(title: "R.A.C.E. Sustainability Summit", color: .gray)
            ]
        )
        if let data = speaker {
            let swiftUIView = SpeakerProfileView(profile: data) {
                self.navigationController?.popViewController(animated: true)
            }
            
            
            
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
    }
}



