//
//  AgendaTableViewCell.swift
//  ADFW
//
//  Created by MultiTV on 21/05/25.
//

import UIKit

class AgendaTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var speakerStackView: UIStackView!
    @IBOutlet weak var viewDetailsButton: UIButton!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var viewAllLabel: UILabel!
    
    var onPlayVideo: (() -> Void)?

    
    override func awakeFromNib() {
        super.awakeFromNib()
       // containerView.layer.cornerRadius = 10
        
        timeLabel.font = FontManager.font(weight: .medium, size: 14)
        titleLabel.font = FontManager.font(weight: .semiBold, size: 16)
        typeLabel.font = FontManager.font(weight: .medium, size: 13)
        locationLabel.font = FontManager.font(weight: .medium, size: 13)
        viewAllLabel.font = FontManager.font(weight: .medium, size: 14)
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowOpacity = 0.4
        containerView.layer.shadowOffset = CGSize(width: 0, height: 2)
        containerView.layer.shadowRadius = 4
        containerView.layer.cornerRadius = 3
        containerView.layer.masksToBounds = false
        selectionStyle = .none
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    
    func configure(with item: AgendaSession) {
        timeLabel.text = item.time
        titleLabel.text = item.title
        typeLabel.text = item.type
        locationLabel.text = item.location
        
        // Clear old speaker images
        speakerStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        for image in item.speakers {
            let imageView = UIImageView(image: image.image)
            imageView.contentMode = .scaleAspectFit
            imageView.clipsToBounds = true
           // imageView.layer.cornerRadius = 16
            imageView.widthAnchor.constraint(equalToConstant: 32).isActive = true
            imageView.heightAnchor.constraint(equalToConstant: 32).isActive = true
            speakerStackView.addArrangedSubview(imageView)
        }
    }
    
    
    @IBAction func videoButton(_ sender: Any) {
        
//        guard let url = URL(string: "https://yourdomain.com/video.mp4") else { return }
//
//            let storyboard = UIStoryboard(name: "Main", bundle: nil)
//            if let videoVC = storyboard.instantiateViewController(withIdentifier: "VideoPlayerViewController") as? VideoPlayerViewController {
//                videoVC.videoURL = url
//                videoVC.modalPresentationStyle = .fullScreen
//                self.present(videoVC, animated: true)
//            }
        
        onPlayVideo?()
        
    }
    
}


