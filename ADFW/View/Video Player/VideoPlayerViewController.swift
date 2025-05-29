//
//  VideoPlayerViewController.swift
//  ADFW
//
//  Created by MultiTV on 26/05/25.
//


import UIKit
import AVKit

import AVFoundation

class VideoPlayerViewController: AVPlayerViewController, AVPlayerViewControllerDelegate {

    var videoURL: URL?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // If videoURL was not set externally, set a default
        if videoURL == nil {
            videoURL = URL(string: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4")
        }
        
        if let url = videoURL {
            self.player = AVPlayer(url: url)
            self.player?.play()
        }
     
        self.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        UIDevice.current.setValue(UIInterfaceOrientation.landscapeRight.rawValue, forKey: "orientation")
//        AppUtility.lockOrientation(.landscapeRight)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
       // AppUtility.lockOrientation(.portrait, andRotateTo: .portrait)
    }
    

      func playerViewControllerWillDismiss(_ playerViewController: AVPlayerViewController) {
         
        //  AppUtility.lockOrientation(.landscape, andRotateTo: .portrait)
      }

}
