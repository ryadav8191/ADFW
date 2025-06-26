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
    
    var openURL: ((String) -> Void)?
    
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
