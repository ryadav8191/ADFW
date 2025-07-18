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
    @IBOutlet weak var vidoePlayerButton: UIButton!
    
    @IBOutlet weak var locationView: UIView!
    
    var onPlayVideo: (() -> Void)?
    var viewDetail: (() -> Void)?
    
    @IBOutlet weak var spakerViewHeightConstraints: NSLayoutConstraint!
   
    
    @IBOutlet weak var agandaTypeImageView: UIImageView!
    
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
    
    
    
    func configure(with item: Agenda_sessions,location: String) {
        timeLabel.text = "\(item.fromTime ?? "") - \(item.toTime ?? "")"
        titleLabel.text = item.title
        typeLabel.text = item.sessionType?.name
        if location == nil || location == "" {
            locationLabel.text = ""
            locationView.isHidden = true
        } else {
            locationView.isHidden = false
            locationLabel.text = location
        }

        
        if let urlString = item.sessionType?.icon, let url = URL(string: urlString) {
            agandaTypeImageView.kf.setImage(with: url)
        }
        
        if item.publishVideo ?? false {
            vidoePlayerButton.isHidden = false
        } else {
            vidoePlayerButton.isHidden = true
        }

        
        // Clear old speaker images
        speakerStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        if let speakers = item.speakers {
            if speakers.count > 0 {
                spakerViewHeightConstraints.constant = 32
                for speaker in speakers {
                    let imageView = UIImageView()
                    imageView.contentMode = .scaleAspectFit
                    imageView.clipsToBounds = true
                    // imageView.layer.cornerRadius = 16
                    imageView.widthAnchor.constraint(equalToConstant: 32).isActive = true
                    imageView.heightAnchor.constraint(equalToConstant: 32).isActive = true
                    // Load image from URL using Kingfisher
                    if let urlString = speaker.photoUrl, let url = URL(string: urlString) {
                        imageView.kf.setImage(with: url)
                    }

                    speakerStackView.addArrangedSubview(imageView)
                }
            } else {
                spakerViewHeightConstraints.constant = 0
            }
       
        }

        
    }
    
    func configure(with item: FavouriteSessions,location: String) {
        timeLabel.text = "\(item.session_from_time ?? "") - \(item.session_to_time ?? "")"
        titleLabel.text = item.session_title
        typeLabel.text = item.session_type?.name
        locationLabel.text = location
        
        if let urlString = item.session_type?.icon, let url = URL(string: urlString) {
            agandaTypeImageView.kf.setImage(with: url)
        }
        
        if item.session_video == "" {
            vidoePlayerButton.isHidden = false
        } else {
            vidoePlayerButton.isHidden = true
        }

        
        // Clear old speaker images
        speakerStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        if let speakers = item.speakers {
            if speakers.count > 0 {
                spakerViewHeightConstraints.constant = 32
                for speaker in speakers {
                    let imageView = UIImageView()
                    imageView.contentMode = .scaleAspectFit
                    imageView.clipsToBounds = true
                    // imageView.layer.cornerRadius = 16
                    imageView.widthAnchor.constraint(equalToConstant: 32).isActive = true
                    imageView.heightAnchor.constraint(equalToConstant: 32).isActive = true
                    // Load image from URL using Kingfisher
                    if let urlString = speaker.photo_url, let url = URL(string: urlString) {
                        imageView.kf.setImage(with: url)
                    }

                    speakerStackView.addArrangedSubview(imageView)
                }
            } else {
                spakerViewHeightConstraints.constant = 0
            }
       
        }

        
    }
    
    
    @IBAction func videoButton(_ sender: Any) {
        onPlayVideo?()
        
    }
    
    
    
    @IBAction func ViewDetailButton(_ sender: Any) {
        
        viewDetail?()
    }
    
    
}


