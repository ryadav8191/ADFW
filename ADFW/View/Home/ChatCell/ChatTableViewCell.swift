//
//  ChatTableViewCell.swift
//  ADFW
//
//  Created by MultiTV on 01/07/25.
//

import UIKit

class ChatTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var lastChatLabel: UILabel!
    @IBOutlet weak var unReadCount: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        selectionStyle = .none
        
        configureUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureUI() {
        
        profileImageView.layer.cornerRadius = profileImageView.frame.height / 2
        userNameLabel.font = FontManager.font(weight: .semiBold, size: 14)
        
        lastChatLabel.font = FontManager.font(weight: .medium, size: 14)
        timeLabel.font = FontManager.font(weight: .semiBold, size: 10)
        
        unReadCount.font = FontManager.font(weight: .medium, size: 14)
        
    }
    
}
