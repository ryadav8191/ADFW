//
//  ReceiveTableViewCell.swift
//  ADFW
//
//  Created by MultiTV on 01/07/25.
//

import UIKit

class ReceiveTableViewCell: UITableViewCell {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var messageLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        
       // containerView.backgroundColor = UIColor(white: 0.95, alpha: 1.0) // Light gray background
        containerView.layer.cornerRadius = 20
        containerView.layer.maskedCorners = [
            .layerMaxXMinYCorner,
          //  .layerMinXMaxYCorner,
            .layerMaxXMaxYCorner,
            .layerMinXMinYCorner
        ]
        containerView.clipsToBounds = true
        messageLabel.textColor = .black
        messageLabel.font = FontManager.font(weight: .medium, size: 15)
      
    }
    
    func configure(with message: String) {
        messageLabel.text = message
    }
    
}
