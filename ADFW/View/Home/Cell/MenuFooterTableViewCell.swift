//
//  MenuFooterTableViewCell.swift
//  ADFW
//
//  Created by MultiTV on 16/05/25.
//

import UIKit

class MenuFooterTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var helpLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var followUsLabel: UILabel!
    
    @IBOutlet weak var instagramButton: UIButton!
    @IBOutlet weak var linkedinButton: UIButton!
    @IBOutlet weak var xButton: UIButton!
    @IBOutlet weak var youtubeButton: UIButton!
    @IBOutlet weak var socialMediaStackView: UIStackView!
    
    var openURL: ((String) -> Void)?
    var socialMediaList:[SocialMedia] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        helpLabel.font = FontManager.font(weight: .medium, size: 14)
        emailLabel.font = FontManager.font(weight: .medium, size: 14)
        followUsLabel.font = FontManager.font(weight: .medium, size: 14)
        
        emailLabel.isUserInteractionEnabled = true
        emailLabel.textColor = .blueColor
        let tap = UITapGestureRecognizer(target: self, action: #selector(emailTapped))
        emailLabel.addGestureRecognizer(tap)
        
        instagramButton.addTarget(self, action: #selector(instagramTapped), for: .touchUpInside)
        linkedinButton.addTarget(self, action: #selector(linkedinTapped), for: .touchUpInside)
        xButton.addTarget(self, action: #selector(xTapped), for: .touchUpInside)
        youtubeButton.addTarget(self, action: #selector(youtubeTapped), for: .touchUpInside)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func setupSocialButtons(with list: [SocialMedia]) {
        socialMediaStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }

        for media in list {
            guard let iconURLString = media.icon,
                  let iconURL = URL(string: iconURLString),
                  let urlString = media.url,
                  let url = URL(string: urlString) else { continue }

            // Create a container view to hold image
            let imageView = UIImageView()
            imageView.contentMode = .scaleAspectFit
            imageView.clipsToBounds = true
            imageView.tintColor = .label
            imageView.widthAnchor.constraint(equalToConstant: 32).isActive = true
            imageView.heightAnchor.constraint(equalToConstant: 32).isActive = true

            // Load image from URL
            imageView.setImage(with: iconURLString, placeholder: UIImage(systemName: "globe")) // Your image loader

            // Wrap image in a button to handle tap
            let button = UIButton(type: .system)
            button.addSubview(imageView)
            button.frame = CGRect(x: 0, y: 0, width: 32, height: 32)
            imageView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                imageView.centerXAnchor.constraint(equalTo: button.centerXAnchor),
                imageView.centerYAnchor.constraint(equalTo: button.centerYAnchor),
                imageView.widthAnchor.constraint(equalToConstant: 32),
                imageView.heightAnchor.constraint(equalToConstant: 32)
            ])

            button.addAction(UIAction { _ in
                UIApplication.shared.open(url)
            }, for: .touchUpInside)

            socialMediaStackView.addArrangedSubview(button)
        }
    }


    
    
    @objc func emailTapped() {
           openURL?("mailto:support@adfw.com")
       }

       @objc func instagramTapped() {
           openURL?("https://www.instagram.com/adfinanceweek/")
       }

       @objc func linkedinTapped() {
           openURL?("https://ae.linkedin.com/company/adfw")
       }

       @objc func xTapped() {
           openURL?("https://x.com/ADFinanceWeek")
       }

       @objc func youtubeTapped() {
           openURL?("https://www.youtube.com/@adfinanceweek")
       }
    
}
