//
//  SocialMediaActivityViewController.swift
//  ADFW
//
//  Created by MultiTV on 21/05/25.
//

import UIKit
import SwiftUI

let samplePosts: [SocialPost] = [
    SocialPost(
        platform: .instagram,
        imageName: "post1",
        title: "ADGM's contribution to Abu Dhabi’s stature...",
        description: "H.E. Ahmed Jasim Al Zaabi, Chairman of ADGM, highlights ADGM's pivotal role in driving Abu Dhabi's economy forward, reflecting its strategic vision and commitment to excellence. ADGM's exceptional performance in H1 2024 positions the UAE as a leading global financial powerhouse.",
        tags: "#ADGM #AhmedJasimAlZaabi #EconomicLeadership #StrategicVision #Excellence"
    ),
    SocialPost(
        platform: .facebook,
        imageName: "post2",
        title: "EXPERIENCE THE WORLD'S FIRST MEDIATION IN THE METAVERSE SERVICE",
        description: "H.E. Ahmed Jasim Al Zaabi, Chairman of ADGM, highlights ADGM's pivotal role in driving Abu Dhabi's economy forward, reflecting its strategic vision and commitment to excellence. ADGM's exceptional performance in H1 2024 positions the UAE as a leading global financial powerhouse.",
        tags: "#MediationInTheMetaverse #ADGMArbitrationCentre #Web3Innovation #Sustainability"
    ),
    SocialPost(
        platform: .website,
        imageName: "post3",
        title: "WHAT ARE THE SIX LEGAL BASIS FOR PROCESSING IN THE ADGM DATA PROTECTION REGULATIONS?",
        description: "H.E. Ahmed Jasim Al Zaabi, Chairman of ADGM, highlights ADGM's pivotal role in driving Abu Dhabi's economy forward, reflecting its strategic vision and commitment to excellence. ADGM's exceptional performance in H1 2024 positions the UAE as a leading global financial powerhouse.",
        tags: "#DataProtection #PrivacyMatters #ADGM #ProactivePrivacy"
    )
]


class SocialMediaActivityViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

//        // Embed SwiftUI View
        // Embed SwiftUI View
        let swiftUIView = SocialMediaActivityView(posts: samplePosts, onBack: { [weak self] in
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
