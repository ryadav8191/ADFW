//
//  SendMessageTableViewCell.swift
//  ADFW
//
//  Created by MultiTV on 01/07/25.
//

import UIKit

class SendMessageTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var messageLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        setupUI()
    }
    
    private func setupUI() {
        containerView.backgroundColor = UIColor.systemBlue
        messageLabel.textColor = .white
        containerView.layer.cornerRadius = 20
        containerView.layer.maskedCorners = [
            .layerMinXMinYCorner, // top-left
            .layerMinXMaxYCorner, // bottom-left
           // .layerMaxXMaxYCorner, // bottom-right
            .layerMaxXMinYCorner
        ]
        
        
        messageLabel.font = FontManager.font(weight: .medium, size: 15)
        containerView.clipsToBounds = true
    }
    
    func configure(with message: String) {
        messageLabel.text = message
    }
}
