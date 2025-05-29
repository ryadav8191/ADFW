//
//  BannerCollectionViewCell.swift
//  MSVC2025
//
//  Created by MultiTV on 27/03/25.
//

import UIKit
import AVFoundation

class BannerCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var imageLabel: UILabel!
    @IBOutlet weak var subLabel: UILabel!
    @IBOutlet weak var videoView: UIView!
    
    @IBOutlet weak var VolumeButton: UIButton!
    var playerLayer: AVPlayerLayer?
    var player: AVPlayer?
   
    private var isMuted = true

    @IBOutlet weak var muteButton: UIButton!
    var previousVolume : Float = 1.0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageLabel.font = FontManager.font(weight: .medium, size: 18)
        subLabel.font = FontManager.font(weight: .medium, size: 25)
        setupControls()
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        playerLayer?.frame = contentView.bounds
    }
    
    private func setupControls() {
        // Mute Button
//        muteButton.setImage(UIImage(systemName: "speaker.wave.2.fill"), for: .normal)
//        muteButton.tintColor = .white
//        muteButton.backgroundColor = UIColor.black.withAlphaComponent(0.4)
//        muteButton.layer.cornerRadius = 15
//        muteButton.addTarget(self, action: #selector(toggleMute), for: .touchUpInside)

        // Play/Pause Button (Optional)
//        playPauseButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
//        playPauseButton.tintColor = .white
//        playPauseButton.backgroundColor = UIColor.black.withAlphaComponent(0.4)
//        playPauseButton.layer.cornerRadius = 15
//        playPauseButton.addTarget(self, action: #selector(togglePlayPause), for: .touchUpInside)
    }
    
   

    @IBAction func toggleMute(_ sender: Any) {
//        isMuted.toggle()
//        player?.isMuted = isMuted
//        let icon = isMuted ? "speaker.slash.fill" : "speaker.wave.2.fill"
//        muteButton.setImage(UIImage(systemName: icon), for: .normal)
    }
    
    
    func configureWithVideo(url: URL) {
        // Configure player
        videoView.isHidden = false
        imageView.isHidden  = true
        player = AVPlayer(url: url)
        playerLayer = AVPlayerLayer(player: player)
        playerLayer?.frame = videoView.bounds
        playerLayer?.videoGravity = .resizeAspectFill
        
        if let layer = playerLayer {
            videoView.layer.addSublayer(layer)
        }
        player?.volume = 0.0
        
        // Optional: Loop the video
               NotificationCenter.default.addObserver(
                   self,
                   selector: #selector(loopVideo),
                   name: .AVPlayerItemDidPlayToEndTime,
                   object: player?.currentItem
               )
        
        updateVolumeButtonImage()
        
    }

        @objc private func loopVideo() {
            player?.seek(to: .zero)
            player?.play()
        }
    
    func setFallbackImage() {
           playerLayer?.removeFromSuperlayer()
           player = nil
           imageView.isHidden = false
           imageView.image = UIImage(named: "AboutDoha")
       }
    
    @IBAction func VolumeButtonPressed(_ sender: UIButton) {
        if let player = player {
            if player.volume == 0 {
                player.volume = previousVolume
            } else {
                previousVolume = player.volume
                player.volume = 0
            }
             updateVolumeButtonImage()
        }
        
    }
           
private func updateVolumeButtonImage() {
    if let player = player {
        if player.volume == 0 {
           
            VolumeButton.setImage(UIImage(systemName: "speaker.slash.fill"), for: .normal)
        } else {
            VolumeButton.setImage(UIImage(systemName: "speaker.wave.2.fill"), for: .normal)
        }
    }
}
    
    func pauseVideo() {
        player?.pause()
    }
    
    func configureWithImage(url: URL) {
        videoView.isHidden = true
            playerLayer?.removeFromSuperlayer()
            player = nil
            imageView.isHidden = false
        imageView.image = UIImage.loginBackground

        }
    
   
    func playVideo() {
        player?.play()
        
    }

    func stopVideo() {
        player?.pause()
        playerLayer?.removeFromSuperlayer()
        player = nil
        playerLayer = nil
    }


}
