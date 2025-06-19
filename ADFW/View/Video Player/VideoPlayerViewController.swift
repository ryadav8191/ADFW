//
//  VideoPlayerViewController.swift
//  ADFW
//
//  Created by MultiTV on 26/05/25.
//



import YouTubeiOSPlayerHelper
import UIKit

class VideoPlayerViewController: UIViewController, YTPlayerViewDelegate {

    private var playerView: YTPlayerView!
    var videoID: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black

        // Lock to landscape immediately
        AppUtility.lockOrientation(.landscapeRight, andRotateTo: .landscapeRight)

        // Setup YouTube player
        playerView = YTPlayerView()
        playerView.delegate = self
        playerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(playerView)

        NSLayoutConstraint.activate([
            playerView.topAnchor.constraint(equalTo: view.topAnchor),
            playerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            playerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            playerView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])

        let playerVars: [String: Any] = [
            "playsinline": 0,
            "autoplay": 1,
            "modestbranding": 1,
            "rel": 0,
            "fs": 1
        ]

        playerView.load(withVideoId: videoID
                        , playerVars: playerVars)

        addBackButton()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // Reset to portrait when leaving
        AppUtility.lockOrientation(.portrait, andRotateTo: .portrait)
    }

    func addBackButton() {
        let backButton = UIButton(type: .system)
        backButton.setTitle("✕", for: .normal)
        backButton.setTitleColor(.white, for: .normal)
        backButton.titleLabel?.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        backButton.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        backButton.layer.cornerRadius = 25
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.addTarget(self, action: #selector(dismissSelf), for: .touchUpInside)
        view.addSubview(backButton)

        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            backButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            backButton.widthAnchor.constraint(equalToConstant: 50),
            backButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    @objc func dismissSelf() {
        AppUtility.lockOrientation(.portrait, andRotateTo: .portrait)
        dismiss(animated: true, completion: nil)
    }

    func playerViewDidBecomeReady(_ playerView: YTPlayerView) {
        playerView.playVideo()
    }
}
